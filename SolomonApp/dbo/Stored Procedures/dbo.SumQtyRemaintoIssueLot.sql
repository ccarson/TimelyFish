Create proc SumQtyRemaintoIssueLot @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @parm5 varchar (25), @parm6 varchar (10), @parm7 varchar (10), @QtyremaintoIssue INT OUTPUT  as
select @Qtyremaintoissue = ISNULL(sum(InvProjAllocLot.QtyremainToIssue),0) 
 from InvProjAllocLot with (nolock)
where
Invtid = @Parm1 AND
ProjectID = @Parm2  AND
TaskId Like @parm3 AND
siteid = @parm4 AND
LotSerNbr = @parm5 AND
CpnyId = @Parm6 AND
WhseLoc = @parm7
