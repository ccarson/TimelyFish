 create procedure PJWEEK_spk3 @parm1 smalldatetime   as
select * from PJWEEK
where   we_date  <= @parm1
	order by we_date desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_spk3] TO [MSDSL]
    AS [dbo];

