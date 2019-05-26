$PBExportHeader$n_cst_webapi_person.sru
forward
global type n_cst_webapi_person from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_person from n_cst_webapi_base autoinstantiate
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type

type variables

end variables

forward prototypes
public function integer of_retrievepersonbykey (long al_businessentityid, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer)
public function integer of_saveperson (ref u_dw adw_persondetail, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer)
public function integer of_savechanges (ref u_dw adw_master, u_dw adw_detail, u_dw adw_cust)
public function integer of_deletebykey (str_person_parm astr_parm)
public function integer of_winopen (ref u_dw adw_browser, ref u_dw adw_list, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer)
end prototypes

public function integer of_retrievepersonbykey (long al_businessentityid, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url

lstr_am.s_arm[1] = String(al_businessentityid)
ls_url = of_get_url("RetrievePersonByKey")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

adw_master.SetRedraw(False)
adw_detail.SetRedraw(False)
adw_customer.SetRedraw(False)

ls_json = ljs_pak.GetValue("Person.PersonAddress")
adw_master.Reset()
adw_master.ImportJsonByKey(ls_json)
adw_master.ResetUpdate()

ls_json = ljs_pak.GetValue("Person.PersonPhone")
adw_detail.Reset()
adw_detail.ImportJsonByKey(ls_json)
adw_detail.ResetUpdate()

ls_json = ljs_pak.GetValue("Person.Customer")
adw_customer.Reset()
adw_customer.ImportJsonByKey(ls_json)
adw_customer.ResetUpdate()

adw_master.SetRedraw(True)
adw_detail.SetRedraw(True)
adw_customer.SetRedraw(True)
		
Return 1
end function

public function integer of_saveperson (ref u_dw adw_persondetail, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer);Integer li_ret
Integer li_row
String   ls_url
String   ls_json
DwItemStatus ldws_status
str_arm lstr_am
JsonPackage ljs_pak

lstr_am.dw_arm[1] = adw_persondetail
lstr_am.dw_arm[2] = adw_master
lstr_am.dw_arm[3] = adw_detail
lstr_am.dw_arm[4] = adw_customer

li_row = adw_persondetail.GetRow()
ldws_status = adw_persondetail.GetItemStatus(li_row, 0, Primary!)

ls_url = of_get_url("SavePerson")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Save")

adw_persondetail.SetReDraw(False)
adw_master.SetReDraw(False)
adw_detail.SetReDraw(False)
adw_customer.SetReDraw(False)
IF li_ret = 1 Then
	IF ldws_status = Newmodified! Then
		adw_persondetail.Deleterow(li_row)
		adw_master.Reset()
		adw_detail.Reset()
		adw_customer.Reset()
		
		ls_json =  ljs_pak.GetValue("Person")
		of_json_object2arrary(ls_json)
		adw_persondetail.importjsonbykey(ls_json)
		
		ls_json =  ljs_pak.GetValue("Person.PersonAddress")
		adw_master.importjsonbykey(ls_json)
		
		ls_json =  ljs_pak.GetValue("Person.PersonPhone")
		adw_detail.importjsonbykey(ls_json)
		
		ls_json =  ljs_pak.GetValue("Person.Customer")
		adw_customer.importjsonbykey(ls_json)		
	End IF
	
	adw_persondetail.ResetUpdate()
	adw_master.ResetUpdate()
	adw_detail.ResetUpdate()
	adw_customer.ResetUpdate()
End IF
adw_persondetail.SetReDraw(True)
adw_master.SetReDraw(True)
adw_detail.SetReDraw(True)
adw_customer.SetReDraw(True)

Return li_ret
end function

public function integer of_savechanges (ref u_dw adw_master, u_dw adw_detail, u_dw adw_cust);Integer li_ret
String   ls_url
String   ls_jsonaddress
String   ls_jsonphone
String   ls_customer
str_arm lstr_am
JsonPackage ljs_pak

lstr_am.dw_arm[1] = adw_master
lstr_am.dw_arm[2] = adw_detail
lstr_am.dw_arm[3] = adw_cust

ls_url = of_get_url("Savechanges")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Save")

adw_master.SetReDraw(False)
adw_detail.SetReDraw(False)
adw_cust.SetReDraw(False)
IF li_ret = 1 Then
	adw_master.ReSet()
	adw_detail.ReSet()
	adw_cust.ReSet()
	
	ls_jsonaddress = ljs_pak.GetValue("Person.PersonAddress")
	ls_jsonphone = ljs_pak.GetValue("Person.PersonPhone")
	ls_customer = ljs_pak.GetValue("Person.Customer")
	
	adw_master.ImportJsonByKey(ls_jsonaddress)
	adw_detail.ImportJsonByKey(ls_jsonphone)
	adw_cust.ImportJsonByKey(ls_customer)
	
	adw_master.ResetUpdate()
	adw_detail.ResetUpdate()
	adw_cust.ResetUpdate()
End IF

adw_master.SetReDraw(True)
adw_detail.SetReDraw(True)
adw_cust.SetReDraw(True)

Destroy(ljs_pak)

Return li_ret
end function

public function integer of_deletebykey (str_person_parm astr_parm);Integer li_ret
String  ls_url
str_arm lstr_am
jsonpackage ljs_pak

lstr_am.s_arm[1] =  astr_parm.table
Choose Case astr_parm.table
	Case "Person"
		lstr_am.s_arm[2] =  String(astr_parm.personid)
	Case "PersonAddress"
		lstr_am.s_arm[2] =  String(astr_parm.personid)
		lstr_am.s_arm[3] =  String(astr_parm.addressid)
		lstr_am.s_arm[4] =  String(astr_parm.addresstypeid)
	Case "PersonPhone"
		lstr_am.s_arm[2] =  String(astr_parm.personid)
		lstr_am.s_arm[3] =  astr_parm.phonenumber
		lstr_am.s_arm[4] =  String(astr_parm.phonetypeid)
	Case "Customer"
		lstr_am.s_arm[2] =  String(astr_parm.personid)
		lstr_am.s_arm[3] =  String(astr_parm.customerid)
End Choose

ls_url = of_get_url("DeleteByKey")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

li_ret = of_get_servicestatus(ljs_pak, "Delete")
Destroy(ljs_pak)

Return li_ret

end function

public function integer of_winopen (ref u_dw adw_browser, ref u_dw adw_list, ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_customer);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url

//Retrieve Dddw
ls_url = of_get_url("winopen")

IF Not IsValid(w_progressbar) Then Open(w_progressbar)
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
w_progressbar.hpb_1.position = 80

adw_browser.SetRedraw(False)
adw_list.SetRedraw(False)

ls_json = ljs_pak.GetValue("Person")
adw_browser.Reset()
adw_list.Reset()
adw_browser.ImportJsonByKey(ls_json)
adw_list.ImportJsonByKey(ls_json)
adw_browser.ResetUpdate()
adw_list.ResetUpdate()

adw_browser.SetRedraw(True)
adw_list.SetRedraw(True)

ls_json = ljs_pak.GetValue("Address")
adw_master.of_importjson_dddw("addressid", ls_json)

ls_json = ljs_pak.GetValue("AddressType")
adw_master.of_importjson_dddw("addresstypeid", ls_json)

ls_json = ljs_pak.GetValue("PhonenumberType")
adw_detail.of_importjson_dddw("phonenumbertypeid", ls_json)

ls_json = ljs_pak.GetValue("CustomerTerritory")
adw_customer.of_importjson_dddw("territoryid", ls_json)

w_progressbar.hpb_1.position = 100
ls_json = ljs_pak.GetValue("Store")
adw_customer.of_importjson_dddw("storeid", ls_json)

IF IsValid(w_progressbar) Then Close(w_progressbar)

Return 1
end function

on n_cst_webapi_person.create
call super::create
end on

on n_cst_webapi_person.destroy
call super::destroy
end on

event constructor;call super::constructor;is_controllername = "Person"
end event

