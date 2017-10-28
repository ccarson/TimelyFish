 create procedure  PJLABDIS_dPK0  @parm1 varchar (10)   as
Delete from PJLABDIS
where docnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_dPK0] TO [MSDSL]
    AS [dbo];

