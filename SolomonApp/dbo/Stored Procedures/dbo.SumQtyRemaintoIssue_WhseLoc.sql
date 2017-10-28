CREATE proc SumQtyRemaintoIssue_WhseLoc @InvtId varchar(30), @SiteId varchar (16), @ProjectId varchar (16), @TaskID varchar (32), @CpnyID varchar(10), @WhseLoc varchar(10), @QtyremaintoIssue INT OUTPUT  as
select @Qtyremaintoissue = ISNULL(sum(InvProjAlloc.QtyremainToIssue),0) 
 from InvProjAlloc with (nolock)
where
Invtid = @InvtID AND
ProjectID = @ProjectID  AND
TaskId Like @taskID AND
siteid = @SiteID  AND
cpnyid = @CpnyID AND
WhseLoc = @WhseLoc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyRemaintoIssue_WhseLoc] TO [MSDSL]
    AS [dbo];

