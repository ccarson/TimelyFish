 create procedure PJINVSEC_DPK0  @parm1 varchar (4) as
delete from PJINVSEC
where inv_format_cd = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINVSEC_DPK0] TO [MSDSL]
    AS [dbo];

