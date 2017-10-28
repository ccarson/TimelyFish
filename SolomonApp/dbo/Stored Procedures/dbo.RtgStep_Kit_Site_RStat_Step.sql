 Create Proc RtgStep_Kit_Site_RStat_Step @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4beg smallint, @parm4end smallint as
            Select * from RtgStep where KitId = @parm1 and siteid = @parm2 and rtgstatus = @parm3
                           and StepNbr between @parm4beg and @parm4end
                        Order by KitId, SiteId, RtgStatus, StepNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_Kit_Site_RStat_Step] TO [MSDSL]
    AS [dbo];

