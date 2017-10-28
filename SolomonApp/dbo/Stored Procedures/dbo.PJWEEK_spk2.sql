 create procedure PJWEEK_spk2 @parm1 varchar (6) , @parm2 varchar (2)   as
select * from PJWEEK
where   period_num = @parm1
and        week_num  like @parm2
	order by period_num, week_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_spk2] TO [MSDSL]
    AS [dbo];

