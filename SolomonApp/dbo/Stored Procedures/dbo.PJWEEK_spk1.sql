 create procedure PJWEEK_spk1 @parm1 smalldatetime   as
select * from PJWEEK
where   we_date  >= @parm1
	order by we_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_spk1] TO [MSDSL]
    AS [dbo];

