 create procedure PJWEEK_sall @parm1beg smalldatetime , @parm1end smalldatetime   as
select * from PJWEEK
where   we_date BETWEEN @parm1beg and @parm1end
	order by we_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_sall] TO [MSDSL]
    AS [dbo];

