$PBExportHeader$n_cst_httpclient.sru
forward
global type n_cst_httpclient from nonvisualobject
end type
end forward

global type n_cst_httpclient from nonvisualobject autoinstantiate
end type

type variables
httpclient inv_client
end variables

forward prototypes
public function integer of_getdata (string as_url, datawindow adw_data)
public function integer of_getdata_package (string as_url, ref jsonpackage anv_pak)
public function integer of_execute_func (string as_url, str_arm astr_am, ref jsonpackage anv_pak)
end prototypes

public function integer of_getdata (string as_url, datawindow adw_data);string   ls_json
string   ls_url
integer li_ret
jsonpackage lnv_pak 

ls_url = as_url
lnv_pak = create jsonpackage

li_ret = of_getdata_package(ls_url, lnv_pak)
if li_ret > 0 then
	ls_json = lnv_pak.getvalue("data")
	adw_data.importjsonbykey(ls_json)
end if

return 1
end function

public function integer of_getdata_package (string as_url, ref jsonpackage anv_pak);string ls_json
string ls_error
integer li_ret, li_i

li_ret = inv_client.sendrequest("GET", as_url)
if li_ret < 0 then
	//messagebox("Error","Failed")
else
	li_ret = inv_client.getresponsebody(ls_json)
	if li_ret >0 then		
		ls_error = anv_pak.loadstring(ls_json)
		if ls_error = '' then			
		else
			messagebox("Prompt","Load Jpackage Failed")
		end if
	
	end if
end if

return 1
end function

public function integer of_execute_func (string as_url, str_arm astr_am, ref jsonpackage anv_pak);String ls_url
String ls_sql[]
String ls_arm[]
String ls_dwname[]
String ls_type[]
String ls_json
String ls_return
String ls_error
JsonPackage lnv_jpack
Int li_cnt
Integer li_ret
DataWindow ldw_am[]
DataWindowChild ldwc_am[]

ls_url = as_url
IF Not isvalid(anv_pak) Then anv_pak  = Create jsonpackage
lnv_jpack = Create jsonpackage

ls_sql = astr_am.sql_arm
ls_arm = astr_am.s_arm
ldw_am = astr_am.dw_arm
ldwc_am = astr_am.dwc_arm
ls_dwname = astr_am.s_dwname
ls_type = astr_am.s_type

For li_cnt = 1 To UpperBound(ls_sql)
	lnv_jpack.SetValue("sql"+String(li_cnt), ls_sql[li_cnt], False)
Next

For li_cnt = 1 To UpperBound(ls_arm)
	lnv_jpack.SetValue("arm"+String(li_cnt), ls_arm[li_cnt], False)
Next

For li_cnt = 1 To UpperBound(ls_type)
	lnv_jpack.SetValue("type"+String(li_cnt), ls_type[li_cnt], False)
Next

For li_cnt = 1 To UpperBound(ldw_am)
	lnv_jpack.SetValue("dw"+String(li_cnt), ldw_am[li_cnt], True)
Next

For li_cnt = 1 To UpperBound(ls_dwname)
	lnv_jpack.SetValue("dwname"+String(li_cnt), ls_dwname[li_cnt], False)	
Next

For li_cnt = 1 To UpperBound(ldwc_am)
	lnv_jpack.SetValue("dwc"+String(li_cnt), ldwc_am[li_cnt], True)
Next

ls_json = lnv_jpack.GetJsonString()
IF ls_json = '' Then
	MessageBox("Error", "Failed to create the JSON file.")
	Return -1
Else
	inv_client.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")
	li_ret = inv_client.SendRequest("POST", ls_url, ls_json)
	IF li_ret < 1 Then
		messagebox("Error", "Failed to access the server.")
		Return -1
	Else
		li_ret = inv_client.GetResponseBody(ls_return)
	
		IF  li_ret = -1 Then
			Messagebox("Error", "The server is not responding.")
			Return -1
		Else
			ls_error = anv_pak.LoadString(ls_return)
			IF ls_error = '' Then
			Else
				Messagebox("Error", "Failed to load the JSON file.")
				Return -1
			End IF
		End IF
	End IF
End IF

Return 1
end function

on n_cst_httpclient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_httpclient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_client = create httpclient
end event

