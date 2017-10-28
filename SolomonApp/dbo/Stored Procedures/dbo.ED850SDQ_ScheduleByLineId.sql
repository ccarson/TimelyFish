 CREATE Proc ED850SDQ_ScheduleByLineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select B.Date1, B.Date2, B.LineId, B.Qty, A.LineId, A.Qty, A.SolShipToId, D.DistCenterShipToId
From ED850SDQ A Full Outer Join ED850Sched B On A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID
And A.LineId = B.LineId And A.StoreNbr = B.EntityId Join ED850Header C On C.CpnyId In
(A.CpnyId,B.CpnyId) And C.EDIPOID In (A.EDIPOID,B.EDIPOID) Join EDSTCustomer D On
D.CustId = C.CustId And D.ShipToId = IsNull(A.SolShipToId,C.SolShipToNbr)
Where (A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID And A.LineId = @LineId) Or
(B.CpnyId = @CpnyId And B.EDIPOID = @EDIPOID And B.LineId = @LineId)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850SDQ_ScheduleByLineId] TO [MSDSL]
    AS [dbo];

