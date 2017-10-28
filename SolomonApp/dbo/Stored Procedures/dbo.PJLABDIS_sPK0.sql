 create procedure  PJLABDIS_sPK0  @parm1 varchar (10)   as
select * from PJLABDIS
where docnbr = @parm1
Order by
docnbr, hrs_type, linenbr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_sPK0] TO [MSDSL]
    AS [dbo];

