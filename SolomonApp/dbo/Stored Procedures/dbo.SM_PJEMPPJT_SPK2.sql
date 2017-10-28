 CREATE PROCEDURE SM_PJEMPPJT_SPK2
				@Parm1 varchar (10) ,
				@Parm2 varchar (16) ,
				@Parm3 smalldatetime
AS
DECLARE
	@CONST_NA as varchar(2),
	@RetVal   as smallint,
	@LaborClassID as varchar(4)

	SELECT @CONST_NA = 'na'
	SELECT @RetVal = 9			 -- not found return for SWIM purpose.
								 -- perhaps @@ROWCOUNT is used below SWIM does not know what to do upon return

	IF RTRIM(LTRIM(@Parm2)) = ''
	BEGIN
        Select @Parm2 = @CONST_NA
	END

	SELECT   @LaborClassID = labor_class_cd
	FROM 	PJEMPPJT (NOLOCK)
	WHERE 	 Employee = @parm1
	AND		 Project =   @parm2
	AND		 Effect_Date <=  @parm3
	ORDER BY Employee, Project,  Effect_Date desc

    IF @@ROWCOUNT > 0
    BEGIN
		SELECT @RetVal = 0		-- there is a record for this fetch

		-- do the real select statement
		SELECT 	 *
		FROM 	 PJEMPPJT
		WHERE 	 Employee = @parm1
		AND		 Project =   @parm2
		AND		 Effect_Date <=  @parm3
		ORDER BY Employee, Project,  Effect_Date desc
	END

	-- if @parm2 is a projectID and there isn't any row define for it fetch again with na value
	IF RTRIM(LTRIM(@Parm2)) <> @CONST_NA AND @RetVal = 9
	BEGIN
		Select @Parm2 = @CONST_NA

		SELECT * FROM PJEMPPJT
		WHERE 	 Employee = @parm1
		AND		 Project =   @parm2
		AND		 Effect_Date <=  @parm3
		ORDER BY Employee, Project,  Effect_Date desc

		IF @@ROWCOUNT > 0 	SELECT @RetVal = 0
	END

return @RetVal


