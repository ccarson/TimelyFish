 create procedure PJNOTES_sPK0 @parm1 varchar (4) , @parm2 varchar (64) , @parm3 varchar (2)  as
SELECT * from PJNOTES
WHERE 	note_type_cd =  @parm1 and
	key_value like @parm2 and
	key_index LIKE  @parm3
ORDER BY
	note_type_cd,
	key_value,
	key_index


