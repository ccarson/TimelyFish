 CREATE Proc ED850SDQ_Schedule @CpnyId varchar(10), @EDIPOID varchar(10) As
Select B.Date1, B.Date2, B.LineId, B.Qty, A.LineId, A.Qty, A.SolShipToId, D.DistCenterShipToId,
A.DiscTaken, A.UOM, B.UOM From ED850SDQ A Full Outer Join ED850Sched B On A.CpnyId = B.CpnyId
And A.EDIPOID = B.EDIPOID And A.LineId = B.LineId And A.StoreNbr = B.EntityId Join ED850Header C
On A.CpnyId = C.CpnyId And A.EDIPOID = C.EDIPOID Join EDSTCustomer D On
A.SolShipToId = D.ShipToId And C.CustId = D.CustId
Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID Order By A.SolShipToId, A.LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850SDQ_Schedule] TO [MSDSL]
    AS [dbo];

