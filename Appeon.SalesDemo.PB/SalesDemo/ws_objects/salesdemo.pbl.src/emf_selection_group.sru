$PBExportHeader$emf_selection_group.sru
forward
global type emf_selection_group from nonvisualobject
end type
end forward

global type emf_selection_group from nonvisualobject
end type
global emf_selection_group emf_selection_group

type variables
//picture ip_obj[] 
//statictext ist_obj[]
//powerobject inv_obj[]

emf_str_selection_group istr_selection[]


end variables

forward prototypes
public subroutine of_active (powerobject apo_obj)
public subroutine of_addobject (powerobject apo_obj)
public subroutine of_addobject (powerobject apo_obj, string as_name)
public function string of_getname (powerobject apo_obj)
public function powerobject of_getobject (string as_name)
public function integer of_disabled (powerobject apo_obj)
public function integer of_deactive (powerobject apo_obj)
public subroutine of_active (powerobject apo_obj, integer ai_groupid)
public subroutine of_addobject (powerobject apo_obj, string as_name, integer ai_groupid)
public function integer of_deactiveall ()
end prototypes

public subroutine of_active (powerobject apo_obj);long ll_count,ll_i
integer li_groupid
li_groupid = apo_obj.dynamic of_getgroupid()

of_active(apo_obj,li_groupid)



end subroutine

public subroutine of_addobject (powerobject apo_obj);long ll_count

ll_count = upperbound(istr_selection)
istr_selection[ll_count +1].po_obj = apo_obj	

end subroutine

public subroutine of_addobject (powerobject apo_obj, string as_name);of_addobject(apo_obj,as_name,0)

end subroutine

public function string of_getname (powerobject apo_obj);long ll_count,ll_i
string ls_name
ll_count = upperbound(istr_selection)
for ll_i =1 to ll_count
	if istr_selection[ll_i].po_obj = apo_obj then
		ls_name = istr_selection[ll_i].s_name
		exit
	end if
next

return ls_name
end function

public function powerobject of_getobject (string as_name);powerobject lpo_obj
long ll_i,ll_count
setnull(lpo_obj)
ll_count = upperbound(istr_selection)
for ll_i =1 to ll_count
	if istr_selection[ll_i].s_name = as_name then
		lpo_obj = istr_selection[ll_i].po_obj
		exit
	end if
next

return lpo_obj
end function

public function integer of_disabled (powerobject apo_obj);long ll_count,ll_i

ll_count = upperbound(istr_selection)
for  ll_i=1 to ll_count
	if istr_selection[ll_i].po_obj = apo_obj then 
		istr_selection[ll_i].po_obj.dynamic event ue_disabled()
		exit
	else
		continue
	end if
next 

return 1
end function

public function integer of_deactive (powerobject apo_obj);long ll_count,ll_i

ll_count = upperbound(istr_selection)
for  ll_i=1 to ll_count
	if istr_selection[ll_i].po_obj <> apo_obj then continue
	istr_selection[ll_i].po_obj.dynamic event ue_deactive()	
next 

return 1
end function

public subroutine of_active (powerobject apo_obj, integer ai_groupid);long ll_count,ll_i

ll_count = upperbound(istr_selection)
for  ll_i=1 to ll_count
	if istr_selection[ll_i].ii_groupid = ai_groupid then
		if istr_selection[ll_i].po_obj = apo_obj  then
			istr_selection[ll_i].po_obj.dynamic event ue_active()
		else
			istr_selection[ll_i].po_obj.dynamic event ue_deactive()		
		end if
	end if
next 
yield() 
end subroutine

public subroutine of_addobject (powerobject apo_obj, string as_name, integer ai_groupid);long ll_count

ll_count = upperbound(istr_selection)
istr_selection[ll_count +1].po_obj =  apo_obj
istr_selection[ll_count +1].s_name =  as_name
istr_selection[ll_count +1].ii_groupid =  ai_groupid

end subroutine

public function integer of_deactiveall ();long ll_count,ll_i

ll_count = upperbound(istr_selection)
for  ll_i=1 to ll_count
	istr_selection[ll_i].po_obj.dynamic event ue_deactive()	
next 

return 1
end function

on emf_selection_group.create
call super::create
TriggerEvent( this, "constructor" )
end on

on emf_selection_group.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

