$PBExportHeader$n_base.sru
forward
global type n_base from nonvisualobject
end type
end forward

global type n_base from nonvisualobject
end type
global n_base n_base

on n_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

