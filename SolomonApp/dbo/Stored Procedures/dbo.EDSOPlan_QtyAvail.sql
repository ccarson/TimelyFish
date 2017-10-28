 CREATE Proc EDSOPlan_QtyAvail @InvtId varchar(30), @SiteId varchar(10), @CpnyId varchar(10), @OrdNbr varchar(15) As
Select Sum(Qty) From SOPlan Where InvtId = @InvtId And SiteId = @SiteId And DisplaySeq <
(Select Min(DisplaySeq) From SOPlan Where InvtId = @InvtId And SiteId = @SiteId And
CpnyId = @CpnyId And SOOrdNbr = @OrdNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOPlan_QtyAvail] TO [MSDSL]
    AS [dbo];

