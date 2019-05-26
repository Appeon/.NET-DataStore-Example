$PBExportHeader$uo_navigation.sru
forward
global type uo_navigation from userobject
end type
type uo_setting_bt from emf_u_picbutton within uo_navigation
end type
type uo_statistics_bt from emf_u_picbutton within uo_navigation
end type
type uo_address_bt from emf_u_picbutton within uo_navigation
end type
type uo_quit_bt from emf_u_picbutton within uo_navigation
end type
type uo_salesorder_bt from emf_u_picbutton within uo_navigation
end type
type uo_product_bt from emf_u_picbutton within uo_navigation
end type
type uo_customer_bt from emf_u_picbutton within uo_navigation
end type
end forward

global type uo_navigation from userobject
integer width = 521
integer height = 2028
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_registercanvas ( )
event type integer ue_switchcanvas ( string as_canvasname )
uo_setting_bt uo_setting_bt
uo_statistics_bt uo_statistics_bt
uo_address_bt uo_address_bt
uo_quit_bt uo_quit_bt
uo_salesorder_bt uo_salesorder_bt
uo_product_bt uo_product_bt
uo_customer_bt uo_customer_bt
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global uo_navigation uo_navigation

type variables
emf_selection_group inv_selection
end variables

forward prototypes
public function integer of_init_picbutton (emf_u_picbutton apo_obj, string as_name, string as_text)
public function integer of_active_button (string as_canvasname)
end prototypes

event ue_registercanvas();of_init_picbutton(uo_address_bt , 'Address', 'Address')
of_init_picbutton(uo_customer_bt, 'Customer','Customer')
of_init_picbutton(uo_product_bt, 'Product','Product')
of_init_picbutton(uo_salesorder_bt, 'SalesOrder','Order')
of_init_picbutton(uo_statistics_bt, 'SalesReport', 'Statistics')
of_init_picbutton(uo_setting_bt, 'Setup', 'Settings')
of_init_picbutton(uo_quit_bt, 'Quit','Quit')

uo_address_bt.p_picture.of_regPicture('address.png','address_active.png','address.png')
uo_customer_bt.p_picture.of_regPicture('customer.png','customer_active.png','customer.png')
uo_product_bt.p_picture.of_regPicture('product.png','product_active.png','product.png')
uo_salesorder_bt.p_picture.of_regPicture('order.png','order_active.png','order.png')
uo_statistics_bt.p_picture.of_regPicture('statistics.png','statistics_active.png','statistics.png')
uo_setting_bt.p_picture.of_regPicture('settings.png','settings_active.png','settings.png')
uo_quit_bt.p_picture.of_regPicture('quit.png','quit.png','quit.png')
end event

event type integer ue_switchcanvas(string as_canvasname);
parent.dynamic event ue_switchcanvas(as_canvasname)

return 1
end event

public function integer of_init_picbutton (emf_u_picbutton apo_obj, string as_name, string as_text);apo_obj.dynamic of_init_color()
apo_obj.dynamic of_setmenubackcolor(this.backcolor)
apo_obj.dynamic of_setname(as_name)
if as_text <> '' then
	apo_obj.dynamic of_settext(as_text)
end if

if not isvalid(inv_selection) then inv_selection = create emf_selection_group
inv_selection.dynamic of_addobject(apo_obj,as_name)

return 1
end function

public function integer of_active_button (string as_canvasname);powerobject apo_obj

if as_canvasname <> "Quit" then
	if isvalid(inv_selection) = false then 
		return -1
	end if
	apo_obj = inv_selection.of_getobject(as_canvasname)
	
	if isnull (apo_obj) or isvalid(apo_obj) = false then
		return -1
	end if
	
	inv_selection.dynamic of_active(apo_obj)
end if

end function

on uo_navigation.create
this.uo_setting_bt=create uo_setting_bt
this.uo_statistics_bt=create uo_statistics_bt
this.uo_address_bt=create uo_address_bt
this.uo_quit_bt=create uo_quit_bt
this.uo_salesorder_bt=create uo_salesorder_bt
this.uo_product_bt=create uo_product_bt
this.uo_customer_bt=create uo_customer_bt
this.Control[]={this.uo_setting_bt,&
this.uo_statistics_bt,&
this.uo_address_bt,&
this.uo_quit_bt,&
this.uo_salesorder_bt,&
this.uo_product_bt,&
this.uo_customer_bt}
end on

on uo_navigation.destroy
destroy(this.uo_setting_bt)
destroy(this.uo_statistics_bt)
destroy(this.uo_address_bt)
destroy(this.uo_quit_bt)
destroy(this.uo_salesorder_bt)
destroy(this.uo_product_bt)
destroy(this.uo_customer_bt)
end on

type uo_setting_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 1208
integer taborder = 30
end type

on uo_setting_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_statistics_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 976
integer taborder = 30
end type

on uo_statistics_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_address_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 48
integer taborder = 10
end type

on uo_address_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_quit_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 1440
integer taborder = 30
end type

on uo_quit_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_salesorder_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 744
integer taborder = 20
end type

on uo_salesorder_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_product_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 512
integer taborder = 20
end type

on uo_product_bt.destroy
call emf_u_picbutton::destroy
end on

type uo_customer_bt from emf_u_picbutton within uo_navigation
integer x = 41
integer y = 280
integer taborder = 10
end type

on uo_customer_bt.destroy
call emf_u_picbutton::destroy
end on

