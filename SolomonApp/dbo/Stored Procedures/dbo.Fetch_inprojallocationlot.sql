
CREATE proc Fetch_inprojallocationlot 
    @InvtID		Varchar(30),
    @ProjectID	Varchar(8),
    @TaskId     VarChar(32),
	@SiteID		Varchar(10),
	@LotSerNbr	Varchar(25),
    @WhseLoc	Varchar(10),
	@CpnyID     VarChar(10)
As
Select * from inprjallocationlot
 where Invtid = @InvtId AND
       ProjectID = @ProjectID AND
       TaskID = @TaskId AND
       SiteId = @SiteId AND
       LotSerNbr = @LotSerNbr AND
       WhseLoc = @Whseloc AND
       CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_inprojallocationlot] TO [MSDSL]
    AS [dbo];

