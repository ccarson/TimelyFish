 create procedure PJEXPTYP_SALL  @parm1 varchar (4)   as
select * from PJEXPTYP
where    exp_type Like @parm1
order by exp_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPTYP_SALL] TO [MSDSL]
    AS [dbo];

