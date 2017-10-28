
CREATE proc Fetch_inprojallocationlotSO 
    @InvtID		Varchar(30),
    @ProjectID	Varchar(8),
    @TaskId     VarChar(32),
	@SiteID		Varchar(10),
	@LotSerNbr	Varchar(25),
    @WhseLoc	Varchar(10),
    @OrdNbr     Varchar(15),
	@CpnyID     VarChar(10),
    @LotSerRef   VarChar(5)
As
Select * from inprjallocationlot
 where Invtid = @InvtId AND
       ProjectID = @ProjectID AND
       TaskID = @TaskId AND
       SiteId = @SiteId AND
       LotSerNbr = @LotSerNbr AND
       WhseLoc = @Whseloc AND
       SrcNbr =  @OrdNbr   AND
       CpnyID = @CpnyID    AND
       LotSerRef = @LotSerRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_inprojallocationlotSO] TO [MSDSL]
    AS [dbo];

