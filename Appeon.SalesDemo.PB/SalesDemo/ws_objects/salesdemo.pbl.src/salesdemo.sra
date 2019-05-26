$PBExportHeader$salesdemo.sra
$PBExportComments$Generated Application Object
forward
global type salesdemo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_host = "http://localhost:16561"
Int gi_service_type = 1  //DataStore: 1, ModelStore: 2, ModelMapper: 3

//Service Type
Constant Int WEBAPI_DATASTORE = 1
Constant Int WEBAPI_MODELSTORE = 2
Constant Int WEBAPI_MODELMAPPER = 3
end variables

global type salesdemo from application
string appname = "salesdemo"
string displayname = "SalesDemo"
string themestylename = "Do Not Use Themes"
string textcontroltype = "2"
string textcontrolversion = "1"
string textcontrolkey = ""
end type
global salesdemo salesdemo

forward prototypes
public function integer of_getserviceurl ()
end prototypes

public function integer of_getserviceurl ();String ls_file, ls_url

ls_file = "apisetup.ini"

IF Not FileExists(ls_file) Then
	MessageBox("Error", "Apisetup.ini does not exist.")
Else
	ls_url = Trim(ProfileString(ls_file, "Setup", "URL", ""))
	If pos(lower(ls_url), "http://")> 0 or  pos(lower(ls_url), "https://") > 0 then
		gs_host = ls_url
	Else
		gs_host = "http://" + ls_url
	End If
	gi_service_type = ProfileInt(ls_file, "Setup", "ModelType", 3)
End IF

IF Isnull(gs_host) OR gs_host = '' Then Return -1
Return 1
end function

on salesdemo.create
appname="salesdemo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on salesdemo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String  ls_theme
ls_theme = ProfileString("apisetup.ini", "Setup", "Theme", "Flat Design Blue")
IF ls_theme <> "Do Not Use Themes" THEN
	applyskintheme(ls_theme)
END IF

IF of_getserviceurl() = 1 Then
	open(w_main)
Else
	open(w_setup)
End IF
end event

