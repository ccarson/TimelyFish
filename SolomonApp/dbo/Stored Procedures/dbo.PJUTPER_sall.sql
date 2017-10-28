 create procedure PJUTPER_sall @parm1 varchar (6)  as
select * from PJUTPER
where   period like @parm1
	order by period



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTPER_sall] TO [MSDSL]
    AS [dbo];

