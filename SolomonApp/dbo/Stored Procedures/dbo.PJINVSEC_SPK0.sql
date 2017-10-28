 create procedure PJINVSEC_SPK0 @parm1 varchar (4) , @parm2 varchar (4) ,  @parm3 varchar (16)   as
select * from PJINVSEC
where inv_format_cd = @parm1
and section_num like @parm2
and acct         like     @parm3
order by inv_format_cd,
section_num,
acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINVSEC_SPK0] TO [MSDSL]
    AS [dbo];

