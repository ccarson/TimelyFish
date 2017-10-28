 Create Proc RtgStep_LaborClass @parm1 varchar ( 10) as
	Select * from RtgStep where LaborClassID = @parm1
		Order by kitid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_LaborClass] TO [MSDSL]
    AS [dbo];

