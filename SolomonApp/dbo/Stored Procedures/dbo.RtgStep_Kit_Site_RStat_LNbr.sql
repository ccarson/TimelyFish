 Create Proc RtgStep_Kit_Site_RStat_LNbr @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4beg smallint, @parm4end smallint as
            Select * from RtgStep, Operation where KitId = @parm1 and siteid = @parm2 and rtgstatus = @parm3
                           and LineNbr between @parm4beg and @parm4end and RtgStep.OperationID = Operation.OperationID
                        Order by KitId, SiteId, RtgStatus, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_Kit_Site_RStat_LNbr] TO [MSDSL]
    AS [dbo];

