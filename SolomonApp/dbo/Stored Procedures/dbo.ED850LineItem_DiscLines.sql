 CREATE Proc ED850LineItem_DiscLines @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850LineItem A, ED850LDisc B Where A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID
And A.LineId = B.LineId And A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID
And B.Qty + B.AllChgQuantity > 0 And  (A.Qty <> B.AllChgQuantity Or A.Qty <> B.Qty) And
(B.LDiscRate > 0 Or B.Pct > 0)


