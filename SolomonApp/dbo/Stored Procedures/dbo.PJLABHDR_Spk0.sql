 create procedure PJLABHDR_Spk0 @parm1 varchar (10)  as
select * from PJLABHDR
where    docnbr = @parm1
	order by docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_Spk0] TO [MSDSL]
    AS [dbo];

