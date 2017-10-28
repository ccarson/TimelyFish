 CREATE PROCEDURE smCalculate_Markup
	@InvtValMthd	VARCHAR(1),
	@DetailCost		MONEY,
	@InvtLastCost	MONEY,
    @MarkupID		VARCHAR(10),
	@InvtStdCost	MONEY,
	@Price 			MONEY OUTPUT
AS
DECLARE
	@MarkupFactor 			FLOAT,
	@Cost 					FLOAT,
	@Factor 				FLOAT,
	@MarkupBreakMult		FLOAT,
	@MarkupUpperPercent 	FLOAT

	SELECT @Factor = 0

    -- Calculate the mark-up based on the Mark-up ID
    -- return the price from this function
    -- get the cost
	IF RTRIM(@InvtValMthd) = 'T'  								-- standard cost
		BEGIN
            If @DetailCost = 0 SELECT @Cost = @InvtStdCost
            Else SELECT @Cost = @DetailCost
		END
	ELSE IF RTRIM(@InvtValMthd) IN ('L', 'F', 'S') 				-- Lifo cost and Fifo and Specific identification
		BEGIN
            If @DetailCost = 0 SELECT @Cost = @InvtLastCost
            Else SELECT @Cost = @DetailCost
		END
    ELSE IF RTRIM(@InvtValMthd)= 'U' 		 					-- user defined
		BEGIN
	        SELECT @Cost = @DetailCost
		END
	ELSE IF RTRIM(@InvtValMthd)= 'A' 			 				-- Average Cost
		BEGIN
            If @DetailCost = 0 SELECT @Cost = @InvtLastCost
            Else SELECT @Cost = @DetailCost
		END

    -- Retrieve the Mark-up header and detail
    SELECT 	@MarkupBreakMult  = MarkupBreakMult
	FROM 	smMarkBreaks (NOLOCK)
	WHERE 	MarkupBreakLimit >= @Cost
	AND 	MarkupBreakId = @MarkupID

	IF @@ROWCOUNT > 0
		BEGIN
	        SELECT @Factor = @MarkupBreakMult
		END
	ELSE
		BEGIN
	        -- retrieve header
			SELECT  @MarkupUpperPercent = MarkupUpperPercent
			FROM    smMark (NOLOCK)
			WHERE 	MarkupId = @MarkupID
			IF @@ROWCOUNT > 0
			BEGIN
				SELECT @Factor = @MarkupUpperPercent
			END
		END

    If @Factor > 0 	SELECT @Price = @Cost * @Factor
    Else 			SELECT @Price = @Cost



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCalculate_Markup] TO [MSDSL]
    AS [dbo];

