 create procedure PJLABHDR_sempdt @parm1 varchar (10) ,@parm2 smalldatetime   as
select * from PJLABHDR
where    employee = @parm1 and
pe_date = @parm2
	order by employee



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_sempdt] TO [MSDSL]
    AS [dbo];

