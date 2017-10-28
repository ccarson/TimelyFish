 CREATE Proc ED850SubLineItem_Price @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select 	Cast(Coalesce(C.Qty, A.Qty) As float), Cast(Coalesce(C.Price, A.Price) As float),
		Cast(Coalesce(C.UOM, A.UOM) As char(6)), Cast(Coalesce(C.InvtId, A.InvtId) As char(30)),
		A.LineId, B.StkUnit, B.ClassId, B.StkBasePrc
	From ED850LineItem A Left Outer Join ED850SubLineItem C
		On A.CpnyId = C.CpnyId And A.EDIPOID = C.EDIPOID And A.LineId = C.LineId
		Inner Join Inventory B On B.InvtId = Coalesce(C.InvtId, A.InvtId)
	Where 	A.CpnyId = @CpnyId And
		A.EDIPOID = @EDIPOID
	Order By A.LineId


