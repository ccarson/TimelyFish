 CREATE Proc EDWrkPOToSo_Add @AccessNbr smallint, @CpnyId varchar(10), @EDIPOID varchar(10)
As
	-- first get data for non 'free form' customers
	Insert into EDWrkPOToSO
		Select 	@AccessNbr, A.CpnyId, A.EDIPOID,A.InvtId,
			Sum(A.Qty), A.UOM,0,NULL
		From ED850LineItem A
			Inner Join ED850Header B
			On 	A.CpnyId = B.CpnyId And
				A.EDIPOID = B.EDIPOID
			Inner Join CustomerEDI C
			On 	B.CustId = C.CustId
		Where 	A.CpnyId = @CpnyId And
			A.EDIPOID = @EDIPOID And
			C.S4Future03 <> 4
		Group By A.CpnyId, A.EDIPOID, A.InvtId, A.UOM

	-- now get the 'free form' PO data
	Insert into EDWrkPOToSO
		Select 	@AccessNbr, A.CpnyId, A.EDIPOID,Coalesce(B.InvtId,A.InvtId),
			Sum(Coalesce(NullIf(IsNull(B.Qty,0) * A.Qty,0),A.Qty)),Coalesce(B.UOM,A.UOM),0,NULL
		From ED850LineItem A
			Left Outer Join ED850SubLineItem B
			On 	A.CpnyId = B.CpnyId And
				A.EDIPOID = B.EDIPOID And
				A.LineId = B.LineId
			Inner Join ED850Header C
			On 	A.CpnyId = C.CpnyId And
				A.EDIPOID = C.EDIPOID
			Inner Join CustomerEDI D
			On 	C.CustId = D.CustId
		Where 	A.CpnyId = @CpnyId And
			A.EDIPOID = @EDIPOID
			And D.S4Future03 = 4
		Group By A.CpnyId, A.EDIPOID, Coalesce(B.InvtId, A.InvtId), Coalesce(B.UOM, A.UOM)


