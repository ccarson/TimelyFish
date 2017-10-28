 --bkb 6/29/99 4.2
--11500
Create Procedure Comp_KitID_Site_Stat_Dates @parm1 varchar ( 30), @parm2 varchar ( 10),
@parm3beg smalldatetime, @parm3end smalldatetime, @parm4beg smalldatetime, @parm4end smalldatetime as
	Select * from Kit where
		Kitid like @parm1
		and siteid like @parm2
        	and ((Kit.status = 'P' and (startdate between @parm3beg and @parm3end))
			or (status = 'A' and (stopdate between @parm4beg and @parm4end))) 		Order by Kitid, Siteid, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_KitID_Site_Stat_Dates] TO [MSDSL]
    AS [dbo];

