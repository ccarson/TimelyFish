 create procedure PJINVSEC_SPK1 @parm1 varchar (4)   as
select * from PJINVSEC
where inv_format_cd = @parm1
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINVSEC_SPK1] TO [MSDSL]
    AS [dbo];

