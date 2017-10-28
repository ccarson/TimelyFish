 create procedure PJNOTES_delpk @parm1 varchar (4) , @parm2 varchar (64)   as
delete from PJNOTES
where note_type_cd =  @parm1 and
key_value = @parm2


