 Create Proc Kit_Kitid_SiteId_Status1 @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1) as
            Select * from Kit where
		KitId = @parm1 and
		siteid = @parm2 and
		status like @parm3
                order by KitId, siteid, status


