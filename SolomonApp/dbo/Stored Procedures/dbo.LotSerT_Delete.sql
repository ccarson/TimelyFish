
Create Proc LotSerT_Delete
	@CpnyID varchar( 10 ),
	@BatNbr varchar( 10 ),
	@RefNbr varchar( 15 ),
	@TranType varchar( 3 )
as

Delete From LotSerT
Where CpnyID = @CpnyID
	and BatNbr = @BatNbr
	and RefNbr = @RefNbr
	and TranType = @TranType 
