$PBExportHeader$emf_u_picbutton.sru
forward
global type emf_u_picbutton from userobject
end type
type st_front from statictext within emf_u_picbutton
end type
type rr_back from rectangle within emf_u_picbutton
end type
type p_picture from emf_u_picture within emf_u_picbutton
end type
type st_text from statictext within emf_u_picbutton
end type
end forward

global type emf_u_picbutton from userobject
integer width = 439
integer height = 232
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_resize pbm_size
event ue_postconstructor ( )
event ue_active ( )
event ue_clicked ( )
event ue_deactive ( )
event ue_disabled ( )
event ue_enabled ( )
st_front st_front
rr_back rr_back
p_picture p_picture
st_text st_text
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global emf_u_picbutton emf_u_picbutton

type variables
string is_status //'A'-Active ,'F' -default 'D'-Disable
long il_def_fontcolor,il_def_backcolor,il_def_bordercolor
long il_sel_fontcolor,il_sel_backcolor,il_sel_bordercolor
long il_dis_fontcolor,il_dis_backcolor, il_dis_bordercolor
string is_name
integer ii_groupid


long il_st_df_fontcolor = 0 //16777215
long il_st_df_backgroundcolor = rgb(255,255,255) //15780518
long il_st_df_bordercolor = 13005312

long il_st_sel_fontcolor = 0 //3534476
long il_st_sel_backgroundcolor = rgb(255,255,255) //13005312
long il_st_sel_bordercolor = 13005312

long il_st_dis_fontcolor = 0 //11838605
long il_st_dis_backgroundcolor = rgb(255,255,255) //14009780
long il_st_dis_bordercolor = 13005312
end variables

forward prototypes
public function string of_getstatus ()
public function integer of_setstatus (string as_status)
public function string of_getname ()
public function integer of_setname (string as_name)
public function integer of_settext (string as_text)
public function integer of_regdefcolor (long al_fontcolor, long al_backcolor, long al_bordercolor)
public function integer of_regdiscolor (long al_fontcolor, long al_backcolor, long al_bordercolor)
public function integer of_init_color ()
public function integer of_setbackcolor (long al_color)
public function integer of_setfontcolor (long al_color)
public function integer of_setmenubackcolor (long il_color)
public function integer of_regselcolor (long al_fontcolor, long al_backcolor, long al_bordercolor)
public function integer of_setbordercolor (long al_color)
public function integer of_setcolor (long al_fontcolor, long al_backcolor, long al_boardercolor)
public function integer of_getgroupid ()
public function integer of_setgroupid (integer ai_groupid)
end prototypes

event ue_active();of_setcolor(il_sel_fontcolor,il_sel_backcolor,il_sel_bordercolor)
p_picture.Event ue_active()
is_status ='A'
end event

event ue_clicked();parent.dynamic event ue_switchcanvas(is_name)
end event

event ue_deactive();if is_status ='D' then return 
of_setcolor(il_def_fontcolor,il_def_backcolor,il_def_bordercolor)
p_picture.Event ue_deactive()
is_status ='F'
end event

event ue_disabled();of_setcolor(il_dis_fontcolor,il_dis_backcolor, il_dis_bordercolor)
p_picture.Event ue_disabled()
is_status ='D'
end event

event ue_enabled();of_setcolor(il_def_fontcolor,il_def_backcolor,il_def_bordercolor)
p_picture.Event ue_deactive()
is_status ='F'
end event

public function string of_getstatus ();return is_status

end function

public function integer of_setstatus (string as_status);is_status =as_status

return 1
end function

public function string of_getname ();return is_name
end function

public function integer of_setname (string as_name);is_name = as_name

return 1
end function

public function integer of_settext (string as_text);st_text.text = as_text

return 1
end function

public function integer of_regdefcolor (long al_fontcolor, long al_backcolor, long al_bordercolor); il_def_fontcolor = al_fontcolor
 il_def_backcolor = al_backcolor
  il_def_bordercolor =al_bordercolor
 this.backcolor = il_def_backcolor
 return 1
end function

public function integer of_regdiscolor (long al_fontcolor, long al_backcolor, long al_bordercolor); il_dis_fontcolor = al_fontcolor
 il_dis_backcolor = al_backcolor
  il_dis_bordercolor =al_bordercolor
  
 return 1
end function

public function integer of_init_color ();of_regdefcolor(il_st_df_fontcolor, il_st_df_backgroundcolor, il_st_df_bordercolor)
of_regselcolor(il_st_sel_fontcolor, il_st_sel_backgroundcolor, il_st_sel_bordercolor)
of_regdiscolor(il_st_dis_fontcolor, il_st_dis_backgroundcolor, il_st_dis_bordercolor)

return 1
end function

public function integer of_setbackcolor (long al_color);st_text.backcolor = al_color

rr_back.fillcolor  = al_color

st_front.backcolor =al_color

return 1
end function

public function integer of_setfontcolor (long al_color);st_text.textcolor = al_color

return 1
end function

public function integer of_setmenubackcolor (long il_color);this.backcolor = il_color

return 1
end function

public function integer of_regselcolor (long al_fontcolor, long al_backcolor, long al_bordercolor); il_sel_fontcolor = al_fontcolor
 il_sel_backcolor = al_backcolor
 il_sel_bordercolor =al_bordercolor
  
 return 1
end function

public function integer of_setbordercolor (long al_color);rr_back.linecolor = al_color

return 1
end function

public function integer of_setcolor (long al_fontcolor, long al_backcolor, long al_boardercolor);
if al_fontcolor >= 0 then 
	of_setfontcolor(al_fontcolor)
end if

if al_backcolor >= 0 then
	of_setBackColor(al_backcolor)
end if

if al_boardercolor >= 0 then
	of_setBorderColor(al_boardercolor)
end if

return 1
end function

public function integer of_getgroupid ();return ii_groupid 
end function

public function integer of_setgroupid (integer ai_groupid);ii_groupid = ai_groupid

return 1
end function

on emf_u_picbutton.create
this.st_front=create st_front
this.rr_back=create rr_back
this.p_picture=create p_picture
this.st_text=create st_text
this.Control[]={this.st_front,&
this.rr_back,&
this.p_picture,&
this.st_text}
end on

on emf_u_picbutton.destroy
destroy(this.st_front)
destroy(this.rr_back)
destroy(this.p_picture)
destroy(this.st_text)
end on

event constructor;

post event ue_postconstructor()
end event

type st_front from statictext within emf_u_picbutton
integer width = 439
integer height = 232
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;st_text.trigger event clicked()
end event

type rr_back from rectangle within emf_u_picbutton
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 1073741824
integer width = 384
integer height = 232
end type

type p_picture from emf_u_picture within emf_u_picbutton
integer x = 146
integer y = 24
integer width = 146
integer height = 116
boolean bringtotop = true
end type

event clicked;call super::clicked;st_text.trigger event clicked()
end event

event ue_lbuttondown;return 0
end event

event ue_lbuttonup;return 0
end event

type st_text from statictext within emf_u_picbutton
integer x = 5
integer y = 140
integer width = 443
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;if of_getstatus()='D' then return
parent.trigger event ue_clicked()

end event

