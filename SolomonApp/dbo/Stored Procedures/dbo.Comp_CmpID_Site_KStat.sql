 --bkb 7/22/99 4.2
--11500
Create Procedure Comp_CmpID_Site_KStat @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1) as
		Select * from Component where
			cmpnentid = @parm1 and
			siteid = @parm2 and
			kitstatus = @parm3
			Order by CmpnentID, SiteID


