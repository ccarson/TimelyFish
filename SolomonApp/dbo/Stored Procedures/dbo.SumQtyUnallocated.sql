Create proc SumQtyUnallocated @InvtID varchar(30), @ProjectID varchar (16), @TaskID varchar (32), @SiteID varchar (10),  @WhseLoc varchar (10), @CpnyID varchar (10), @SrcNbr varchar (15)  as
select ISNULL(sum(QuantityStock),0) 
 from inprojalloctran with (nolock)
where
Invtid = @InvtID AND
ProjectID = @ProjectID  AND
TaskId Like @TaskID AND
siteid = @SiteID  AND
WhseLoc = @WhseLoc AND
cpnyid = @CpnyID   


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyUnallocated] TO [MSDSL]
    AS [dbo];

