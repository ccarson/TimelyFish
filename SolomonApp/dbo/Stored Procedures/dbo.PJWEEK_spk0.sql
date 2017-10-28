 create procedure PJWEEK_spk0 @parm1 smalldatetime   as
select * from PJWEEK
where   we_date  = @parm1
	order by we_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_spk0] TO [MSDSL]
    AS [dbo];

