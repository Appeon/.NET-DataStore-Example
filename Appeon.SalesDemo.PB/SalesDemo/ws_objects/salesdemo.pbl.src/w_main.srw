$PBExportHeader$w_main.srw
forward
global type w_main from w_base
end type
type uo_nav from uo_navigation within w_main
end type
type uo_salesreport from u_salesreport within w_main
end type
type st_setup from statictext within w_main
end type
type st_report from statictext within w_main
end type
type ddlb_service_select from dropdownlistbox within w_main
end type
type uo_persons from u_person within w_main
end type
type uo_products from u_product within w_main
end type
type uo_addresses from u_address within w_main
end type
type uo_sales from u_salesorder within w_main
end type
type st_quit from statictext within w_main
end type
type st_salesorder from statictext within w_main
end type
type st_product from statictext within w_main
end type
type st_customer from statictext within w_main
end type
type st_address from statictext within w_main
end type
type p_1 from picture within w_main
end type
end forward

global type w_main from w_base
integer width = 4581
integer height = 2880
string title = "Sales CRM Demo"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 16777215
string icon = ".\image\crm.ico"
event ue_switchcanvas ( string as_canvasname )
uo_nav uo_nav
uo_salesreport uo_salesreport
st_setup st_setup
st_report st_report
ddlb_service_select ddlb_service_select
uo_persons uo_persons
uo_products uo_products
uo_addresses uo_addresses
uo_sales uo_sales
st_quit st_quit
st_salesorder st_salesorder
st_product st_product
st_customer st_customer
st_address st_address
p_1 p_1
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global w_main w_main

type variables
Boolean ib_modify = False
String    is_model
u_tab_base uo_current
end variables

forward prototypes
public function integer of_selmodel (string as_model)
end prototypes

event ue_switchcanvas(string as_canvasname);IF as_canvasname <> "Setup" THEN This.SetRedraw(False)
IF of_selmodel(as_canvasname) = 1 Then
	uo_nav.of_active_button(as_canvasname)
	is_model = as_canvasname
End IF
IF as_canvasname <> "Setup" THEN This.Post SetRedraw(True)

end event

public function integer of_selmodel (string as_model);//====================================================================
//$<Function>: of_selmodel
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_ret

IF is_model = as_model  and is_model <> "Setup" Then Return 0
IF as_model = "Setup"  and  is_model = as_model Then
	IF IsValid(w_setup) THEN 
		w_setup.SetPosition(ToTop!)
		Return 0
	END IF
END IF
IF ib_modify Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		Return 0	
	Else
		ib_modify = False
	End IF
End IF

IF IsValid(uo_current) THEN
	IF uo_current.Visible THEN
		IF as_model = "Setup" THEN This.SetRedraw(False)
		uo_current.Visible = False
		IF as_model = "Setup" THEN This.SetRedraw(True)
	END IF
END IF

Choose Case as_model
	Case "Address"
		uo_addresses.Visible = True
		uo_addresses.SetFocus()
		uo_addresses.tab_1.SelectedTab = 1
		uo_addresses.of_winopen()
		uo_addresses.tab_1.tabpage_1.dw_browser.SetFocus()
		uo_current = uo_addresses
	Case "Customer"
		uo_persons.Visible = True
		uo_persons.SetFocus()
		uo_persons.tab_1.SelectedTab = 1
		uo_persons.of_winopen()
		uo_persons.tab_1.tabpage_1.dw_browser.SetFocus()
		uo_current = uo_persons
	Case "Product"
		uo_products.Visible = True
		uo_products.SetFocus()
		uo_products.tab_1.SelectedTab = 1
		uo_products.of_winopen()
		uo_products.tab_1.tabpage_1.dw_browser.SetFocus()		
		uo_current = uo_products
	Case "SalesOrder"
		uo_sales.Visible = True
		uo_sales.SetFocus()
		uo_sales.tab_1.SelectedTab = 1
		uo_sales.of_winopen()
		uo_sales.tab_1.tabpage_1.dw_browser.SetFocus()
		uo_current = uo_sales
	Case "SalesReport"
		uo_salesreport.Visible = True
		uo_salesreport.SetFocus()
		uo_salesreport.tab_1.SelectedTab = 1
		uo_salesreport.of_winopen()
		uo_salesreport.tab_1.tabpage_1.dw_browser.SetFocus()
		If uo_salesreport.tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
			uo_salesreport.of_set_backcolor()
		End If
		uo_current = uo_salesreport
	Case "Setup"
		open(w_setup)
	
	Case "Quit"
		st_quit.post event clicked()
End Choose

//This.SetRedraw(True)
Return 1
end function

on w_main.create
int iCurrent
call super::create
this.uo_nav=create uo_nav
this.uo_salesreport=create uo_salesreport
this.st_setup=create st_setup
this.st_report=create st_report
this.ddlb_service_select=create ddlb_service_select
this.uo_persons=create uo_persons
this.uo_products=create uo_products
this.uo_addresses=create uo_addresses
this.uo_sales=create uo_sales
this.st_quit=create st_quit
this.st_salesorder=create st_salesorder
this.st_product=create st_product
this.st_customer=create st_customer
this.st_address=create st_address
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nav
this.Control[iCurrent+2]=this.uo_salesreport
this.Control[iCurrent+3]=this.st_setup
this.Control[iCurrent+4]=this.st_report
this.Control[iCurrent+5]=this.ddlb_service_select
this.Control[iCurrent+6]=this.uo_persons
this.Control[iCurrent+7]=this.uo_products
this.Control[iCurrent+8]=this.uo_addresses
this.Control[iCurrent+9]=this.uo_sales
this.Control[iCurrent+10]=this.st_quit
this.Control[iCurrent+11]=this.st_salesorder
this.Control[iCurrent+12]=this.st_product
this.Control[iCurrent+13]=this.st_customer
this.Control[iCurrent+14]=this.st_address
this.Control[iCurrent+15]=this.p_1
end on

on w_main.destroy
call super::destroy
destroy(this.uo_nav)
destroy(this.uo_salesreport)
destroy(this.st_setup)
destroy(this.st_report)
destroy(this.ddlb_service_select)
destroy(this.uo_persons)
destroy(this.uo_products)
destroy(this.uo_addresses)
destroy(this.uo_sales)
destroy(this.st_quit)
destroy(this.st_salesorder)
destroy(this.st_product)
destroy(this.st_customer)
destroy(this.st_address)
destroy(this.p_1)
end on

event open;call super::open;SetRedraw(false)
//Select ModelMapper
uo_nav.Event ue_registercanvas()
ddlb_service_select.SelectItem(3)
ddlb_service_select.Event SelectionChanged(3)
SetRedraw(true)
end event

event closequery;call super::closequery;IF IsValid(w_setup) THEN Close(w_setup)
end event

type uo_nav from uo_navigation within w_main
integer height = 2800
integer taborder = 70
end type

on uo_nav.destroy
call uo_navigation::destroy
end on

type uo_salesreport from u_salesreport within w_main
boolean visible = false
integer x = 521
integer width = 4050
integer height = 2800
integer taborder = 50
end type

on uo_salesreport.destroy
call u_salesreport::destroy
end on

type st_setup from statictext within w_main
boolean visible = false
integer x = 101
integer y = 1072
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Settings"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("Setup") = 1 Then
	is_model = "Setup"
End IF
end event

type st_report from statictext within w_main
boolean visible = false
integer x = 101
integer y = 892
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Statistics"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("SalesReport") = 1 Then
	is_model = "SalesReport"
End IF
end event

type ddlb_service_select from dropdownlistbox within w_main
boolean visible = false
integer x = 37
integer y = 8
integer width = 549
integer height = 476
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"DataStore","ModelStore","ModelMapper"}
borderstyle borderstyle = styleraised!
end type

event selectionchanged;//f_changeservice(index)
end event

type uo_persons from u_person within w_main
boolean visible = false
integer x = 521
integer width = 4050
integer height = 2800
integer taborder = 20
end type

on uo_persons.destroy
call u_person::destroy
end on

type uo_products from u_product within w_main
boolean visible = false
integer x = 521
integer width = 4050
integer height = 2800
integer taborder = 50
end type

on uo_products.destroy
call u_product::destroy
end on

type uo_addresses from u_address within w_main
boolean visible = false
integer x = 521
integer width = 4050
integer height = 2800
integer taborder = 40
end type

on uo_addresses.destroy
call u_address::destroy
end on

type uo_sales from u_salesorder within w_main
boolean visible = false
integer x = 521
integer width = 4050
integer height = 2800
integer taborder = 50
end type

on uo_sales.destroy
call u_salesorder::destroy
end on

type st_quit from statictext within w_main
boolean visible = false
integer x = 101
integer y = 1252
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Quit"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;close(parent)
end event

type st_salesorder from statictext within w_main
boolean visible = false
integer x = 101
integer y = 712
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Order"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("SalesOrder") = 1 Then
	is_model = "SalesOrder"
End IF
end event

type st_product from statictext within w_main
boolean visible = false
integer x = 101
integer y = 532
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Product"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("Product") = 1 Then
	is_model = "Product"
End IF

end event

type st_customer from statictext within w_main
boolean visible = false
integer x = 101
integer y = 352
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Customer"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("Customer") = 1 Then
	is_model = "Customer"
End IF

end event

type st_address from statictext within w_main
boolean visible = false
integer x = 101
integer y = 172
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "Address"
long bordercolor = 16777215
boolean focusrectangle = false
end type

event clicked;IF of_selmodel("Address") = 1 Then
	is_model = "Address"
End IF

end event

type p_1 from picture within w_main
integer width = 4571
integer height = 2800
string picturename = "image\background.PNG"
boolean focusrectangle = false
end type

