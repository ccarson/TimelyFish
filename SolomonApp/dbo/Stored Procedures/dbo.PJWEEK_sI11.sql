 create procedure PJWEEK_sI11 @parm1 varchar (6)   as
select  period_num, count(period_num), min(we_date), max(we_date)  from PJWEEK
where   period_num = @parm1
group by period_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_sI11] TO [MSDSL]
    AS [dbo];

