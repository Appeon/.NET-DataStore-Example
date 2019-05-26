$PBExportHeader$u_salesreport.sru
forward
global type u_salesreport from u_tab_base
end type
type dw_filter from u_dw within tabpage_1
end type
type cb_filter from u_button within tabpage_1
end type
type htb_1 from htrackbar within tabpage_1
end type
type cbx_pie from checkbox within tabpage_1
end type
type cbx_salesroom from checkbox within tabpage_1
end type
type cbx_saleqty from checkbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_subfilter from u_dw within tabpage_2
end type
type cb_subfilter from u_button within tabpage_2
end type
type ddplb_graph from dropdownpicturelistbox within u_salesreport
end type
type st_graph from statictext within u_salesreport
end type
end forward

global type u_salesreport from u_tab_base
integer width = 3991
integer height = 2736
long backcolor = 16777215
event type integer ue_categoryreport_preview ( )
event type integer ue_subcategoryreport_preview ( )
ddplb_graph ddplb_graph
st_graph st_graph
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global u_salesreport u_salesreport

type variables
u_salesreport iuo_report
String is_controllername = 'OrderReport'

private:
n_cst_webapi_salesreport  inv_webapi
end variables

forward prototypes
public function integer of_winopen ()
public function integer of_selectgraph (integer ai_index)
public function integer of_data_verify ()
public function integer of_zoom (integer ai_zoom)
public function integer of_setdwvisible ()
public subroutine of_set_backcolor ()
end prototypes

event type integer ue_categoryreport_preview();String ls_from
String ls_to

tab_1.tabpage_1.dw_filter.AcceptText()
ls_from = String(tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_from"), "yyyy-mm-dd")
ls_to = String(tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_to"), "yyyy-mm-dd")

tab_1.tabpage_1.dw_browser.Reset()
inv_webapi.of_categoryreport(tab_1.tabpage_1.dw_browser, ls_from, ls_to)
of_setdwvisible()

Return 1
end event

event type integer ue_subcategoryreport_preview();Long ll_subcategoryid
String ls_year
String ls_annual

tab_1.tabpage_2.dw_subfilter.AcceptText()
ll_subcategoryid = tab_1.tabpage_2.dw_subfilter.GetItemnumber(1, "subcategoryid")
ls_year = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "year")
ls_annual = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "annual")

inv_webapi.of_subcategoryreport(tab_1.tabpage_2.dw_master, ll_subcategoryid, ls_year, ls_annual)

Return 1
end event

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

IF tab_1.tabpage_2.dw_subfilter.RowCount() < 1 Then
	tab_1.tabpage_2.dw_subfilter.InsertRow(1)	
End IF


//Retrieve Dddw
inv_webapi.of_winopen(tab_1.tabpage_2.dw_subfilter, tab_1.tabpage_1.dw_browser,  tab_1.tabpage_2.dw_master)

tab_1.tabpage_2.dw_subfilter.SetItem(1, "categoryid", 1)
tab_1.tabpage_2.dw_subfilter.SetItem(1, "subcategoryid", 1)
tab_1.tabpage_2.dw_subfilter.SetItem(1, "year", "2013")
tab_1.tabpage_2.dw_subfilter.SetItem(1, "annual", "first")

Return 1
end function

public function integer of_selectgraph (integer ai_index);Datawindowchild ldwc_graph

tab_1.tabpage_2.dw_master.GetChild("dw_subcategorysalesreport_graph", ldwc_graph)

Choose Case ai_index
	Case 1
		ldwc_graph.Modify("gr_1.GraphType='7'") 
	Case 2
		ldwc_graph.Modify("gr_1.GraphType='9'")  
	Case 3
		ldwc_graph.Modify("gr_1.GraphType='1'")  
	Case 4
		ldwc_graph.Modify("gr_1.GraphType='5'")  
	Case 5
		ldwc_graph.Modify("gr_1.GraphType='12'")  
End Choose

IF ai_index = 4 THEN
	ldwc_graph.modify("gr_1.values.dispattr.alignment='2'")
	ldwc_graph.modify('gr_1.values.labeldispattr.font.escapement="0"')
	ldwc_graph.modify('gr_1.values.labeldispattr.font.orientation="0"')
	ldwc_graph.modify('gr_1.category.dispattr.alignment="1"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.orientation="900"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.escapement="900"')
ELSE
	ldwc_graph.modify("gr_1.values.dispattr.alignment='1'")
	ldwc_graph.modify('gr_1.values.labeldispattr.font.escapement="900"')
	ldwc_graph.modify('gr_1.values.labeldispattr.font.orientation="900"')
	ldwc_graph.modify('gr_1.category.dispattr.alignment="2"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.orientation="0"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.escapement="0"')
END IF

Return 1
end function

public function integer of_data_verify ();String ls_year
Long ll_subcategoryid
DateTime ldt_from
DateTime ldt_to

Choose Case iuo_currentdw.ClassName()
	Case "dw_filter"
		tab_1.tabpage_1.dw_filter.AcceptText()
		ldt_from = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_from")
		ldt_to = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_to")
		
		IF Year(Date(ldt_from)) <> Year(Date(ldt_to)) Then
			MessageBox("Prompt", "Please select a date of the same year.")
			Return -1
		End IF
		
	Case "dw_subfilter"
		tab_1.tabpage_2.dw_subfilter.AcceptText()
		ll_subcategoryid = tab_1.tabpage_2.dw_subfilter.GetItemnumber(1, "subcategoryid")
		ls_year = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "year")
		
		IF IsNull(ll_subcategoryid) Then
			MessageBox("Prompt", "Sub Category is required.")
			Return -1
		End IF
		
		IF IsNull(ls_year)  or ls_year = "" Then
			MessageBox("Prompt", "Please set Year first ! ")
			Return -1
		End IF
End Choose

Return 1
end function

public function integer of_zoom (integer ai_zoom);
tab_1.tabpage_1.dw_browser.object.datawindow.print.preview.zoom = ai_zoom * 2

Return 1
end function

public function integer of_setdwvisible ();u_dw idw_currentdw
DataWindowChild ldwc_child

idw_currentdw = tab_1.tabpage_1.dw_browser

IF Not tab_1.tabpage_1.cbx_pie.Checked Then
	idw_currentdw.GetChild("dw_catereport_pie", ldwc_child)
	ldwc_child.ReSet()
End IF

IF Not tab_1.tabpage_1.cbx_salesroom.Checked Then
	idw_currentdw.GetChild("dw_compare", ldwc_child)
	ldwc_child.ReSet()
End IF

IF Not tab_1.tabpage_1.cbx_saleqty.Checked Then
	idw_currentdw.GetChild("dw_qty", ldwc_child)
	ldwc_child.ReSet()	
End IF

Return 1
end function

public subroutine of_set_backcolor ();datawindowchild ldc_a
String ls_color
String ls_theme
String ls_file

ls_file = "apisetup.ini"
ls_theme = ProfileString(ls_file, "Setup", "Theme", "Flat Design Blue")
ls_color = ProfileString(ls_file, "BackColor", ls_theme, "16764603")

tab_1.tabpage_1.dw_browser.getchild('dw_catereport', ldc_a)
ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")

tab_1.tabpage_1.dw_browser.getchild('dw_reportlist', ldc_a)
ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")

tab_1.tabpage_2.dw_master.getchild('dw_subcategorysalesreport', ldc_a)
ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")

tab_1.tabpage_2.dw_master.getchild('dw_productsalesreport', ldc_a)
ldc_a.Modify("t_2.Background.Color='" + ls_color + "'")
end subroutine

on u_salesreport.create
int iCurrent
call super::create
this.ddplb_graph=create ddplb_graph
this.st_graph=create st_graph
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_graph
this.Control[iCurrent+2]=this.st_graph
end on

on u_salesreport.destroy
call super::destroy
destroy(this.ddplb_graph)
destroy(this.st_graph)
end on

event constructor;call super::constructor;iuo_report = this

IF tab_1.tabpage_1.dw_filter.RowCount() < 1 Then
	tab_1.tabpage_1.dw_filter.InsertRow(1)
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_from", DateTime("2013-01-01"))
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_to", DateTime("2013-12-31"))
End IF

IF tab_1.tabpage_2.dw_subfilter.RowCount() < 1 Then
	tab_1.tabpage_2.dw_subfilter.InsertRow(1)	
End IF
end event

type tab_1 from u_tab_base`tab_1 within u_salesreport
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
		st_graph.visible = False
		ddplb_graph.visible = False
		iuo_currentdw = tab_1.tabpage_1.dw_filter
	Case 2
		st_graph.visible = True
		ddplb_graph.visible = True
		iuo_currentdw = tab_1.tabpage_2.dw_subfilter
End Choose
end event

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3954
integer height = 2536
string text = " Category Statistics "
dw_filter dw_filter
cb_filter cb_filter
htb_1 htb_1
cbx_pie cbx_pie
cbx_salesroom cbx_salesroom
cbx_saleqty cbx_saleqty
st_1 st_1
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.cb_filter=create cb_filter
this.htb_1=create htb_1
this.cbx_pie=create cbx_pie
this.cbx_salesroom=create cbx_salesroom
this.cbx_saleqty=create cbx_saleqty
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_filter
this.Control[iCurrent+3]=this.htb_1
this.Control[iCurrent+4]=this.cbx_pie
this.Control[iCurrent+5]=this.cbx_salesroom
this.Control[iCurrent+6]=this.cbx_saleqty
this.Control[iCurrent+7]=this.st_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_filter)
destroy(this.htb_1)
destroy(this.cbx_pie)
destroy(this.cbx_salesroom)
destroy(this.cbx_saleqty)
destroy(this.st_1)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 564
integer width = 3845
integer height = 1936
string dataobject = "d_categorysalesreport_m"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_browser::getfocus;//
end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3954
integer height = 2536
string text = " Subcategory Statistics "
dw_subfilter dw_subfilter
cb_subfilter cb_subfilter
end type

on tabpage_2.create
this.dw_subfilter=create dw_subfilter
this.cb_subfilter=create cb_subfilter
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_subfilter
this.Control[iCurrent+2]=this.cb_subfilter
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_subfilter)
destroy(this.cb_subfilter)
end on

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 404
integer width = 3845
integer height = 2084
string dataobject = "d_subcategorysalesreport_m"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_master::getfocus;//
end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
boolean visible = false
end type

type dw_filter from u_dw within tabpage_1
integer x = 55
integer y = 396
integer width = 1691
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_salesorder_select"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_filter from u_button within tabpage_1
integer x = 1778
integer y = 404
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return

Parent.SetRedraw(False)

iuo_report.Event ue_categoryreport_preview()

of_set_backcolor()

Parent.Post SetRedraw(True)

end event

type htb_1 from htrackbar within tabpage_1
integer x = 2578
integer y = 408
integer width = 1358
integer height = 124
boolean bringtotop = true
integer maxposition = 100
integer position = 50
integer tickfrequency = 10
integer pagesize = 50
integer linesize = 50
end type

event moved;of_zoom(scrollpos)
end event

type cbx_pie from checkbox within tabpage_1
integer x = 64
integer y = 56
integer width = 2807
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
string text = "Show sales percentages of different categories."
boolean checked = true
end type

type cbx_salesroom from checkbox within tabpage_1
integer x = 64
integer y = 164
integer width = 2807
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
string text = "Compare the sales amount of the selected period and the previous period by category."
boolean checked = true
end type

type cbx_saleqty from checkbox within tabpage_1
integer x = 64
integer y = 272
integer width = 2807
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
string text = "Compare the sales volumes of the selected period and the previous period by category."
end type

type st_1 from statictext within tabpage_1
integer x = 2350
integer y = 408
integer width = 238
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Zoom:"
boolean focusrectangle = false
end type

type dw_subfilter from u_dw within tabpage_2
integer x = 64
integer y = 44
integer width = 3419
integer height = 128
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_subreport_filter"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;DatawindowChild ldwc_sub
Long ll_null

IF row < 1 Then Return

SetNull(ll_null)

Choose Case dwo.name
	Case "categoryid"
		This.SetItem(row,"subcategoryid", ll_null)
		This.GetChild("subcategoryid", ldwc_sub)
		ldwc_sub.SetFilter("productcategoryid = " + data)
		ldwc_sub.Filter()
		ldwc_sub.SetFilter("")
End Choose

end event

type cb_subfilter from u_button within tabpage_2
integer x = 3529
integer y = 56
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return

Parent.SetRedraw(False)

iuo_report.Event ue_subcategoryreport_preview()

of_set_backcolor()

Parent.Post SetRedraw(True)

end event

type ddplb_graph from dropdownpicturelistbox within u_salesreport
boolean visible = false
integer x = 411
integer y = 420
integer width = 782
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Col","Col3DObj","Area","Bar","Line"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2,3,4,5}
string picturename[] = {"Control Graph_2!","Graph!","image\Area.PNG","image\Bar.PNG","image\Line.PNG"}
long picturemaskcolor = 536870912
end type

event selectionchanged;of_selectgraph(index)
end event

type st_graph from statictext within u_salesreport
boolean visible = false
integer x = 78
integer y = 424
integer width = 325
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Graph Style:"
boolean focusrectangle = false
end type

