 create procedure PJLABHDR_Spk8 @parm1 varchar (10) ,@parm2 smalldatetime , @parm3 varchar (2)   as
select * from PJLABHDR
where    employee = @parm1 and
pe_date = @parm2  and
le_status = @parm3
	order by employee



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_Spk8] TO [MSDSL]
    AS [dbo];

