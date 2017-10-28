
CREATE proc Fetch_inprjallocationlot_Lots 
    @Rcptnbr	Varchar(15),
    @SrcType	Varchar(3),
    @LineRef    VarChar(5),
	@CpnyID     VarChar(10)
As
Select * from inprjallocationLot WITH(NOLOCK)
 where SrcNbr = @Rcptnbr AND
       SrcType = @SrcType AND
       SrcLineRef = @LineRef AND
       CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_inprjallocationlot_Lots] TO [MSDSL]
    AS [dbo];

