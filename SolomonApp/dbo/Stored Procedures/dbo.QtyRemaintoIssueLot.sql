Create proc QtyRemaintoIssueLot @parm1 varchar(30), @parm2 varchar (16), @parm3 varchar (32), @parm4 varchar (10),  @parm5 varchar (10), @parm6 varchar (10)  as
select Qty = ISNULL(sum(InvProjAllocLot.QtyremainToIssue),0) 
 from InvProjAlloclot with (nolock)
where
Invtid = @Parm1 AND
ProjectID = @Parm2  AND
TaskId = @parm3 AND
siteid = @parm4  AND
cpnyid = @parm5 AND
WhseLoc = @parm6
