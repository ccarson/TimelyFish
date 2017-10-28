 Create Proc ED850ValidateSchedQty @CpnyId varchar(10), @EDIPOID varchar(10) As
Select B.LineId From ED850Sched A, ED850LineItem B Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID
And A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID And A.LineId = B.LineId Group By B.LineId
Having Sum(A.Qty) <> Avg(B.Qty) Order By B.LineId


