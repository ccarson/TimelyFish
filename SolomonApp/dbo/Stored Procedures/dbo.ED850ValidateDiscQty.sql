 Create Proc ED850ValidateDiscQty @CpnyId varchar(10), @EDIPOID varchar(10) As
Select B.LineId From ED850LDisc A, ED850LineItem B Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID
And A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID And A.LineId = B.LineId And A.AllChgQuantity <> B.Qty  Group By B.LineId
Having Sum(A.AllChgQuantity) > Avg(B.Qty) Order By B.LineId


