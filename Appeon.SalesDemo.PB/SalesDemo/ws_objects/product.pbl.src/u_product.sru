$PBExportHeader$u_product.sru
forward
global type u_product from u_tab_base
end type
type dw_productlist from u_dw within tabpage_1
end type
type sle_filter from singlelineedit within tabpage_1
end type
type cb_filter from commandbutton within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_2
end type
type st_cate from statictext within u_product
end type
type dw_cate from u_dw within u_product
end type
type cb_add from u_button within u_product
end type
type cb_del from u_button within u_product
end type
type cb_save from u_button within u_product
end type
end forward

global type u_product from u_tab_base
integer width = 3991
integer height = 2736
long backcolor = 16777215
st_cate st_cate
dw_cate dw_cate
cb_add cb_add
cb_del cb_del
cb_save cb_save
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global u_product u_product

type variables
Long il_subcate_id
Long il_cate_id = 1

Private:
n_cst_webapi_product inv_webapi
end variables

forward prototypes
public function integer of_data_verify ()
public function integer of_retrieve (u_dw adw_data, string as_data)
public function integer of_winopen ()
end prototypes

public function integer of_data_verify ();//====================================================================
//$<Function>: of_data_verify
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
String ls_colname
String ls_col
Long   ll_data
Integer li_row
Datetime ldt_data
Boolean lb_required

li_row = iuo_currentdw.getrow()
IF li_row < 1 Then Return -1
iuo_currentdw.SetFocus()

lb_required = False
Choose Case iuo_currentdw.ClassName()
	Case "dw_browser" 
		ls_data = iuo_currentdw.GetItemString(li_row, "name")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Name"
			ls_col = 'name'
		End IF
	Case "dw_master"
		ls_data = iuo_currentdw.GetItemString(li_row, "name")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Name"
			ls_col = 'name'
		End IF
		
		ls_data = iuo_currentdw.GetItemString(li_row, "productnumber")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Product Number"
			ls_col = 'productnumber'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "safetystocklevel")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Safety Stock Level"
			ls_col = 'safetystocklevel'
		End IF 
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "listprice")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "List Price"
			ls_col = 'listprice'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "reorderpoint")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Reorder Point"
			ls_col = 'reorderpoint'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "standardcost")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Standard Cost"
			ls_col = 'standardcost'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "daystomanufacture")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Daystomanu Facture"
			ls_col = 'daystomanufacture'
		End IF
End Choose


IF lb_required Then
	Messagebox("Prompt", ls_colname +" is required.")
	iuo_currentdw.SetFocus()
	iuo_currentdw.SetColumn(ls_col)
	Return -1
End IF
Return 1
end function

public function integer of_retrieve (u_dw adw_data, string as_data);inv_webapi.of_retrieve(adw_data, as_data, tab_1.tabpage_2.dw_master, tab_1.tabpage_2.dw_detail )

Choose Case adw_data.dataobject
	case "d_subcategory"
		IF adw_data.RowCount() > 0 Then
			il_subcate_id = adw_data.GetItemNumber(1, "productsubcategoryid")
		End IF	
End Choose

Return 1
end function

public function integer of_winopen ();DataWindowChild ldwc_cate

dw_cate.GetChild("id", ldwc_cate)
IF ldwc_cate.RowCount() > 0 Then
	IF tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
		tab_1.tabpage_1.dw_browser.ScrollToRow(1)
	End IF
	ib_modify = False
	Return 1
End IF

dw_cate.Reset()
dw_cate.Insertrow(0)
inv_webapi.of_winopen(dw_cate, tab_1.tabpage_1.dw_browser, tab_1.tabpage_2.dw_master )

Return 1
end function

on u_product.create
int iCurrent
call super::create
this.st_cate=create st_cate
this.dw_cate=create dw_cate
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cate
this.Control[iCurrent+2]=this.dw_cate
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_del
this.Control[iCurrent+5]=this.cb_save
end on

on u_product.destroy
call super::destroy
destroy(this.st_cate)
destroy(this.dw_cate)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_save)
end on

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_productid
Long    ll_subcateid
DwItemStatus ldws_status


li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1

Choose Case iuo_currentdw.ClassName()
	Case "dw_browser"		
		
		li_ret = MessageBox("Delete Sub Category", "All the products associated with this sub category will be deleted if you deleting the sub category. Are you sure you want to delete this sub category?" , Question!, yesno!)
		
		IF li_ret = 1 Then			
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				Return 1
			End IF
			iuo_currentdw.Accepttext()
			
			//Delete row from database
			ll_subcateid = tab_1.tabpage_1.dw_browser.GetitemNumber(li_row, "productsubcategoryid")
			li_status = inv_webapi.of_deletesubcatebykey(ll_subcateid)
			IF li_status = -1 Then Return -1
			
			tab_1.tabpage_1.dw_browser.DeleteRow(li_row)			
			tab_1.tabpage_1.dw_browser.ResetUpdate()	
		End IF
		
	Case "dw_productlist", "dw_master"
		li_ret = MessageBox("Delete Product", "Are you sure you want to delete this product?" , Question!, yesno!)
		IF li_ret = 1 Then
			
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				Return 1
			End IF
			
			ll_productid = iuo_currentdw.GetItemNumber(li_row, "productid")			
			
			//Delete by key
			li_status = inv_webapi.of_deleteproductbykey(ll_productid)
			IF li_status = -1 Then Return -1
			
			iuo_currentdw.DeleteRow(li_row)
			tab_1.tabpage_2.dw_detail.Reset()
			iuo_currentdw.ReSetUpdate()
			
			IF iuo_currentdw.ClassName() = "dw_master" Then
				li_row = tab_1.tabpage_1.dw_productlist.GetRow()
				tab_1.tabpage_1.dw_productlist.DeleteRow(li_row)
				
				IF tab_1.tabpage_1.dw_productlist.RowCount() > 1 Then
					tab_1.tabpage_1.dw_productlist.ScrollToRow(1)
				End IF
			End IF
		End IF
End Choose

ib_Modify = False
w_main.ib_modify = False
Return 1


end event

event ue_save;call super::ue_save;Integer li_row
Integer li_prow
Integer li_listrow
Integer li_status
Decimal ldc_price
Long     ll_productid
String   ls_dwname
String   ls_data

DwItemStatus ldws_1
DwItemStatus ldws_sign
DataWindowChild ldwc_product

tab_1.tabpage_1.dw_browser.AcceptText()
tab_1.tabpage_2.dw_master.AcceptText()

if tab_1.tabpage_1.dw_browser.Modifiedcount() + tab_1.tabpage_2.dw_master.Modifiedcount() < 1 Then Return 1

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1
IF of_data_verify() = -1 Then Return -1

ls_dwname = ClassName(iuo_currentdw)
IF ls_dwname = "dw_master" Then
	ldws_1 = iuo_currentdw.GetItemStatus(li_row, "listprice", Primary!)
	IF ldws_1 = NewModified! OR ldws_1 = DataModified! Then
		li_prow = tab_1.tabpage_2.dw_detail.InsertRow(1)
		ldc_price = iuo_currentdw.GetItemDecimal(li_row, "listprice")
		ll_productid = iuo_currentdw.GetItemNumber(li_row, "productid")
		
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "productid", ll_productid)	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "listprice", ldc_price)	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "startdate", DateTime(today(),now()))	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "modifieddate", DateTime(today(),now()))	
	End IF
End IF

tab_1.tabpage_2.dw_detail.AcceptText()
li_row = tab_1.tabpage_2.dw_master.GetRow()
li_listrow =  tab_1.tabpage_1.dw_productlist.GetRow()
ldws_sign = tab_1.tabpage_2.dw_master.GetItemStatus(li_row, 0, Primary!)

//Save data
li_status = inv_webapi.of_savechanges(tab_1.tabpage_1.dw_browser, tab_1.tabpage_2.dw_master, &
									tab_1.tabpage_2.dw_detail)
IF li_status = -1 Then Return -1 

MessageBox("Prompt", "Saved the data successfully.")

w_main.ib_modify = False
ib_Modify = False
IF ldws_sign = NewModified! Then
	li_listrow =  tab_1.tabpage_1.dw_productlist.RowCount()
	tab_1.tabpage_2.dw_master.RowsCopy(li_row, li_row, Primary!, tab_1.tabpage_1.dw_productlist, li_listrow + 1, primary!)
	
	tab_1.tabpage_1.dw_productlist.SetRow(li_listrow + 1)
	tab_1.tabpage_1.dw_productlist.ScrollToRow(li_listrow + 1)
	
	ll_productid = tab_1.tabpage_2.dw_master.GetItemNumber(li_row, "productid")
	ls_data = tab_1.tabpage_2.dw_master.GetItemString(li_row, "name")
	tab_1.tabpage_2.dw_detail.GetChild("productid", ldwc_product)
	li_row = ldwc_product.InsertRow(0)
	ldwc_product.SetItem(li_row, "productid", ll_productid)
	ldwc_product.SetItem(li_row, "name", ls_data)
	tab_1.tabpage_2.dw_detail.SetItem(1, "productid", ll_productid)
	
ElseIF ldws_sign = DataModified! Then
	tab_1.tabpage_2.dw_master.RowsCopy(li_row, li_row, Primary!, tab_1.tabpage_1.dw_productlist, li_listrow + 1, primary!)
	tab_1.tabpage_1.dw_productlist.DeleteRow(li_listrow)
	tab_1.tabpage_1.dw_productlist.SetRow(li_listrow)
	tab_1.tabpage_1.dw_productlist.ScrollToRow(li_listrow)
End IF

w_main.ib_modify = False
ib_Modify = False

li_row = tab_1.tabpage_1.dw_browser.GetRow()
IF li_row > 0 Then
	il_subcate_id = tab_1.tabpage_1.dw_browser.GetItemNumber(li_row, "productsubcategoryid")
End IF

Return 1

end event

event ue_add;call super::ue_add;//====================================================================
//$<Event>: ue_add
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_row
String   ls_dwname

ls_dwname = ClassName(iuo_currentdw)

IF ls_dwname = "dw_detail" Then
	Return 1
End IF

IF ls_dwname = "dw_browser" Then	
	
	IF tab_1.tabpage_2.dw_master.ModifiedCount() > 0 Then
		MessageBox("Prompt", "Please save the data first.")
		Return -1
	End IF	
	il_subcate_id = 0
	tab_1.tabpage_2.dw_detail.Reset()
	
ElseIF ls_dwname= "dw_productlist" OR ls_dwname = "dw_master" Then
	
	tab_1.SelectedTab = 2
	tab_1.tabpage_2.dw_master.Modify("p_1.filename=''")		
	tab_1.tabpage_2.dw_detail.reset()	
End IF

IF ls_dwname = "dw_browser" Then
	li_row = iuo_currentdw.InsertRow(0)
	iuo_currentdw.SelectRow(0, False)
	iuo_currentdw.SelectRow(li_row, True)
	iuo_currentdw.ScrollToRow(li_row)
	iuo_currentdw.SetItem(li_row, "productcategoryid", il_cate_id)
	iuo_currentdw.SetItem(li_row, "modifieddate", DateTime(Today(),Now()))
Else
	iuo_currentdw = tab_1.tabpage_2.dw_master
	iuo_currentdw.SetFilter("1<>1")
	iuo_currentdw.Filter()
	iuo_currentdw.InsertRow(1)	
	iuo_currentdw.SetItem(1, "productsubcategoryid", il_subcate_id)
	iuo_currentdw.SetItem(1, "modifieddate", DateTime(Today(),Now()))
	iuo_currentdw.SetItem(1, "sellstartdate", DateTime(Today(),Now()))
	IF il_subcate_id > 0 Then
		iuo_currentdw.SetItem(1, "productsubcategoryid", il_subcate_id)
	End IF		
	iuo_currentdw.SetItem(1, "makeflag", 0)
	
End IF

ib_Modify = True
w_main.ib_modify = True

Return 1

end event

event ue_filter;call super::ue_filter;String ls_filter
String ls_txt

ls_txt = tab_1.tabpage_1.sle_filter.text
ls_filter = ""
IF Len(ls_txt) > 0 Then
	ls_txt = "%" + ls_txt + "%"
	tab_1.tabpage_1.dw_productlist.SetFilter("name like '" + ls_txt+"'")
	tab_1.tabpage_1.dw_productlist.Filter()
Else
	tab_1.tabpage_1.dw_productlist.SetFilter("")
	tab_1.tabpage_1.dw_productlist.Filter()
End IF

Return 1
end event

type tab_1 from u_tab_base`tab_1 within u_product
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

event tab_1::selectionchanged;call super::selectionchanged;
Choose Case newindex
	Case 1
		st_cate.Visible = True
		dw_cate.Visible = True
	Case 2
		st_cate.Visible = False
		dw_cate.Visible = False
End Choose
end event

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3954
integer height = 2536
dw_productlist dw_productlist
sle_filter sle_filter
cb_filter cb_filter
st_2 st_2
end type

on tabpage_1.create
this.dw_productlist=create dw_productlist
this.sle_filter=create sle_filter
this.cb_filter=create cb_filter
this.st_2=create st_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_productlist
this.Control[iCurrent+2]=this.sle_filter
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.st_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_productlist)
destroy(this.sle_filter)
destroy(this.cb_filter)
destroy(this.st_2)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 228
integer width = 3845
integer height = 1032
string dataobject = "d_subcategory"
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
Integer li_ret
DwItemStatus ldws_1

IF currentrow < 1 Then Return

tab_1.tabpage_2.dw_master.AcceptText()
IF tab_1.tabpage_2.dw_master.Modifiedcount() > 0 Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		tab_1.SelectedTab = 2	
		Return
	End IF
	tab_1.tabpage_2.dw_master.ResetUpdate()
End IF

IF ib_modify = True Then
	ldws_1 = This.GetItemStatus(currentrow, 0, Primary!)
	IF ldws_1 = NotModified! Then
		li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
		IF li_ret = 1 Then
			Return
		End IF
		This.ResetUpdate()
	End IF
end if

ib_modify = False
w_main.ib_modify = False

This.SelectRow(0,False)
This.SelectRow(currentrow,True)
This.ScrollToRow(currentrow)
il_subcate_id = This.GetItemNumber(currentrow, "productsubcategoryid")
IF il_subcate_id = 0 OR Isnull(il_subcate_id) Then 
	dw_productlist.Reset()	
	Return
End if
ls_data = String(il_subcate_id)
of_retrieve(dw_productlist, ls_data)
end event

event dw_browser::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True
end event

event dw_browser::clicked;call super::clicked;Post Event RowFocusChanged(row)
end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3954
integer height = 2536
st_1 st_1
end type

on tabpage_2.create
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 228
integer width = 3845
integer height = 1444
string dataobject = "d_product_detail"
end type

event dw_master::buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filename, ls_path
String ls_currentpath
Long   ll_productid
Integer li_Return
Integer li_FileNum
Blob lbb_data


IF row < 1 Then Return

ll_productid = This.GetItemNumber(row, "productid")

IF isnull(ll_productid) OR ll_productid = 0 Then
	MessageBox("Prompt", "Please save the added data first.")
	Return
End IF
ls_currentpath = GetCurrentDirectory()

li_Return = GetFileOpenName("Select File", ls_path, ls_filename, "gif", &
									 "GIF File (*.gif),*.gif," + &
									 "Bitmap Files (*.bmp),*.bmp," + &
									 "JPG Files (*.jpg),*.jpg" )

This.Modify("p_1.filename = '"+ls_path+"'")
ChangeDirectory(ls_currentpath)
IF li_Return <> 1 Then Return

li_FileNum = FileOpen(ls_path, StreamMode!, Read!)
FileReadEx (li_FileNum, lbb_data)
FileClose(li_FileNum)

inv_webapi.of_saveproductphoto(ll_productid, ls_filename, lbb_data)

MessageBox("Save Product Photo", "Saved the product photo successfully.")
end event

event dw_master::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True
end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
integer x = 64
integer y = 1856
integer width = 3845
integer height = 632
string dataobject = "d_history_price"
end type

type dw_productlist from u_dw within tabpage_1
integer x = 64
integer y = 1452
integer width = 3845
integer height = 1040
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_product"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;iuo_currentdw = This
end event

event doubleclicked;call super::doubleclicked;tab_1.SelectTab(2)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
Integer li_ret

IF currentrow < 1 Then Return

tab_1.tabpage_2.dw_master.Accepttext()
IF tab_1.tabpage_2.dw_master.Modifiedcount() > 0  Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		tab_1.SelectedTab = 2
		Return
	End IF
End IF

This.SelectRow(0,False)
This.SelectRow(currentrow,True)

ls_data = String(This.GetItemNumber(currentrow, "productid"))
IF Not(isnull(ls_data) OR ls_data = "") Then
	tab_1.tabpage_2.dw_master.SetFilter("productid = " + ls_data)
	tab_1.tabpage_2.dw_detail.SetFilter("productid = " + ls_data)
	tab_1.tabpage_2.dw_master.Filter()
	tab_1.tabpage_2.dw_detail.Filter()		
	of_retrieve(tab_1.tabpage_2.dw_detail, ls_data)	
Else
	tab_1.tabpage_2.dw_detail.Reset()
	tab_1.tabpage_2.dw_master.Modify("p_1.filename=''")
End IF
end event

type sle_filter from singlelineedit within tabpage_1
integer x = 2578
integer y = 1324
integer width = 896
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_filter from commandbutton within tabpage_1
integer x = 3538
integer y = 1324
integer width = 366
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;iuo_parent.Event ue_filter()

end event

type st_2 from statictext within tabpage_1
boolean visible = false
integer x = 69
integer y = 1324
integer width = 1129
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16446706
string text = "Explain:"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_2
integer x = 69
integer y = 1736
integer width = 640
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 553648127
string text = "ProductCostHistory:"
boolean focusrectangle = false
end type

type st_cate from statictext within u_product
integer x = 96
integer y = 248
integer width = 498
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Select Category:"
boolean focusrectangle = false
end type

type dw_cate from u_dw within u_product
integer x = 603
integer y = 244
integer width = 901
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_catesel"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
IF row < 1 Then Return
il_cate_id = Long(data)
of_retrieve(tab_1.tabpage_1.dw_browser, data)
end event

type cb_add from u_button within u_product
integer x = 2665
integer y = 240
integer width = 366
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Parent.Event ue_add()
end event

type cb_del from u_button within u_product
integer x = 3104
integer y = 240
integer width = 366
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_modified

Parent.Event ue_delete()

li_modified =  tab_1.tabpage_2.dw_master.Modifiedcount() 
li_modified = li_modified + tab_1.tabpage_1.dw_browser.Modifiedcount()

IF li_modified  > 0 Then
	ib_modify = True
	w_main.ib_modify = True
Else
	ib_modify = False
	w_main.ib_modify = False
End IF
end event

type cb_save from u_button within u_product
integer x = 3543
integer y = 240
integer width = 366
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;Parent.Event ue_save()
end event

