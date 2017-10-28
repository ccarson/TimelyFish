 CREATE PROCEDURE ADG_APSS_GetShipperStatus
	@CpnyID      VARCHAR(10),
	@ShipperID   VARCHAR(15)
AS

	DECLARE @Status			CHAR(1)
	DECLARE @ShipViaID		CHAR(15)
	DECLARE @Hold			SMALLINT
	DECLARE @Seq			CHAR(4) -- Sequence number in SOStep for this shipper.
	DECLARE @PrintPackingSlipSeq	CHAR(4)
	DECLARE @sotypeid		VARCHAR(4)
	DECLARE @nextfunction		VARCHAR(8)
	DECLARE @nextclass		VARCHAR(4)
		-- Get the status of the specified shipper.
	SELECT	@Status		= h.Status,
			@ShipViaID	= h.ShipViaID,
			@Hold		= h.AdminHold,
			@SOTypeID	= h.SOTypeID,
			@Seq        = t.Seq
	FROM	SOShipHeader h,
			SOStep t
	WHERE	h.CpnyID = @CpnyID
	AND		h.ShipperID = @ShipperID
	AND		h.CpnyID = t.CpnyID
	AND		h.SOTypeID = t.SOTypeID
	AND		h.NextFunctionID = t.FunctionID
	AND		h.NextFunctionClass = t.FunctionClass

	-- If the shipper was not found then return an error.
	IF @Status IS NULL BEGIN
	    SELECT StatusMessage = 'Invalid shipper ID.'
		RETURN
	END

	-- If the shipper is closed then return.
	IF @Status = 'C' BEGIN
    	SELECT StatusMessage = 'This shipper has been closed.'
		RETURN
	END

	-- Check to make sure that this shipper is ready for manifesting.
	-- Get the sequence number for 'Print Packing Slip'
	SELECT	@PrintPackingSlipSeq = Seq
	FROM 	SOStep
	WHERE	CpnyID = @CpnyID
	AND		SOTypeID = @SOTypeID
	AND		FunctionID = '4066000'
	AND		FunctionClass = ''

	-- Check to see if the current sequence number is after the packing slip printing.
	IF @PrintPackingSlipSeq IS NOT NULL
		IF @Seq <= @PrintPackingSlipSeq BEGIN
   			SELECT StatusMessage = 'A packing slip has not yet been printed for this shipper.'
			RETURN
		END

	-- If the shipper is on hold then return.
	IF @Hold = 1 BEGIN
   		SELECT StatusMessage = 'This shipper is on hold.'
		RETURN
	END

	-- It is possible that the shipper has been shipped but hasn't
	-- been marked as 'Closed' yet.
	IF EXISTS( 	SELECT *
				FROM   SHShipHeader
				WHERE  CpnyID    = @CpnyID
				AND    ShipperID = @ShipperID ) BEGIN
		SELECT StatusMessage = 'This shipper has been closed.'
		RETURN
	END

	-- One last check.  We assert that ship-via-id must not be blank.
	IF @ShipViaID = '' BEGIN
		SELECT StatusMessage = 'This shipper cannot be shipped because a carrier has not been specified.'
		RETURN
	END

	-- This shipper is good to go.
	SELECT StatusMessage = NULL

	-- Make sure there are no records in SHShipHeader for this shipper.
	DELETE SHShipHeader
	WHERE  ShipperID = @ShipperID
	AND    CpnyID    = @CpnyID

	-- Make sure there are no records in SHShipPack for this shipper.
	DELETE SHShipPack
	WHERE  ShipperID = @ShipperID
	AND    CpnyID    = @CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


