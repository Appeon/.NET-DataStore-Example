$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global u_dw u_dw

forward prototypes
public function integer of_retrieve ()
public function integer of_importjson_dddw (string as_column_name, string as_data_json)
public function integer of_importjson_dddw (string as_column_name, string as_data_json, boolean ab_add_empty_row)
end prototypes

public function integer of_retrieve ();
return 1
end function

public function integer of_importjson_dddw (string as_column_name, string as_data_json);Return of_importjson_dddw(as_column_name, as_data_json, false)
end function

public function integer of_importjson_dddw (string as_column_name, string as_data_json, boolean ab_add_empty_row);DatawindowChild ldwc
Int li_return

This.GetChild(as_column_name, ldwc)
ldwc.Reset()

string message1

li_return = ldwc.ImportJsonByKey(as_data_json, message1)

If ab_add_empty_row Then
	ldwc.InsertRow(1)
End If

Return li_return
end function

on u_dw.create
end on

on u_dw.destroy
end on

