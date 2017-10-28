 CREATE Proc ED850Sched_StdCartonCheck @CpnyId varchar(10), @EDIPOID varchar(10) As
Select A.LineId, A.Qty, A.UOM From ED850Sched A Inner Join ED850LineItem B On A.CpnyId = B.CpnyId And
A.EDIPOID = B.EDIPOID And A.LineId = B.LineId Inner Join InventoryADG C On B.InvtId = C.InvtId
Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID And C.PackMethod = 'SC'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_StdCartonCheck] TO [MSDSL]
    AS [dbo];

