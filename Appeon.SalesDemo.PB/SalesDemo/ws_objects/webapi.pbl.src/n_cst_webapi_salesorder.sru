$PBExportHeader$n_cst_webapi_salesorder.sru
forward
global type n_cst_webapi_salesorder from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_salesorder from n_cst_webapi_base autoinstantiate
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type

type variables

end variables

forward prototypes
public function integer of_retrievedddw (long al_customerid, ref datawindowchild adwc_billtoaddressid, ref datawindowchild adwc_shiptoaddressid, ref datawindowchild adwc_creditcardid)
public function integer of_retrievesaleorderdetail (long al_salesorderdetailid, long al_customerid, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_retrievesalesorderlist (long al_customerid, datetime adt_date_from, datetime adt_date_to, ref u_dw adw_browser, ref u_dw adw_master)
public function integer of_savechanges (ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_browser)
public function integer of_deletesalesorderbykey (string as_dwname, long al_salesorderid, long al_salesorderdetailid)
end prototypes

public function integer of_retrievedddw (long al_customerid, ref datawindowchild adwc_billtoaddressid, ref datawindowchild adwc_shiptoaddressid, ref datawindowchild adwc_creditcardid);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url

lstr_am.s_arm[1] = "Customer"
lstr_am.s_arm[2] = String(al_customerid)
ls_url = of_get_url("RetrieveDropdownModel")

//Send Request and get a JsonPackage
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

ls_json = ljs_pak.GetValue("DddwAddress")

adwc_billtoaddressid.ImportJsonByKey(ls_json)
adwc_shiptoaddressid.ImportJsonByKey(ls_json)

ls_json = ljs_pak.GetValue("DddwCreditcard")
adwc_creditcardid.ImportJsonByKey(ls_json)

Return 1
end function

public function integer of_retrievesaleorderdetail (long al_salesorderdetailid, long al_customerid, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
jsonpackage ljs_pak
DataWindowChild ldwc_child
String ls_json
String ls_url

//Request data
lstr_am.s_arm[1] = String(al_salesorderdetailid)
lstr_am.s_arm[2] = String(al_customerid)
ls_url = of_get_url("RetrieveSaleOrderDetail")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

//Import JSON
adw_detail.SetRedraw(False)
ls_json = ljs_pak.GetValue("SalesOrderDetail")
adw_detail.reset()
adw_detail.ImportJsonByKey(ls_json)
adw_detail.ResetUpdate()
adw_detail.SetRedraw(True)

ls_json = ljs_pak.GetValue("DddwAddress")
adw_master.of_importjson_dddw("billtoaddressid", ls_json)
adw_master.of_importjson_dddw("shiptoaddressid", ls_json)

ls_json = ljs_pak.GetValue("DddwCreditcard")
adw_master.of_importjson_dddw("creditcardid", ls_json)

Return 1
end function

public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url

//Retrieve dddw data
ls_url = of_get_url("winopen")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

//Customer
ls_json = ljs_pak.GetValue("Customer")
adw_filter.of_importjson_dddw("customer",  ls_json, true) 
adw_browser.of_importjson_dddw("customerid", ls_json)
adw_master.of_importjson_dddw("customerid", ls_json)

//SalesPerson
ls_json = ljs_pak.GetValue("SalesPerson")
adw_browser.of_importjson_dddw("salespersonid", ls_json)
adw_master.of_importjson_dddw("salespersonid", ls_json)

//SalesTerritory
ls_json = ljs_pak.GetValue("SalesTerritory")
adw_browser.of_importjson_dddw("territoryid", ls_json)
adw_master.of_importjson_dddw("territoryid", ls_json)

//ShipMethod
ls_json = ljs_pak.GetValue("ShipMethod")
adw_browser.of_importjson_dddw("shipmethodid", ls_json)
adw_master.of_importjson_dddw("shipmethodid", ls_json)

//OrderProduct
ls_json = ljs_pak.GetValue("OrderProduct")
adw_detail.of_importjson_dddw("productid", ls_json )

Return 1
end function

public function integer of_retrievesalesorderlist (long al_customerid, datetime adt_date_from, datetime adt_date_to, ref u_dw adw_browser, ref u_dw adw_master);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url

lstr_am.s_arm[1] = String(al_customerid)
lstr_am.s_arm[2] = String(adt_date_from)
lstr_am.s_arm[3] = String(adt_date_to)

ls_url = of_get_url("RetrieveSaleOrderList")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

ls_json = ljs_pak.GetValue("SalesOrderHeader")

adw_browser.SetRedraw(False)
adw_master.SetRedraw(False)
adw_browser.Reset()
adw_browser.ImportJsonByKey(ls_json)
adw_browser.ResetUpdate()

adw_master.Reset()
adw_master.ImportJsonByKey(ls_json)
adw_master.ResetUpdate()

adw_browser.SetRedraw(True)
adw_master.SetRedraw(True)

Return 1
end function

public function integer of_savechanges (ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_browser);Integer li_cnt
Integer li_ret
String   ls_url
String   ls_json
String   ls_data
str_arm lstr_am
JsonPackage ljs_pak

li_cnt = 0
IF adw_master.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_master
	lstr_am.s_arm[li_cnt] = "SaleOrderHeader"
End IF

IF adw_detail.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_detail
	lstr_am.s_arm[li_cnt] = "SaleOrderDetail"
End IF

Choose Case li_cnt
	Case 1
		ls_url = of_get_url("SaveChanges")		
	Case 2
		ls_url = of_get_url("SaveSalesOrderAndDetail")			
End Choose

inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Save")

adw_master.SetRedraw(False)
adw_detail.SetRedraw(False)
IF adw_master.GetItemStatus(adw_master.GetRow(), 0, Primary!) = NewModified! Then		
	ls_json = ljs_pak.GetValue("SalesOrderHeader")
	of_json_object2arrary(ls_json)		
	adw_master.Deleterow(adw_master.GetRow())
	adw_master.ImportJsonByKey(ls_json)
End IF

IF li_cnt = 2 OR lstr_am.s_arm[1] = "SaleOrderDetail" Then
	adw_detail.ReSet()
	ls_json = ljs_pak.GetValue("SalesOrderHeader.SalesOrderDetail")
	adw_detail.ImportJsonByKey(ls_json)
End IF

adw_master.SetRedraw(True)
adw_detail.SetRedraw(True)

adw_master.ResetUpdate()
adw_detail.ResetUpdate()

Destroy(ljs_pak)

Return 1
end function

public function integer of_deletesalesorderbykey (string as_dwname, long al_salesorderid, long al_salesorderdetailid);str_arm lstr_am
JsonPackage ljs_pak
String ls_url
Integer li_ret

lstr_am.s_arm[1] = as_dwname
lstr_am.s_arm[2] = String(al_salesorderid)
lstr_am.s_arm[3] = String(al_salesorderdetailid)

ls_url = of_get_url("DeleteSalesOrderByKey")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy(ljs_pak)
			
Return li_ret
end function

on n_cst_webapi_salesorder.create
call super::create
end on

on n_cst_webapi_salesorder.destroy
call super::destroy
end on

event constructor;call super::constructor;This.is_controllername = "salesorder"
end event

