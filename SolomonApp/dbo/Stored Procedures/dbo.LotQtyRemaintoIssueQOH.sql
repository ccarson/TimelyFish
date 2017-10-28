Create proc LotQtyRemaintoIssueQOH @InvtID varchar(30), @SiteId varchar (10), @WhseLoc varchar (10) , 
                                   @ProjectID varchar (16), @TaskID varchar (32), @LotSerNbr varchar (25) AS

  SELECT QtyQOH = ISNULL(SUM(InvProjAllocLot.QtyremainToIssue),0) 
    FROM InvProjAllocLot with (nolock)
   WHERE Invtid = @InvtID 
     AND SiteID = @SiteId  
     AND WhseLoc like @WhseLoc
     AND ProjectID = @ProjectID
     AND TaskId = @TaskID
     AND LotSerNbr like @LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotQtyRemaintoIssueQOH] TO [MSDSL]
    AS [dbo];

