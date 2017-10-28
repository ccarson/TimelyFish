 Create Proc _sm_InUnit_InvtId_From_To
			@InvtID			VARCHAR (30),
			@FromUnit		VARCHAR (6),
			@ToUnit			VARCHAR (6),
			@InUnitFactor	FLOAT 		OUTPUT,
			@InUnitMultDiv	VARCHAR(1)  OUTPUT,
			@InReverse		SMALLINT	OUTPUT
AS
DECLARE
	@RetVal SMALLINT

	SELECT @RetVal = 0

   	SELECT  @InUnitFactor = CnvFact,
			@InUnitMultDiv = MultDiv
	FROM 	INUnit (NOLOCK)
    WHERE 	UnitType = '3'
    AND 	InvtId 	 = @InvtID
    AND 	FromUnit = @FromUnit
    AND 	ToUnit 	 = @ToUnit

	-- return 1 if successfull 0 if not
	IF @@ROWCOUNT > 0 SELECT @RetVal = 1
	ELSE
		BEGIN
			-- Try to Reverse it
		   	SELECT  @InUnitFactor = CnvFact,
					@InUnitMultDiv = MultDiv
			FROM 	INUnit   (NOLOCK)
		    WHERE 	UnitType = '3'
		    AND 	InvtId 	 = @InvtID
		    AND 	FromUnit = @ToUnit
		    AND 	ToUnit 	 = @FromUnit

			IF @@ROWCOUNT > 0
			BEGIN
				SELECT @RetVal = 1
				SELECT @InReverse = 0
			END
		END

	RETURN @RetVal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[_sm_InUnit_InvtId_From_To] TO [MSDSL]
    AS [dbo];

