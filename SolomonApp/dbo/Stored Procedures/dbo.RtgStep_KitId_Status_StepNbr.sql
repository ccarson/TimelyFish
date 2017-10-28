 Create Proc RtgStep_KitId_Status_StepNbr @parm1 varchar ( 30), @parm2 varchar ( 1), @parm3beg smallint, @parm3end smallint as
            Select * from RtgStep where KitId = @parm1 and status = @parm2
                           and StepNbr between @parm3beg and @parm3end
                        Order by KitId, StepNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_KitId_Status_StepNbr] TO [MSDSL]
    AS [dbo];

