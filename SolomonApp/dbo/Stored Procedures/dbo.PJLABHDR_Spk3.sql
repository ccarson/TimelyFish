 create procedure PJLABHDR_Spk3 @parm1 varchar (10) ,@parm2 varchar (10)   as
select * from PJLABHDR
where    employee = @parm1 and
DOCNBR LIKE @parm2
	order by docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_Spk3] TO [MSDSL]
    AS [dbo];

