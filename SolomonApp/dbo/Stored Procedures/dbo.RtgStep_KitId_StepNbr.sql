 Create Proc RtgStep_KitId_StepNbr @parm1 varchar ( 30), @parm2beg varchar (5), @parm2end varchar (5) as
            Select * from RtgStep where KitId = @parm1
                           and StepNbr between @parm2beg and @parm2end
                        Order by KitId, StepNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_KitId_StepNbr] TO [MSDSL]
    AS [dbo];

