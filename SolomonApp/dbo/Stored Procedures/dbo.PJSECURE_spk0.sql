 create procedure PJSECURE_spk0 @parm1 varchar (4) , @parm2 varchar (64)  as
select * from PJSECURE
where PW_TYPE_CD = @parm1 and
	KEY_VALUE = @parm2
order by pw_type_cd, key_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSECURE_spk0] TO [MSDSL]
    AS [dbo];

