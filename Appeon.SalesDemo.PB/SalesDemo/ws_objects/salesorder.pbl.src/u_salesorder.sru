$PBExportHeader$u_salesorder.sru
forward
global type u_salesorder from u_tab_base
end type
type dw_filter from u_dw within tabpage_1
end type
type cb_filter from u_button within tabpage_1
end type
type st_1 from statictext within tabpage_2
end type
type cb_add from u_button within u_salesorder
end type
type cb_delete from u_button within u_salesorder
end type
type cb_save from u_button within u_salesorder
end type
end forward

global type u_salesorder from u_tab_base
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
global u_salesorder u_salesorder

type variables
Private:
n_cst_webapi_salesorder inv_webapi
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
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_from", DateTime("2013-01-01"))
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_to", DateTime("2013-01-31"))
End IF

tab_1.tabpage_1.dw_filter.GetChild("customer", ldwc_child)
IF ldwc_child.RowCount() > 0 Then
	IF tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
		tab_1.tabpage_1.dw_browser.ScrollToRow(1)
	End IF
	ib_modify = False
	Return 1
End IF

inv_webapi.of_winopen(tab_1.tabpage_1.dw_filter, tab_1.tabpage_1.dw_browser, &
									tab_1.tabpage_2.dw_master, tab_1.tabpage_2.dw_detail )
									
tab_1.tabpage_1.cb_filter.Post Event Clicked()

Return 1

end function

public function integer of_data_verify ();Long ll_row
Long ll_count
Long ll_customerid
Long ll_addressid
Long ll_productid
Long ll_specialofferid
Long ll_qty
Integer   li_Return
Decimal	ld_price

li_Return =  tab_1.tabpage_2.dw_master.accepttext()

ll_row =  tab_1.tabpage_2.dw_master.Getrow()
IF ll_row > 0 Then
	ll_customerid =   tab_1.tabpage_2.dw_master.GetItemNumber(ll_row, "customerid")
	IF isnull(ll_customerid) Then
		messagebox('Prompt', "Customer ID is required.")
		tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_master.setfocus()
		 tab_1.tabpage_2.dw_master.setcolumn("customerid")
		Return -1
	End IF

	ll_addressid =   tab_1.tabpage_2.dw_master.GetItemNumber(ll_row, "billtoaddressid")
	IF isnull(ll_addressid) Then
		messagebox('Prompt', "Bill To Address is required.")
		tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_master.setfocus()
		 tab_1.tabpage_2.dw_master.setcolumn("billtoaddressid")
		Return -1
	End IF

	ll_addressid =   tab_1.tabpage_2.dw_master.GetItemNumber(ll_row, "shiptoaddressid")
	IF isnull(ll_addressid) Then
		messagebox('Prompt', "Ship To Address is required.")
		tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_master.setfocus()
		 tab_1.tabpage_2.dw_master.setcolumn("shiptoaddressid")
		Return -1
	End IF	
	
End IF

li_Return =  tab_1.tabpage_2.dw_detail.accepttext()

ll_count =  tab_1.tabpage_2.dw_detail.rowcount()
For ll_row = 1 To ll_count
	ll_productid =  tab_1.tabpage_2.dw_detail.GetItemNumber(ll_row, "productid")
	IF isnull(ll_productid) Then
		messagebox('Prompt', "Product is required.")
		tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_detail.setfocus()
		 tab_1.tabpage_2.dw_detail.scrolltorow( ll_row)
		 tab_1.tabpage_2.dw_detail.setcolumn("productid")
		Return -1
	End IF
		
	ll_qty =   tab_1.tabpage_2.dw_detail.GetItemNumber(ll_row, "orderqty")
	IF isnull(ll_qty) or ll_qty = 0 Then
		 messagebox('Prompt', "Quantity is required.")
		 tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_detail.setfocus()
		 tab_1.tabpage_2.dw_detail.scrolltorow( ll_row)
		 tab_1.tabpage_2.dw_detail.setcolumn("orderqty")
		Return -1
	End IF
	
	ld_price =  tab_1.tabpage_2.dw_detail.GetItemNumber(ll_row, "unitprice")
	IF isnull(ld_price) or ld_price = 0 Then
		 messagebox('Prompt', "Price is required.")
		 tab_1.selecttab(2)
		 tab_1.tabpage_2.dw_detail.setfocus()
		 tab_1.tabpage_2.dw_detail.scrolltorow( ll_row)
		 tab_1.tabpage_2.dw_detail.setcolumn("unitprice")
		Return -1
	End IF	
Next

Return li_Return

end function

on u_salesorder.create
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

on u_salesorder.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
end on

event ue_filter;call super::ue_filter;DateTime ldt_date_from
DateTime ldt_date_to
Long ll_custid

tab_1.tabpage_1.dw_filter.AcceptText()

ll_custid = tab_1.tabpage_1.dw_filter.GetItemNumber(1, "customer")
IF Isnull(ll_custid) Then ll_custid = 0

ldt_date_from = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_from")
IF Isnull(ldt_date_from) Then ldt_date_from = DateTime("1978-01-01")

ldt_date_to = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_to")

//Retreve data
inv_webapi.of_retrievesalesorderlist(ll_custid, ldt_date_from, ldt_date_to, tab_1.tabpage_1.dw_browser, &
												tab_1.tabpage_2.dw_master)

Return 1
end event

event ue_add;call super::ue_add;
Integer li_modifiedrow
Integer li_row
Integer li_header
Long    ll_saleid
DateTime ldt_currentdate

tab_1.tabpage_1.dw_browser.AcceptText()
tab_1.tabpage_2.dw_master.AcceptText()
tab_1.tabpage_2.dw_detail.AcceptText()

Choose Case iuo_currentdw.ClassName()
	Case "dw_browser", "dw_master"
		
		IF ib_Modify = True Then
			MessageBox("Prompt", "Please save the data first.")
			tab_1.SelectedTab = 2
			Return 1
		End IF

		li_modifiedrow = tab_1.tabpage_2.dw_master.ModifiedCount() + tab_1.tabpage_2.dw_detail.ModifiedCount()
		IF li_modifiedrow > 0 Then
			MessageBox("Prompt", "Please save the data first.");
			Return -1
		End IF

		iuo_currentdw = tab_1.tabpage_2.dw_master
		IF tab_1.SelectedTab = 1 Then tab_1.SelectedTab = 2
		tab_1.tabpage_2.dw_detail.Reset()
		
		ldt_currentdate = Datetime(Today(), Now())
		li_row = iuo_currentdw.Insertrow(1)
		iuo_currentdw.SetItem(li_row, "duedate", RelativeDate(Date(ldt_currentdate),10))
		iuo_currentdw.SetItem(li_row, "orderdate", ldt_currentdate)
		iuo_currentdw.SetItem(li_row, "shipdate", ldt_currentdate)
		iuo_currentdw.SetItem(li_row, "modifieddate", ldt_currentdate)		
		iuo_currentdw.SetItem(li_row, "revisionnumber", 1)
		iuo_currentdw.SetItem(li_row, "onlineorderflag", 1)
		iuo_currentdw.SetItem(li_row, "taxamt", 0)
		iuo_currentdw.SetItem(li_row, "freight", 0)
		iuo_currentdw.Setrow(li_row)
		
	Case "dw_detail"
		li_header = tab_1.tabpage_2.dw_master.GetRow()
		IF li_header < 1 Then
			MessageBox("Prompt", "Please add the sales order info first.");
			Return -1
		Else
			ll_saleid = tab_1.tabpage_2.dw_master.GetItemNumber(li_header, "salesorderid")
			IF IsNull(ll_saleid) Then ll_saleid = 0
		End IF
		
		li_row = iuo_currentdw.Insertrow(0)
		iuo_currentdw.ScrollToRow(li_row)
		iuo_currentdw.SetItem(li_row, "orderqty", 1)
		iuo_currentdw.SetItem(li_row, "specialofferid", 1)
		iuo_currentdw.SetItem(li_row, "unitpricediscount", 0)
		
		IF ll_saleid <> 0 Then
			iuo_currentdw.SetItem(li_row, "salesorderid", ll_saleid)
		End IF
		
End Choose

ib_Modify = True
w_main.ib_modify = True

Return 1

		
end event

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Integer li_retstatus
Long    ll_salesorderid
Long    ll_salesdetailid
DwItemStatus ldws_status

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1

Choose Case iuo_currentdw.ClassName()
	Case "dw_browser", "dw_master"
		
		li_ret = MessageBox("Delete Order", "Are you sure you want to delete this order?" , Question!, yesno!)
		
		IF li_ret = 1 Then		
		
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				Return 1
			End IF
			
			li_status = iuo_currentdw.GetItemNumber(li_row, "status")
		
			IF Not( li_status = 3 OR li_status = 4 OR li_status = 6) Then
				Messagebox("Prompt", "Effective order, Cannot be deleted!")
				Return -1
			End IF
			
			ll_salesorderid = iuo_currentdw.GetItemNumber(li_row, "salesorderid")
			
			//Delete sales order
			li_retstatus = inv_webapi.of_deletesalesorderbykey("SaleOrder", ll_salesorderid, 0)
			IF li_retstatus = -1 Then Return -1
			
			iuo_currentdw.DeleteRow(li_row)
			iuo_currentdw.ResetUpdate()
			tab_1.tabpage_2.dw_detail.Reset()
			tab_1.tabpage_2.dw_detail.ResetUpdate()
			
			IF iuo_currentdw.ClassName() = "dw_master" Then
				li_row = tab_1.tabpage_1.dw_browser.GetRow()
				tab_1.tabpage_1.dw_browser.DeleteRow(li_row)
				
				IF tab_1.tabpage_1.dw_browser.RowCount() > 1 Then
					tab_1.tabpage_1.dw_browser.ScrollToRow(1)
				End IF
			End IF
		End IF	
	Case "dw_detail"		
		ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
		IF ldws_status = New! Or ldws_status = NewModified! Then
			iuo_currentdw.DeleteRow(li_row)
			Return 1
		End IF
			
		li_status = tab_1.tabpage_2.dw_master.GetItemNumber(tab_1.tabpage_2.dw_master.GetRow(), "status")
		
		IF  li_status = 2 OR li_status = 5 Then
			Messagebox("Prompt", "Effective order, Cannot be deleted!")
			Return -1
		End IF
		
		li_ret = MessageBox("Delete Order Detail", "Are you sure you want to delete this Order Detail?" , Question!, yesno!)
		IF li_ret = 1 Then
			ll_salesorderid = iuo_currentdw.GetItemNumber(li_row, "salesorderid")
			ll_salesdetailid = iuo_currentdw.GetItemNumber(li_row, "salesorderdetailid")
			
			//Delete Sale Order
			li_retstatus = inv_webapi.of_deletesalesorderbykey("OrderDetail", ll_salesorderid, ll_salesdetailid)
			IF li_retstatus = -1 Then Return -1
			
			iuo_currentdw.DeleteRow(li_row)
			iuo_currentdw.ResetUpdate()
		End IF		
End Choose

ib_Modify = False
w_main.ib_modify = False

Return 1
end event

event ue_save;call super::ue_save;Integer li_row
Integer li_listrow
Integer li_status
Decimal ldc_linetotal
DwItemStatus ldws_status

tab_1.tabpage_2.dw_master.AcceptText()
tab_1.tabpage_2.dw_detail.AcceptText()

IF tab_1.tabpage_2.dw_master.Modifiedcount() + tab_1.tabpage_2.dw_detail.Modifiedcount() < 1 Then Return 1

IF tab_1.tabpage_2.dw_detail.Modifiedcount() > 0 Then
	li_row = tab_1.tabpage_2.dw_master.GetRow()
	ldc_linetotal = tab_1.tabpage_2.dw_detail.GetItemDecimal(1, "compute_sum")
	tab_1.tabpage_2.dw_master.SetItem(li_row, "subtotal", ldc_linetotal)
	tab_1.tabpage_2.dw_master.AcceptText()
End IF

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1

IF of_data_verify() = -1 Then Return -1

li_row = tab_1.tabpage_2.dw_master.GetRow()
li_listrow = tab_1.tabpage_1.dw_browser.GetRow()
ldws_status = tab_1.tabpage_2.dw_master.GetItemStatus(li_row, 0, Primary!)

//Save data
li_status = inv_webapi.of_savechanges(tab_1.tabpage_2.dw_master, tab_1.tabpage_2.dw_detail, &
									tab_1.tabpage_1.dw_browser)
IF li_status = -1 Then Return -1 

ib_modify = False
w_main.ib_modify = False

IF ldws_status = Newmodified! Then
	li_listrow = tab_1.tabpage_1.dw_browser.rowcount() + 1 
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow, primary!)

ElseIF ldws_status = DataModified! Then	
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow+1, primary!)
	tab_1.tabpage_1.dw_browser.Deleterow(li_listrow)	
End IF

tab_1.tabpage_1.dw_browser.ScrollToRow(li_listrow)
tab_1.tabpage_1.dw_browser.SelectRow (0, False)
tab_1.tabpage_1.dw_browser.SelectRow (li_listrow, True)

MessageBox("Prompt", "Saved the data successfully.")

ib_Modify = False
w_main.ib_modify = False


Return 1
end event

type tab_1 from u_tab_base`tab_1 within u_salesorder
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
cb_filter cb_filter
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.cb_filter=create cb_filter
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_filter
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_filter)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 348
integer width = 3845
integer height = 2148
string dataobject = "d_order_header_grid"
boolean hscrollbar = true
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Function>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_ret
Long  ll_customerid
Long  ll_salesorderid

IF currentrow < 1 Then Return -1

IF ib_Modify = True Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		tab_1.SelectedTab = 2
		Return 1
	End IF
	tab_1.tabpage_2.dw_master.ResetUpdate()
	tab_1.tabpage_2.dw_detail.ResetUpdate()
End IF

ib_modify = False
w_main.ib_modify = False

ll_salesorderid = This.GetItemNumber(currentrow, "salesorderid")
ll_customerid = This.GetItemNumber(currentrow, "customerid")
This.SelectRow(0, False)
This.SelectRow(currentrow, True)

tab_1.tabpage_2.dw_master.SetFilter("salesorderid = " + String(ll_salesorderid))
tab_1.tabpage_2.dw_master.Filter()
tab_1.tabpage_2.dw_master.SetFilter("")

inv_webapi.of_RetrieveSaleOrderDetail(ll_salesorderid, ll_customerid, &
														tab_1.tabpage_2.dw_master, tab_1.tabpage_2.dw_detail )


end event

event dw_browser::clicked;call super::clicked;iuo_currentdw = This
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
integer height = 1516
string dataobject = "d_order_header_free"
end type

event dw_master::clicked;call super::clicked;iuo_currentdw = This
end event

event dw_master::itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

DataWindowChild ldwc_billtoaddressid
DataWindowChild ldwc_shiptoaddressid
DataWindowChild ldwc_creditcardid
Long ll_customerid

IF row < 1 Then Return

IF dwo.Name = "customerid" Then
	IF Isnull(data) Then Return
	
	//Reset data
	tab_1.tabpage_2.dw_master.GetChild("billtoaddressid", ldwc_billtoaddressid)
	ldwc_billtoaddressid.Reset()
	tab_1.tabpage_2.dw_master.GetChild("shiptoaddressid", ldwc_shiptoaddressid)
	ldwc_shiptoaddressid.Reset()
	tab_1.tabpage_2.dw_master.GetChild("creditcardid", ldwc_creditcardid)
	ldwc_creditcardid.Reset()

	//Send Request and get data
	ll_customerid = Long(data)
	inv_webapi.of_retrievedddw( ll_customerid, ldwc_billtoaddressid, ldwc_shiptoaddressid, ldwc_creditcardid)														
End IF

ib_modify = True
w_main.ib_modify = True



end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
integer x = 64
integer y = 1916
integer width = 3845
integer height = 576
string dataobject = "d_order_detail_list"
boolean vscrollbar = true
end type

event dw_detail::rowfocuschanged;call super::rowfocuschanged;IF currentrow < 1 Then Return

This.SelectRow(0, False)
This.SelectRow(currentrow, True)
end event

event dw_detail::clicked;call super::clicked;iuo_currentdw = This
Event rowfocuschanged(row)
end event

event dw_detail::itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_row
Integer li_qty
Decimal ldc_price
Decimal ldc_discount
DatawindowChild ldwc_child

IF row < 1 Then Return

Choose Case dwo.Name
	Case "productid"
		
		This.GetChild("productid", ldwc_child)
		li_row = ldwc_child.Getrow()
		
		IF li_row > 0 Then
			ldc_price = ldwc_child.GetItemDecimal(li_row, "product_listprice")
			This.SetItem(row, "unitprice", ldc_price)
			
			li_qty = This.GetItemNumber(row, "orderqty")
			ldc_discount = This.GetItemDecimal(row, "unitpricediscount")
			
			IF Isnull(li_qty) Or Isnull(ldc_discount) Or Isnull(ldc_price) Then Return
		
			This.SetItem(row, "linetotal", li_qty*(1 - ldc_discount)*ldc_price)
			
		End IF
		
	Case "orderqty"
		
		ldc_price = This.GetItemDecimal(row, "unitprice")
		ldc_discount = This.GetItemDecimal(row, "unitpricediscount")
		
		IF Isnull(ldc_price) Or Isnull(ldc_discount) Or Isnull(data) Or data = "" Then Return
		
		This.SetItem(row, "linetotal", ldc_price*(1 - ldc_discount)*Long(data))
		
	Case "unitprice"
		
		li_qty = This.GetItemNumber(row, "orderqty")
		ldc_discount = This.GetItemDecimal(row, "unitpricediscount")
		
		IF Isnull(li_qty) Or Isnull(ldc_discount) Or Isnull(data) Or data = "" Then Return
		
		This.SetItem(row, "linetotal", li_qty*(1 - ldc_discount)*Long(data))
		
	Case "unitpricediscount"
		
		li_qty = This.GetItemNumber(row, "orderqty")
		ldc_price = This.GetItemDecimal(row, "unitprice")
		
		IF Isnull(li_qty) Or Isnull(ldc_price) Or Isnull(data) Or data = "" Then Return
		
		This.SetItem(row, "linetotal", li_qty*ldc_price*(1 - Long(data)))
		
End Choose
		
ib_modify = True
w_main.ib_modify = True

end event

type dw_filter from u_dw within tabpage_1
integer x = 55
integer y = 192
integer width = 3031
integer height = 128
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_salesorder_select"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_filter from u_button within tabpage_1
integer x = 3538
integer y = 208
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;call super::clicked;iuo_parent.Event ue_filter()

end event

type st_1 from statictext within tabpage_2
integer x = 73
integer y = 1800
integer width = 704
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Order Details:"
boolean focusrectangle = false
end type

type cb_add from u_button within u_salesorder
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

type cb_delete from u_button within u_salesorder
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
li_modified = li_modified + tab_1.tabpage_2.dw_detail.Modifiedcount()

IF li_modified  > 0 Then
	ib_modify = True
	w_main.ib_modify = True
Else
	ib_modify = False
	w_main.ib_modify = False
End IF
end event

type cb_save from u_button within u_salesorder
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

