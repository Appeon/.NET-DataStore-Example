$PBExportHeader$u_address.sru
forward
global type u_address from u_tab_base
end type
type dw_filter from u_dw within tabpage_1
end type
type cb_retrieve from u_button within tabpage_1
end type
type cb_add from u_button within u_address
end type
type cb_delete from u_button within u_address
end type
type cb_save from u_button within u_address
end type
end forward

global type u_address from u_tab_base
integer width = 3991
integer height = 2736
long backcolor = 16777215
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global u_address u_address

type variables
Private:
n_cst_webapi_address inv_webapi

string is_controller
end variables

forward prototypes
public function integer of_winopen ()
public function integer of_data_verify ()
end prototypes

public function integer of_winopen ();//====================================================================
//$<Function>: of_winopen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
DataWindowChild ldwc_child

IF tab_1.tabpage_1.dw_filter.RowCount() < 1 Then
	tab_1.tabpage_1.dw_filter.InsertRow(1)	
End IF

tab_1.tabpage_1.dw_filter.GetChild("stateprovinceid", ldwc_child)
IF ldwc_child.RowCount() > 0 Then
	IF tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
		tab_1.tabpage_1.dw_browser.ScrollToRow(1)
	End IF
	ib_modify = False
	Return 1
End IF

This.SetRedraw(False)
//Retrieve Dddw
inv_webapi.of_winopen(tab_1.tabpage_1.dw_filter, tab_1.tabpage_1.dw_browser,  tab_1.tabpage_2.dw_master)

IF ldwc_child.RowCount() > 0 Then
	IF ldwc_child.Find("stateprovinceid=1", 1,  ldwc_child.RowCount()) > 0 THEN
		tab_1.tabpage_1.dw_filter.SetItem(1, "stateprovinceid", 1)
	END IF
END IF

tab_1.tabpage_1.cb_retrieve.Post Event Clicked()

This.Post SetRedraw(True)

Return 1
end function

public function integer of_data_verify ();Long ll_row
Long ll_count
Long ll_stateprovinceid
Integer li_return
String   ls_addressline1
String   ls_postalcode
String   ls_city

li_return = tab_1.tabpage_2.dw_master.AcceptText()

ll_row = tab_1.tabpage_2.dw_master.GetRow()

ls_addressline1 =  tab_1.tabpage_2.dw_master.GetItemString(ll_row, "addressline1")
IF isnull(ls_addressline1) OR trim(ls_addressline1) = "" Then
	messagebox('Prompt', "Address Line 1 is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("addressline1")
	Return -1
End IF

ll_stateprovinceid =  tab_1.tabpage_2.dw_master.GetItemNumber(ll_row, "stateprovinceid")
IF isnull(ll_stateprovinceid) Then
	messagebox('Prompt', "State/Province is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("stateprovinceid")
	Return -1
End IF

ls_city =   tab_1.tabpage_2.dw_master.GetItemString(ll_row, "city")
IF isnull(ls_city) or trim(ls_city) = "" Then
	messagebox('Prompt', "City is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("city")
	Return -1
End IF	


ls_postalcode =   tab_1.tabpage_2.dw_master.GetItemString(ll_row, "postalcode")
IF isnull(ls_postalcode) or trim(ls_postalcode) = "" Then
	messagebox('Error', "Postal Code is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("postalcode")
	Return -1
End IF

Return 1
end function

on u_address.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_save
end on

on u_address.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
end on

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_addressid

DwitemStatus ldws_status

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return	1	

li_ret = MessageBox("Delete Address", "Are you sure you want to delete this address?" , Question!, yesno!)
IF li_ret = 1 Then	
	ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
	IF ldws_status = New! Or ldws_status = NewModified! Then
		ib_Modify = False
		w_main.ib_modify = False
		iuo_currentdw.DeleteRow(li_row)
		iuo_currentdw.ReSetUpdate()
		Return 1
	End IF

	//Delete from database
	ll_addressid = iuo_currentdw.GetItemNumber(li_row, "addressid")	
	li_status = inv_webapi.of_deleteaddressbykey(ll_addressid)
	
	IF li_status = -1 Then Return -1
	
	iuo_currentdw.DeleteRow(li_row)
	iuo_currentdw.ReSetUpdate()
	
	IF iuo_currentdw.ClassName() = "dw_master" Then
		li_row = tab_1.tabpage_1.dw_browser.GetRow()
		tab_1.tabpage_1.dw_browser.DeleteRow(li_row)
		tab_1.tabpage_1.dw_browser.ReSetUpdate()
		
		IF tab_1.tabpage_1.dw_browser.RowCount() > 1 Then
			tab_1.tabpage_1.dw_browser.ScrollToRow(1)
		End IF
	End IF	
End IF

ib_Modify = False
w_main.ib_modify = False

Return 1
end event

event ue_save;call super::ue_save;Integer li_row
Integer li_listrow
Integer li_status
long     ll_rowcount
DwItemStatus ldws_sign

iuo_currentdw.AcceptText()
IF iuo_currentdw.Modifiedcount() < 1 Then Return 1

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1
IF of_data_verify() = -1 Then Return -1

ldws_sign = iuo_currentdw.GetItemStatus(li_row, 0, Primary!)
li_listrow = tab_1.tabpage_1.dw_browser.Getrow()

li_status = inv_webapi.of_savechanges(tab_1.tabpage_2.dw_master)

IF li_status = -1 Then Return -1

ib_modify = False
w_main.ib_modify = False

IF ldws_sign = Newmodified! Then
	li_listrow = tab_1.tabpage_1.dw_browser.rowcount() + 1 
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow, primary!)	
ElseIF ldws_sign = DataModified! Then	
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow + 1, primary!)	
	tab_1.tabpage_1.dw_browser.Deleterow(li_listrow)	
End IF

tab_1.tabpage_1.dw_browser.ScrollToRow(li_listrow)
tab_1.tabpage_1.dw_browser.SelectRow (0, False)
tab_1.tabpage_1.dw_browser.SelectRow (li_listrow, True)
	
MessageBox("Prompt", "Saved the data successfully.")
ib_modify = False
w_main.ib_modify = False

Return 1
end event

event ue_filter;call super::ue_filter;String ls_city
Long ll_stateprovinceid

tab_1.tabpage_1.dw_filter.AcceptText()

ll_stateprovinceid = tab_1.tabpage_1.dw_filter.GetItemNumber(1, "stateprovinceid")
ls_city = tab_1.tabpage_1.dw_filter.GetItemString(1, "city")

IF Isnull(ll_stateprovinceid) Then ll_stateprovinceid = 0
IF Isnull(ls_city) Then ls_city = ""

inv_webapi.of_retrieveaddress(ll_stateprovinceid, ls_city, tab_1.tabpage_1.dw_browser, &
										tab_1.tabpage_2.dw_master)

Return 1

end event

event ue_add;call super::ue_add;Integer li_row

IF ib_Modify = True Then
	MessageBox("Prompt", "Please save the data first.")
	
	Return 1
End IF

IF tab_1.SelectedTab <> 2 Then tab_1.SelectedTab = 2

iuo_currentdw = tab_1.tabpage_2.dw_master
li_row = iuo_currentdw.InsertRow(0)
iuo_currentdw.ScrollToRow(li_row)

ib_Modify = True
//w_main.ib_modify = True

Return 1
end event

type tab_1 from u_tab_base`tab_1 within u_address
integer x = 0
integer y = 64
integer width = 3991
integer height = 2668
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3954
integer height = 2536
dw_filter dw_filter
cb_retrieve cb_retrieve
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.cb_retrieve=create cb_retrieve
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_retrieve
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_retrieve)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 228
integer width = 3845
integer height = 2268
string dataobject = "d_address"
boolean hscrollbar = true
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Function>: of_winopen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long  ll_addressid
Integer li_ret

IF currentrow < 1 Then Return -1

tab_1.tabpage_2.dw_master.AcceptText()
IF ib_Modify = True Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		tab_1.SelectedTab = 2
		Return 1
	End IF
End IF

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

ll_addressid = This.GetItemNumber(currentrow, "addressid")

tab_1.tabpage_2.dw_master.SetFilter("addressid = " + String(ll_addressid))
tab_1.tabpage_2.dw_master.Filter()
tab_1.tabpage_2.dw_master.SetFilter("")
tab_1.tabpage_2.dw_master.ResetUpdate()

ib_modify = False
w_main.ib_modify = False


end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3954
integer height = 2536
end type

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 220
integer width = 3831
integer height = 888
string dataobject = "d_address_free"
boolean border = false
end type

event dw_master::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True
end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
boolean visible = false
end type

type dw_filter from u_dw within tabpage_1
integer x = 64
integer y = 60
integer width = 1842
integer height = 124
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_address_filter"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_retrieve from u_button within tabpage_1
integer x = 1970
integer y = 68
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Retrieve"
end type

event clicked;call super::clicked;iuo_parent.Event ue_filter()



end event

type cb_add from u_button within u_address
integer x = 2665
integer y = 240
integer width = 366
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;call super::clicked;Parent.Event ue_add()
end event

type cb_delete from u_button within u_address
integer x = 3104
integer y = 240
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;Parent.Event ue_delete()
end event

type cb_save from u_button within u_address
integer x = 3543
integer y = 240
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;Parent.Event ue_save()
end event

