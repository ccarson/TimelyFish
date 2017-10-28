 Create Proc WorkCenter_WorkCenterId_Site @parm1 varchar ( 10), @parm2 varchar ( 10) as
            Select * from WorkCenter where WorkCenterId = @parm1 And SiteId = @parm2
                order by WorkCenterId, Siteid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkCenter_WorkCenterId_Site] TO [MSDSL]
    AS [dbo];

