
Create Proc updatePOQtyRcvdRQ
	@poNbr	VARCHAR(10),
	@lineRef VARCHAR(5),
	@qtyAdd float
as

	Update PurOrdDet
	Set QtyRcvd = QtyRcvd + @qtyAdd
	Where PONbr = @poNbr
		and LineRef = @lineRef
