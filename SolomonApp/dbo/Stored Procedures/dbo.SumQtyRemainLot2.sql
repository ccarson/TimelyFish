CREATE proc SumQtyRemainLot2 @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10), @parm5 varchar (10) AS
select Qtyremaintoissue = ISNULL(sum(InvProjAllocLot.QtyremainToIssue),0) 
 from InvProjAllocLot with (nolock)
where
Invtid = @Parm1 AND
ProjectID = @Parm2  AND
TaskId = @parm3 AND
siteid = @parm4 AND
CpnyId = @Parm5 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SumQtyRemainLot2] TO [MSDSL]
    AS [dbo];

