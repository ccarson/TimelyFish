 create procedure PJFISCAL_sdate1 @parm1 smalldatetime  as
select * from PJFISCAL
where   end_date >= @parm1
order by end_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJFISCAL_sdate1] TO [MSDSL]
    AS [dbo];

