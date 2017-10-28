 Create Proc RtgStep_WorkCenter @parm1 varchar ( 10) as
	Select * from RtgStep where WorkCenterID = @parm1
	Order by kitid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_WorkCenter] TO [MSDSL]
    AS [dbo];

