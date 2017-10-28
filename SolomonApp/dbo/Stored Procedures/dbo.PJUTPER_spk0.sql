 create procedure PJUTPER_spk0 @parm1 varchar (6)  as
select * from PJUTPER
where   period = @parm1
	order by period



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTPER_spk0] TO [MSDSL]
    AS [dbo];

