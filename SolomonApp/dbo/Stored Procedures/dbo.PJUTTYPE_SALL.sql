 create procedure PJUTTYPE_SALL  @parm1 varchar (4)   as
select * from PJUTTYPE
where    utilization_type Like @parm1
order by utilization_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTTYPE_SALL] TO [MSDSL]
    AS [dbo];

