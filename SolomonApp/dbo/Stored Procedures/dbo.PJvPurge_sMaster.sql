 create procedure PJvPurge_sMaster  @parm1 char (1)   as
select * from PJVPURGE
where    master = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvPurge_sMaster] TO [MSDSL]
    AS [dbo];

