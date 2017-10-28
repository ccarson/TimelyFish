Create proc QtyRemaintoIssueQOH @InvtID varchar(30), @SiteId varchar (10), @WhseLoc varchar (10) , @ProjectID varchar (16), @TaskID varchar (32) AS

  SELECT QtyQOH = ISNULL(SUM(InvProjAlloc.QtyremainToIssue),0) 
    FROM InvProjAlloc with (nolock)
   WHERE Invtid = @InvtID 
     AND SiteID = @SiteId  
     AND WhseLoc like @WhseLoc
     AND ProjectID = @ProjectID
     AND TaskId = @TaskID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[QtyRemaintoIssueQOH] TO [MSDSL]
    AS [dbo];

