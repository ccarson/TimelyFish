
CREATE proc Fetch_inprjallocationLot 
    @RefNbr		Varchar(30),
    @SrcType	Varchar(8),
    @LineRef    VarChar(32),
    @LotSerNbr  Varchar(25),
	@CpnyID     VarChar(10)
As
Select * from inprjallocationLot
 where SrcNbr = @RefNbr AND
       SrcType = @SrcType AND
       SrcLineRef = @LineRef AND
       LotSerNbr = @LotSerNbr AND
       CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_inprjallocationLot] TO [MSDSL]
    AS [dbo];

