$PBExportHeader$w_progressbar.srw
forward
global type w_progressbar from w_base
end type
type st_1 from statictext within w_progressbar
end type
type hpb_1 from hprogressbar within w_progressbar
end type
end forward

global type w_progressbar from w_base
integer width = 1655
integer height = 464
string title = "Process"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
st_1 st_1
hpb_1 hpb_1
end type
global w_progressbar w_progressbar

on w_progressbar.create
int iCurrent
call super::create
this.st_1=create st_1
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.hpb_1
end on

on w_progressbar.destroy
call super::destroy
destroy(this.st_1)
destroy(this.hpb_1)
end on

event timer;call super::timer;IF hpb_1.position < 80 Then
	hpb_1.position = hpb_1.position + 5
End IF

Return 1
end event

event open;call super::open;timer(1)
end event

type st_1 from statictext within w_progressbar
integer x = 82
integer y = 72
integer width = 1271
integer height = 92
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Retrieving data. Please wait..."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_progressbar
integer x = 73
integer y = 212
integer width = 1490
integer height = 76
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 1
boolean smoothscroll = true
end type

