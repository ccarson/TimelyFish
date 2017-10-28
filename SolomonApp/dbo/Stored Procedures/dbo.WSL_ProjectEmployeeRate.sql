CREATE PROCEDURE WSL_ProjectEmployeeRate
	 @UserId varchar (15)  -- SL User ID
	,@parm1  varchar (10)  -- Employee
	,@parm2  varchar (16)  -- Project
	,@parm3  smalldatetime -- Effective Date
AS
  SET NOCOUNT ON
	DECLARE @ScrnNbr	nvarchar(5)
	DECLARE @Access		smallint
	DECLARE @RetVal		nvarchar(15)
	DECLARE @LaborRate  float

	SET @ScrnNbr = 'TMEPJ'

	EXEC AccessRights_Screen_UserId_2 @ScrnNbr, @UserId, @Access OUTPUT
  
	IF  @Access <> '0'  
		BEGIN 
			DECLARE @STMT nvarchar(max)
			DECLARE @PARMS nvarchar(max) 

			IF LEN(RTRIM(@Parm2)) = 0
				SET @parm2 = 'na'

            SELECT @PARMS = N'@parm1 varchar(10), @parm2 varchar(16), @parm3 smalldatetime, @Rate float OUTPUT'

			SET @STMT = '
				SELECT TOP 1 @Rate = labor_rate
					FROM PJEMPPJT (nolock)
				WHERE employee = ' + quotename(@parm1,'''') + '
					AND  project = ' + quotename(@parm2,'''') + '
					AND  effect_date <= ' + quotename(@parm3,'''') + '
				ORDER BY employee, project, effect_date desc'
			
			EXEC sp_executesql @STMT, @PARMS, @parm1 = @parm1, @parm2 = @parm2, @parm3 = @parm3, @Rate = @LaborRate OUTPUT
	  
			IF @@ERROR <> 0 or @@ROWCOUNT = 0 
				SET @RetVal = 'Rate Not Found'
			ELSE
				SET @RetVal = @LaborRate
  
  		END
	ELSE
		BEGIN
			-- No Access
			SET @RetVal = 'Access Denied' 
		END
		
	SELECT @RetVal AS [Labor Rate]
			
