Create proc SumtotalQtyAllocationLot @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @parm5 varchar(10), @Parm6 varchar(10), @Parm7 varchar(10), @Parm8 varchar(15), @QtyremaintoIssue INT OUTPUT  as
select @Qtyremaintoissue = ISNULL(sum(InPrjAllocationLot.QtyAllocated),0) 
 from InprjAllocationLot with (nolock)
where
Invtid = @Parm1 AND
ProjectID = @Parm2  AND
TaskId Like @parm3 AND
siteid = @parm4 AND
LotSerNbr = @parm5 AND
CpnyID  = @parm6 AND
WhseLoc = @parm7 AND
SrcNbr <> @parm8 AND
Srctype In('SO', 'IS', 'SH', 'RN')

