$PBExportHeader$u_tab_base.sru
forward
global type u_tab_base from userobject
end type
type tab_1 from tab within u_tab_base
end type
type tabpage_1 from userobject within tab_1
end type
type dw_browser from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_browser dw_browser
end type
type tabpage_2 from userobject within tab_1
end type
type dw_master from u_dw within tabpage_2
end type
type dw_detail from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_master dw_master
dw_detail dw_detail
end type
type tab_1 from tab within u_tab_base
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type u_tab_base from userobject
integer width = 3291
integer height = 2156
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type integer ue_add ( )
event type integer ue_delete ( )
event type integer ue_save ( )
event type integer ue_filter ( )
tab_1 tab_1
end type
global u_tab_base u_tab_base

type variables
u_dw iuo_currentdw
u_tab_base iuo_parent
Boolean ib_modify = False

 
end variables

forward prototypes
public function integer of_data_verify ()
public function integer of_winopen ()
public function integer of_retrieve (u_dw adw_data, string as_data)
end prototypes

event type integer ue_add();

Return 1
end event

event type integer ue_delete();Integer li_row
DwItemStatus ldws_status

li_row = iuo_currentdw.GetRow()

IF li_row < 1 Then Return 1
ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
IF ldws_status = New! Or ldws_status = NewModified! Then
	iuo_currentdw.DeleteRow(li_row)
	iuo_currentdw.ReSetUpdate()
	Return 1
End IF

Return 1
end event

event type integer ue_save();
Return 1
end event

event type integer ue_filter();
Return 1
end event

public function integer of_data_verify ();return 1
end function

public function integer of_winopen ();return 1
end function

public function integer of_retrieve (u_dw adw_data, string as_data);return 1
end function

on u_tab_base.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on u_tab_base.destroy
destroy(this.tab_1)
end on

event constructor;iuo_parent = This
end event

type tab_1 from tab within u_tab_base
integer x = 5
integer width = 3287
integer height = 2164
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = Center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3250
integer height = 2032
long backcolor = 67108864
string text = "  Browse  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_browser dw_browser
end type

on tabpage_1.create
this.dw_browser=create dw_browser
this.Control[]={this.dw_browser}
end on

on tabpage_1.destroy
destroy(this.dw_browser)
end on

type dw_browser from u_dw within tabpage_1
event ue_save ( )
integer x = 9
integer y = 8
integer width = 3232
integer height = 2028
integer taborder = 10
boolean vscrollbar = true
end type

event ue_save();//
end event

event getfocus;call super::getfocus;iuo_currentdw = This

end event

event doubleclicked;call super::doubleclicked;tab_1.SelectTab(2)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3250
integer height = 2032
long backcolor = 67108864
string text = "Detail"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_master dw_master
dw_detail dw_detail
end type

on tabpage_2.create
this.dw_master=create dw_master
this.dw_detail=create dw_detail
this.Control[]={this.dw_master,&
this.dw_detail}
end on

on tabpage_2.destroy
destroy(this.dw_master)
destroy(this.dw_detail)
end on

type dw_master from u_dw within tabpage_2
integer x = 9
integer y = 16
integer width = 3232
integer height = 1364
integer taborder = 30
end type

event getfocus;call super::getfocus;iuo_currentdw = This
end event

type dw_detail from u_dw within tabpage_2
integer x = 9
integer y = 1464
integer width = 3232
integer height = 572
integer taborder = 40
end type

event getfocus;call super::getfocus;iuo_currentdw = this
end event

