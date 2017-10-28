
CREATE proc QtyConsumedonNoneShippersQOH @InvtId varchar(30), @SiteId varchar (16), @WhseLoc varchar(10), 
                                         @ProjectId varchar (16), @TaskID varchar (32) AS

  SELECT OthQtyAllocQOH = ISNULL(sum(InPrjAllocation.QtyAllocated),0)
    FROM InPrjAllocation with (nolock)
   WHERE Invtid = @Invtid 
     AND SiteID = @SiteId  
     AND WhseLoc like @WhseLoc
     AND ProjectID = @ProjectID
     AND TaskId = @TaskID
     AND SrcType <> 'SH' 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[QtyConsumedonNoneShippersQOH] TO [MSDSL]
    AS [dbo];

