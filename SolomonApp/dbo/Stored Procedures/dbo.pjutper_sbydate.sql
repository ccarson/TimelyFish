 create procedure pjutper_sbydate @parm1 smalldatetime  as
select * from PJUTPER
where   start_date <= @parm1
and end_date >= @parm1
order by period



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjutper_sbydate] TO [MSDSL]
    AS [dbo];

