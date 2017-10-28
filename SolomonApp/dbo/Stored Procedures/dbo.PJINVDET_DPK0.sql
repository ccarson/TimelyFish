 create procedure  PJINVDET_DPK0  @parm1 varchar (10)   as
Delete from PJINVDET
where draft_num = @parm1
and li_type   = 'S'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINVDET_DPK0] TO [MSDSL]
    AS [dbo];

