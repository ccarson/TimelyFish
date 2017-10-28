 --bkb 6/29/99 4.2
--11500
Create Procedure Comp_KitID_KSite_KStat @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1) as
	Select * from Component where
		Kitid = @parm1
      	and Kitsiteid = @parm2
		and KitStatus = @parm3
        	Order by Kitid, KitSiteid, KitStatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_KitID_KSite_KStat] TO [MSDSL]
    AS [dbo];

