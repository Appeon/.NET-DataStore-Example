$PBExportHeader$w_setup.srw
forward
global type w_setup from window
end type
type ddlb_theme from dropdownlistbox within w_setup
end type
type ddlb_1 from dropdownlistbox within w_setup
end type
type st_1 from statictext within w_setup
end type
type st_theme from statictext within w_setup
end type
type ddlb_modeltype from dropdownlistbox within w_setup
end type
type sle_url from singlelineedit within w_setup
end type
type st_url from statictext within w_setup
end type
type modeltype_t from statictext within w_setup
end type
type rb_cloud from radiobutton within w_setup
end type
type rb_local from radiobutton within w_setup
end type
type cb_close from u_button within w_setup
end type
type cb_save from u_button within w_setup
end type
type dw_setup from u_dw within w_setup
end type
end forward

global type w_setup from window
integer width = 2400
integer height = 1280
boolean titlebar = true
string title = "Settings"
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
ddlb_theme ddlb_theme
ddlb_1 ddlb_1
st_1 st_1
st_theme st_theme
ddlb_modeltype ddlb_modeltype
sle_url sle_url
st_url st_url
modeltype_t modeltype_t
rb_cloud rb_cloud
rb_local rb_local
cb_close cb_close
cb_save cb_save
dw_setup dw_setup
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global w_setup w_setup

type variables
String is_file
String is_theme
String is_theme_path = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme180\"
end variables

forward prototypes
public subroutine of_itemchanged (string as_name, string as_data)
public subroutine of_deactive ()
public subroutine of_add_theme ()
end prototypes

public subroutine of_itemchanged (string as_name, string as_data);String ls_defaulturl
String ls_hosttype
String ls_modeltype

Choose Case as_name
	Case "hosttype"
		ls_modeltype = ddlb_modeltype.Text
		ls_hosttype = as_data
	Case "modeltype"
		ls_modeltype = ddlb_modeltype.Text
		If rb_local.Checked Then
			ls_hosttype = "1"
		Else
			ls_hosttype = "2"
		End IF
End Choose

IF ls_hosttype = "1" Then
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
		Case "ModelMapper"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelmapperdefaulturl", "")
	End Choose
Else
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
		Case "ModelMapper"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelmapperdefaulturl", "")
	End Choose
End IF
sle_url.Text = ls_defaulturl
//dw_setup.SetItem(1, "url", ls_defaulturl)
end subroutine

public subroutine of_deactive ();IF IsValid(w_main) THEN
	w_main.uo_nav.uo_setting_bt.Event ue_deactive()
	w_main.is_model = ""
END IF
end subroutine

public subroutine of_add_theme ();Int i
String ls_theme_name
String ls_current_path
ls_current_path = GetCurrentDirectory( )

ddlb_1.DirList(is_theme_path+'*.*', 32768+16) 

For i = 2 To ddlb_1.totalitems( )
	ls_theme_name = ddlb_1.text(i)
	IF Left(ls_theme_name,1) = "[" THEN ls_theme_name = Mid(ls_theme_name, 2)
	IF Right(ls_theme_name,1) = "]" THEN ls_theme_name = Left(ls_theme_name, Len(ls_theme_name) - 1)
	ls_theme_name = Trim(ls_theme_name)
	IF FileExists(is_theme_path + ls_theme_name + "\theme.json") THEN
		ddlb_theme.Additem(ls_theme_name)
	END IF
Next 
ddlb_theme.Additem("Do Not Use Themes")

ChangeDirectory(ls_current_path)
end subroutine

on w_setup.create
this.ddlb_theme=create ddlb_theme
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_theme=create st_theme
this.ddlb_modeltype=create ddlb_modeltype
this.sle_url=create sle_url
this.st_url=create st_url
this.modeltype_t=create modeltype_t
this.rb_cloud=create rb_cloud
this.rb_local=create rb_local
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_setup=create dw_setup
this.Control[]={this.ddlb_theme,&
this.ddlb_1,&
this.st_1,&
this.st_theme,&
this.ddlb_modeltype,&
this.sle_url,&
this.st_url,&
this.modeltype_t,&
this.rb_cloud,&
this.rb_local,&
this.cb_close,&
this.cb_save,&
this.dw_setup}
end on

on w_setup.destroy
destroy(this.ddlb_theme)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_theme)
destroy(this.ddlb_modeltype)
destroy(this.sle_url)
destroy(this.st_url)
destroy(this.modeltype_t)
destroy(this.rb_cloud)
destroy(this.rb_local)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_setup)
end on

event open;String ls_url
String ls_defaulturl
String ls_hosttype
Int li_modeltype
String ls_theme
This.SetRedraw(False)
is_file = "apisetup.ini"
ls_hosttype = ProfileString(is_file, "Setup", "HostType", "1")
li_modeltype = ProfileInt(is_file, "Setup", "ModelType", 3)
ls_url = ProfileString(is_file, "Setup", "URL", "")
ls_theme = ProfileString(is_file, "Setup", "Theme", "Flat Design Blue")

IF ls_hosttype = "1" THEN
	rb_local.Checked = True
	rb_cloud.Checked = False
ELSE
	rb_local.Checked = False
	rb_cloud.Checked = True
END IF

of_add_theme()
ddlb_theme.Text = ls_theme
is_theme = ls_theme

Choose Case li_modeltype
	Case 1
		ddlb_modeltype.TEXT = 'DataStore'
	Case 2
		ddlb_modeltype.TEXT = 'ModelStore'
	Case 3
		ddlb_modeltype.TEXT = 'ModelMapper'
End Choose


IF Isnull(ls_url) Or ls_url = "" Then	
	IF ls_hosttype = "1" Then
		Choose Case li_modeltype
			Case 1
				ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
			Case 2
				ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
			Case 3
				ls_defaulturl = ProfileString(is_file, "LocalHost", "modelmapperdefaulturl", "")
		End Choose
	Else
		Choose Case li_modeltype
			Case 1
				ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
			Case 2
				ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
			Case 3
				ls_defaulturl = ProfileString(is_file, "CloudHost", "modelmapperdefaulturl", "")
		End Choose
	End IF
	
	sle_url.Text = ls_defaulturl
	SetProfileString(is_file, "Setup", "URL", ls_defaulturl)
	gs_host = "http://" + ls_defaulturl	
Else
	sle_url.Text = ls_url
	gs_host = "http://" + ls_url	
End IF
gi_service_type = li_modeltype
This.SetRedraw(True)


end event

event closequery;of_deactive()
end event

type ddlb_theme from dropdownlistbox within w_setup
integer x = 731
integer y = 756
integer width = 1029
integer height = 504
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_setup
boolean visible = false
integer x = 87
integer y = 100
integer width = 869
integer height = 476
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_setup
integer x = 731
integer y = 544
integer width = 1042
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 553648127
string text = "Please enter the IP address/host name and port, for example, 172.0.0.1:8001."
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type st_theme from statictext within w_setup
integer x = 238
integer y = 768
integer width = 462
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Theme:"
alignment alignment = right!
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type ddlb_modeltype from dropdownlistbox within w_setup
integer x = 731
integer y = 256
integer width = 1029
integer height = 424
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"DataStore","ModelStore","ModelMapper"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;of_itemchanged("modeltype", String(index))
end event

type sle_url from singlelineedit within w_setup
integer x = 731
integer y = 436
integer width = 1033
integer height = 96
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_url from statictext within w_setup
integer x = 242
integer y = 436
integer width = 457
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "URL:"
alignment alignment = right!
boolean focusrectangle = false
end type

type modeltype_t from statictext within w_setup
integer x = 238
integer y = 264
integer width = 462
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Model Type:"
alignment alignment = right!
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type rb_cloud from radiobutton within w_setup
integer x = 1349
integer y = 92
integer width = 489
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Cloud Host"
end type

event clicked;of_itemchanged("hosttype", "2")
end event

type rb_local from radiobutton within w_setup
integer x = 713
integer y = 92
integer width = 485
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Local Host"
end type

event clicked;of_itemchanged("hosttype", "1")
end event

type cb_close from u_button within w_setup
integer x = 1399
integer y = 996
integer width = 366
integer height = 96
integer taborder = 30
integer textsize = -10
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;call super::clicked;
//dw_setup.accepttext()
//
//IF dw_setup.modifiedcount() > 0 Then
//	Messagebox("Prompt", "Please save the data first.")
//	Return 1
//End IF

Close(parent)
end event

type cb_save from u_button within w_setup
integer x = 722
integer y = 996
integer width = 366
integer height = 96
integer taborder = 20
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;String ls_url
String ls_hosttype
String ls_modeltype
String ls_theme
String ls_hostname
String ls_modelname
String ls_msg
Int li_ret

ls_url = sle_url.Text
IF rb_local.Checked THEN
	ls_hosttype = "1"
	ls_hostname = "LocalHost"
ELSE
	ls_hosttype = "2"
	ls_hostname = "CloudHost"
END IF

ls_theme = Trim(ddlb_theme.Text )
//applyskintheme(ls_theme)
IF ls_theme <> is_theme THEN
	ls_msg = "~r~nYou modified the theme. You must restart your application for the changes to take effect."
	ls_msg += "~r~nDo you want to restart the application now?"
END IF

Choose Case ddlb_modeltype.Text 
	Case 'DataStore'
		ls_modeltype = '1'
		ls_modelname = "datastoredefaulturl"
	Case  'ModelStore'
		ls_modeltype = '2'
		ls_modelname = "modelstoredefaulturl"
	Case 'ModelMapper'
		ls_modeltype = '3'
		ls_modelname = "modelmapperdefaulturl"
End Choose


IF Isnull(ls_url) or ls_url = "" Then
	Messagebox("Prompt", "The URL is required.")
	Return 1
End IF

SetProfileString(is_file, "Setup", "HostType", ls_hosttype)
SetProfileString(is_file, "Setup", "ModelType", ls_modeltype)
SetProfileString(is_file, "Setup", "URL", ls_url)
SetProfileString(is_file, "Setup", "Theme", ls_theme)
SetProfileString(is_file, ls_hostname, ls_modelname, ls_url)

IF Len(ls_msg) > 0 THEN
	li_ret = Messagebox("Prompt", "Saved the settings successfully." + ls_msg, Question!, YesNo!, 2)
	Close(parent)
	IF li_ret = 1 THEN
		Close(w_main)
	END IF
ELSE
	Messagebox("Prompt", "Saved the settings successfully." + ls_msg)
	
	If pos(lower(ls_url), "http://")> 0 or  pos(lower(ls_url), "https://") > 0 then
		gs_host = ls_url
	Else
		gs_host = "http://" + ls_url
	End If
	
	gi_service_type = Integer(ls_modeltype)
	
	IF Not Isvalid(w_main) Then Open(w_main)
	Close(parent)
END IF
end event

type dw_setup from u_dw within w_setup
boolean visible = false
integer x = 9
integer y = 952
integer width = 2304
integer height = 736
integer taborder = 10
string dataobject = "d_setup"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_defaulturl
String ls_hosttype
String ls_modeltype

Choose Case dwo.Name
	Case "hosttype"
		ls_modeltype = This.Getitemstring( 1, "modeltype")
		ls_hosttype = data
	Case "modeltype"
		ls_modeltype = data
		ls_hosttype = This.Getitemstring( 1, "hosttype")
End Choose

IF ls_hosttype = "1" Then
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
		Case "ModelMapper"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelmapperdefaulturl", "")
	End Choose
Else
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
		Case "ModelMapper"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelmapperdefaulturl", "")
	End Choose
End IF

//dw_setup.SetItem(1, "url", ls_defaulturl)
end event

