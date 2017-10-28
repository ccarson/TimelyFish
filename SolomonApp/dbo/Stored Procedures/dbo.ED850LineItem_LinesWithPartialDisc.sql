 CREATE Proc ED850LineItem_LinesWithPartialDisc @CpnyId varchar(10), @EDIPOID varchar(10) As
Select A.LineId,A.Qty,B.AllChgQuantity,B.Qty From ED850LineItem A Inner Join ED850LDisc B On A.CpnyId = B.CpnyId
And A.EDIPOID = B.EDIPOID And A.LineId = B.LineId Where A.CpnyId = @CpnyId And
A.EDIPOID = @EDIPOID And B.Qty + B.AllChgQuantity > 0 And
((A.Qty <> B.AllChgQuantity And B.AllChgQuantity <> 0) Or (A.Qty <> B.Qty And B.Qty <> 0)) And (B.LDiscRate > 0 Or B.Pct > 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_LinesWithPartialDisc] TO [MSDSL]
    AS [dbo];

