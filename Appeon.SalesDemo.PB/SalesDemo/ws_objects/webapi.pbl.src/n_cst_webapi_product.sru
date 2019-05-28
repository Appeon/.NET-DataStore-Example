$PBExportHeader$n_cst_webapi_product.sru
forward
global type n_cst_webapi_product from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_product from n_cst_webapi_base autoinstantiate
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type

type variables

end variables

forward prototypes
public function integer of_retrieve (ref u_dw adw_data, string as_data, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_winopen (ref u_dw adw_category, ref u_dw adw_browser, ref u_dw adw_master)
public function integer of_saveproductphoto (long al_productid, string as_filename, blob abb_data)
public function integer of_delete (ref u_dw adw_browser)
public function integer of_deleteproductbykey (long al_productid)
public function integer of_savechanges (ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_deletesubcatebykey (long al_subcateid)
end prototypes

public function integer of_retrieve (ref u_dw adw_data, string as_data, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
jsonpackage ljs_pak
String ls_json
String ls_url
String ls_photo
String ls_photoname
String ls_directory_temp
String ls_dataobject
Integer li_filenum
Blob  lblb_photo
CoderObject lnv_CoderObject

lstr_am.s_arm[1] = adw_data.dataobject
lstr_am.s_arm[2] = as_data
ls_url = of_get_url("retrieve")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

ls_dataobject = adw_data.dataobject
Choose Case ls_dataobject
	Case "d_subcategory"
		ls_json = ljs_pak.getvalue("SubCategory")
	Case "d_product"
		ls_json = ljs_pak.getvalue("Product")
	Case "d_history_price"
		ls_json = ljs_pak.getvalue("HistoryPrice")
End Choose

adw_data.SetRedraw(False)
adw_detail.Reset()
adw_data.Reset()
adw_data.ImportJsonByKey(ls_json)
adw_data.SetRedraw(True)
adw_data.ResetUpdate()
adw_detail.ResetUpdate()

Choose Case ls_dataobject
	Case "d_product"
		adw_master.Reset()
		adw_master.ImportJsonByKey(ls_json)
		adw_master.ResetUpdate()
				ls_json = ljs_pak.GetValue("dddwSubCategory") 
		adw_master.of_importjson_dddw("productsubcategoryid", ls_json)
	Case "d_history_price"
		ls_photo = ljs_pak.getvalue("photo")  
		ls_photoname = ljs_pak.getvalue("photoname") 
		
		IF len(ls_photoname) > 0 Then
			lnv_CoderObject = Create CoderObject
			lblb_photo = lnv_CoderObject.Base64Decode(ls_photo)	
			
			//Write file
			ls_directory_temp = "c:\appeon\"
			IF Not DirectoryExists (ls_directory_temp) Then
				CreateDirectory(ls_directory_temp)
			End IF
			
			ls_photoname = ls_directory_temp +ls_photoname

			filedelete(ls_photoname)
			li_filenum = fileopen(ls_photoname, StreamMode!, Write!, LockWrite!)	
			FileWriteEx(li_filenum, lblb_photo)
			fileclose(li_filenum)		
		Else
			ls_photoname = ""
		End IF
		adw_master.modify("p_1.filename='"+ls_photoname+"'")
		
		ls_json = ljs_pak.GetValue("dddwProduct") 
		adw_detail.of_importjson_dddw("productid", ls_json)
End Choose

Destroy(ljs_pak)

Return 1
end function

public function integer of_winopen (ref u_dw adw_category, ref u_dw adw_browser, ref u_dw adw_master);str_arm lstr_am
JsonPackage ljs_pak
String ls_json
String ls_url
Long   ll_cateid

ls_url = of_get_url("winopen")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)

//Import category
ls_json = ljs_pak.getvalue("Category")
adw_category.of_importjson_dddw("id", ls_json)
adw_browser.of_importjson_dddw("productcategoryid", ls_json)

ll_cateid = Long(ljs_pak.getvalue("CateId"))
adw_category.Setitem(1, "id", ll_cateid)

//Import subcategory
adw_browser.SetRedraw(False)
ls_json = ljs_pak.getvalue("SubCategory")
adw_browser.importjsonbykey(ls_json)
adw_browser.ResetUpdate()
adw_browser.SetRedraw(True)

//Import dddw
ls_json = ljs_pak.getvalue("Units")
adw_master.of_importjson_dddw("weightunitmeasurecode", ls_json)
adw_master.of_importjson_dddw("sizeunitmeasurecode", ls_json)

Destroy(ljs_pak)

Return 1
end function

public function integer of_saveproductphoto (long al_productid, string as_filename, blob abb_data);String ls_url
Integer li_ret
str_arm lstr_am
jsonpackage ljs_pak
CoderObject lnv_CoderObject 

lstr_am.s_arm[1] = String(al_productid)
lstr_am.s_arm[2] = as_filename

lnv_CoderObject = Create CoderObject
lstr_am.s_arm[3] = lnv_CoderObject.Base64Encode(abb_data)
Destroy lnv_CoderObject

ls_url =of_get_url("SaveProductPhoto")
inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Save")

Return li_ret
end function

public function integer of_delete (ref u_dw adw_browser);Integer li_ret
String   ls_url
str_arm lstr_am
jsonpackage ljs_pak

lstr_am.dw_arm[1] = adw_browser
lstr_am.s_arm[1] = "SubCategory"
ls_url = of_get_url("Delete")

inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy(ljs_pak)

Return li_ret
end function

public function integer of_deleteproductbykey (long al_productid);str_arm lstr_am
jsonpackage ljs_pak
String   ls_url
Integer li_ret

lstr_am.s_arm[1] = String(al_productid)
ls_url = of_get_url("DeleteProductByKey")

inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy ljs_pak

Return li_ret
end function

public function integer of_savechanges (ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
JsonPackage ljs_pak
String   ls_url
String   ls_json
Integer li_cnt
Integer li_ret
Integer li_subcaterow
Integer li_productrow
DwItemStatus ldws_substatus
DwItemStatus ldws_productstatus

li_cnt = 0

IF adw_browser.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_browser
	lstr_am.s_arm[li_cnt] = "SubCategory"
	
	li_subcaterow = adw_browser.GetRow()
	ldws_substatus = adw_browser.GetItemStatus(li_subcaterow, 0, Primary!)
End IF

IF adw_master.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_master
	lstr_am.s_arm[li_cnt] = "Product"	
	
	li_productrow = adw_master.GetRow()
	ldws_productstatus = adw_master.GetItemStatus(li_productrow, 0, Primary!)
End IF

IF adw_detail.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_detail
	lstr_am.s_arm[li_cnt] = "HistoryPrice"
End IF

adw_browser.SetRedraw(False)
adw_master.SetRedraw(False)
IF lstr_am.s_arm[1] = "SubCategory" Then
	IF li_cnt = 1 Then
		ls_url =  of_get_url("SaveChanges")	
		inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
	Else
		ls_url = of_get_url("SaveHistoryPrices")
		inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
	End IF
	
	li_ret = of_get_servicestatus(ljs_pak, "Save")
	
	IF li_ret = 1 Then
		IF li_cnt = 1 And ldws_substatus = NewModified! Then
			ls_json = ljs_pak.GetValue("SubCategory")
			of_json_object2arrary(ls_json)
			adw_browser.ImportJsonbyKey(ls_json)		
			adw_browser.DeleteRow(li_subcaterow)
			
		ElseIF ldws_productstatus = NewModified! Then
			IF ldws_substatus = NewModified! Then
				ls_json = ljs_pak.GetValue("SubCategory")
				of_json_object2arrary(ls_json)
				adw_browser.ImportJsonbyKey(ls_json)	
				adw_browser.DeleteRow(li_subcaterow)
				
			End IF			
				ls_json = ljs_pak.GetValue("Product")
				of_json_object2arrary(ls_json)
				adw_master.DeleteRow(li_productrow)
				adw_master.ImportJsonbyKey(ls_json)					
		End IF
	End IF
Else
	Choose Case li_cnt
		Case 1
			ls_url = of_get_url("SaveChanges")
			inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
			li_ret = of_get_servicestatus(ljs_pak, "Save")
			
			IF li_ret = 1 And ldws_productstatus = NewModified! Then
				ls_json = ljs_pak.GetValue("Product")
				of_json_object2arrary(ls_json)
				adw_master.DeleteRow(li_productrow)
				adw_master.ImportJsonbyKey(ls_json)		
			End IF
		Case 2		
			ls_url = of_get_url("SaveProductTwotier")
			inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
			
			li_ret = of_get_servicestatus(ljs_pak, "Save")			
			IF li_ret = -1 Then Return -1
			
			IF  ldws_productstatus = NewModified! Then
				ls_json =  ljs_pak.GetValue("Product")
				of_json_object2arrary(ls_json)	
				adw_master.DeleteRow(li_productrow)
				adw_master.ImportJsonByKey(ls_json)	
			End IF	
			
	End Choose
End IF

adw_browser.SetRedraw(True)
adw_master.SetRedraw(True)
IF li_ret = 1 Then
	adw_browser.ResetUpdate()
	adw_master.ResetUpdate()
	adw_detail.ResetUpdate()
End IF

Destroy(ljs_pak)

Return li_ret
end function

public function integer of_deletesubcatebykey (long al_subcateid);str_arm lstr_am
jsonpackage ljs_pak
String   ls_url
Integer li_ret

lstr_am.s_arm[1] = String(al_subcateid)
ls_url = of_get_url("DeleteSubcategoryByKey")

inv_httpclient.of_execute_func(ls_url, lstr_am, ljs_pak)
li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy ljs_pak

Return li_ret
end function

on n_cst_webapi_product.create
call super::create
end on

on n_cst_webapi_product.destroy
call super::destroy
end on

event constructor;call super::constructor;is_controllername = 'product'
end event

