$PBExportHeader$emf_u_picture.sru
forward
global type emf_u_picture from picture
end type
end forward

global type emf_u_picture from picture
integer width = 302
integer height = 252
boolean focusrectangle = false
event ue_active ( )
event ue_deactive ( )
event ue_disabled ( )
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttondown pbm_lbuttondown
end type
global emf_u_picture emf_u_picture

type variables
string is_path ='Image'
string is_SelectedPicture,is_defaultPicture,is_disabledPicture,is_buttonDownPicture
string is_currentPicture

string is_status
integer ii_groupid
end variables
forward prototypes
public function integer of_regdefaultpicture (string as_picturename)
public function integer of_regselectedpicture (string as_picturename)
public function string of_getcurrentstatus ()
public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture, string as_disabledpicture)
public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture, string as_disabledpicture, string as_buttondownpicture)
public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture)
public function integer of_regbuttondownpicture (string as_picturename)
public function integer of_getgroupid ()
end prototypes

event ue_active();this.enabled = true
is_status ='A'
this.PictureName = is_SelectedPicture
is_currentPicture = is_SelectedPicture
yield()
end event

event ue_deactive();this.enabled = true
is_status ='F'
this.PictureName = is_defaultPicture
is_currentPicture = is_defaultPicture
yield()
end event

event ue_disabled();this.enabled = false
this.PictureName = is_disabledPicture
is_currentPicture = is_disabledPicture
is_status ='D'
end event

event ue_lbuttonup;if parent.dynamic of_getrunstatus() = true then return
if of_getCurrentStatus() = 'F' then
	this.picturename = is_defaultPicture 
elseif of_getCurrentStatus() = 'A' then
	this.picturename = is_SelectedPicture 
else
	this.picturename = is_defaultPicture 
end if

parent.dynamic event ue_clicked(this)

end event

event ue_lbuttondown;if of_getCurrentStatus() = 'D' then return 
if parent.dynamic of_getrunstatus() = true then return
if is_buttonDownPicture <>'' then
	this.picturename = is_buttonDownPicture
end if
end event

public function integer of_regdefaultpicture (string as_picturename);is_defaultPicture =  is_path+"\"+as_picturename
this.PictureName = is_defaultPicture
is_status = 'F'
return 1
end function

public function integer of_regselectedpicture (string as_picturename);
is_SelectedPicture = is_path+"\"+as_picturename

return 1



end function

public function string of_getcurrentstatus ();return is_status
end function

public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture, string as_disabledpicture);of_regpicture(as_defaultpicture,as_selectedpicture,as_disabledpicture,'')

return 1
end function

public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture, string as_disabledpicture, string as_buttondownpicture);//as_picturename1: default picture
//as_picturename2: selected picture

is_defaultPicture =  is_path+"\"+as_defaultPicture
is_SelectedPicture = is_path+"\"+as_SelectedPicture
is_disabledPicture  = is_path+"\"+as_disabledPicture
if as_buttonDownPicture <>'' then
	is_buttonDownPicture  = is_path +"\"+ as_buttonDownPicture
end if

this.PictureName = is_defaultPicture

return 1
end function

public function integer of_regpicture (string as_defaultpicture, string as_selectedpicture);//as_defaultpicture: default picture
//as_selectedpicture: selected picture

of_regpicture(as_defaultpicture,as_selectedpicture,as_defaultpicture)

return 1
end function

public function integer of_regbuttondownpicture (string as_picturename);
is_buttonDownPicture = is_path+"\"+as_picturename

return 1



end function

public function integer of_getgroupid ();return ii_groupid
end function

on emf_u_picture.create
end on

on emf_u_picture.destroy
end on

