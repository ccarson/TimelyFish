CREATE proc SumQtyConsumedAmt @InvtID varchar(30), @ProjectID varchar (16), @TaskID varchar (32), @SiteID varchar (10),  @WhseLoc varchar (10), @CpnyID varchar (10), @RefNbr varchar(15)  as
select ISNULL(sum(Qtyallocated),0) 
 from inprjallocation with (nolock)
where
Invtid = @InvtID AND
ProjectID = @ProjectID  AND
TaskId Like @TaskID AND
siteid = @SiteID  AND
WhseLoc = @WhseLoc AND
cpnyid = @CpnyID   AND
SrcNbr <> @RefNbr  AND
Srctype IN ('IS', 'SH', 'SO', 'RN')
