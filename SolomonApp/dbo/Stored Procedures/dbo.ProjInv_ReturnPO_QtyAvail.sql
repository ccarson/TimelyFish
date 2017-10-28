 create proc ProjInv_ReturnPO_QtyAvail
    @InvtID varchar(30),
    @SiteID varchar(10),
    @WhseLoc VarChar(10),
    @LotSerNbr VarChar(25),
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as
SELECT ProjInvAvail FROM VP_PI_LotQtyByWhs
  WHERE InvtID = @InvtID
    AND SiteID = @SiteID
    AND WhseLoc = @WhseLoc
    AND LotSerNbr = @LotSerNbr
    AND ProjectID = @ProjectID
    AND TaskID = @TaskID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_ReturnPO_QtyAvail] TO [MSDSL]
    AS [dbo];

