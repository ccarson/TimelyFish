 create procedure PJUTPER_spk1 @parm1 varchar (6)  as
select * from PJUTPER
where   period <= @parm1
order by period DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJUTPER_spk1] TO [MSDSL]
    AS [dbo];

