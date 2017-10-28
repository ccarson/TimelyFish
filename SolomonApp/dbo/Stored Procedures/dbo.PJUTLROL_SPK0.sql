 create procedure PJUTLROL_SPK0 @parm1 varchar (10) , @parm2 varchar (6), @parm3 varchar (4)      as
select * from PJUTLROL
where employee =  @parm1 and
fiscalno = @parm2 and
utilization_type = @parm3
order by employee, fiscalno, utilization_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTLROL_SPK0] TO [MSDSL]
    AS [dbo];

