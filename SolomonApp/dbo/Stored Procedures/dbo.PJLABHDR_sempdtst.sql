 create procedure PJLABHDR_sempdtst @parm1 varchar (10) ,@parm2 smalldatetime   as
select * from PJLABHDR
where    employee = @parm1 and
pe_date = @parm2
	order by employee, pe_date, le_status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_sempdtst] TO [MSDSL]
    AS [dbo];

