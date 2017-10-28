 CREATE PROC SCM_WO_PJCONTRL_Control_Data
	@Control_Type	varchar (2),
	@Control_Code	varchar (30)
AS
	SELECT		Control_Data
	FROM		PJContrl
	WHERE		Control_Type = @Control_Type
			and Control_Code = @Control_Code
	ORDER BY	Control_Type, Control_Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_WO_PJCONTRL_Control_Data] TO [MSDSL]
    AS [dbo];

