 CREATE PROCEDURE ADG_AutoRelease_Order
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	-- Fields from SOHeader
	DECLARE @ApprDetails		smallint
	DECLARE @ApprRMA		smallint
	DECLARE @ApprTech		smallint
	DECLARE @SOTypeID		varchar(4)
	DECLARE @Released		smallint

	-- Fields from SOType
        DECLARE @Behavior		varchar(4)
	DECLARE @RequireDetailAppr	smallint
	DECLARE @RequireManRelease	smallint
	DECLARE	@RequireTechAppr	smallint

	-- Return value
	DECLARE @RetValue		char(4)
	DECLARE @Remarks		char(30)

	-- Get the status of the various flags on the order header.
	SELECT
		@ApprDetails	= ApprDetails,
		@ApprRMA	= ApprRMA,
		@ApprTech	= ApprTech,
		@Released	= Released,
		@SOTypeID	= SOTypeID
	FROM SOHeader
	WHERE CpnyID = @CpnyID AND
		OrdNbr = @OrdNbr

	-- Determine which fields are required by checking the SOType
	-- table.
	SELECT
		@Behavior		= Behavior,
		@RequireDetailAppr	= RequireDetailAppr,
		@RequireManRelease	= RequireManRelease,
		@RequireTechAppr	= RequireTechAppr
	FROM SOType
	WHERE CpnyID = @CpnyID AND
		SOTypeID = @SOTypeID

        -- Initialize the return values.
	SELECT @RetValue = 'NEXT', @Remarks = ''

	-- If SOType says a field is required and it's not checked
	-- in SOHeader then don't allow advancement.

	IF (UPPER(RTRIM(@Behavior)) IN ('REP', 'RFC')) AND @ApprRMA = 0
		SELECT @RetValue = 'HOLD'

	IF @RequireDetailAppr <> 0 AND @ApprDetails = 0
		SELECT @RetValue = 'HOLD'

	IF @RequireTechAppr <> 0 AND @ApprTech = 0
		SELECT @RetValue = 'HOLD'

	IF @RequireManRelease <> 0 AND @Released = 0
		SELECT @RetValue = 'HOLD'

	-- Return the answer.
	SELECT @RetValue, @Remarks

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_AutoRelease_Order] TO [MSDSL]
    AS [dbo];

