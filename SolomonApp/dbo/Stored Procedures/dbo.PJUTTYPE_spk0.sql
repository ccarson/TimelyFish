 create procedure PJUTTYPE_spk0  @parm1 varchar (4)   as
select * from PJUTTYPE
where    utilization_type = @parm1
order by utilization_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTTYPE_spk0] TO [MSDSL]
    AS [dbo];

