 CREATE Proc EDWrkPOToSo_AddInProcess @AccessNbr smallint
As
	-- First insert data for the PO's that are not for 'free form' customers
	Insert into EDWrkPOToSO
		Select 	@AccessNbr, A.CpnyId, A.EDIPOID, A.InvtId,
			Sum(A.Qty),A.UOM,0,NULL
		From ED850LineItem A
			Inner Join ED850Header B
				On 	A.CpnyId = B.CpnyId And
					A.EDIPOID = B.EDIPOID
			Inner Join CustomerEDI C
				On 	B.CustId = C.CustId
		Where 	B.UpdateStatus = 'IN' And
			C.S4Future03 <> 4 And
			Not Exists (Select * From EDWrkPOToSO
					Where 	CpnyId = A.CpnyId And
						EDIPOID = A.EDIPOID)
		Group By A.CpnyId, A.EDIPOID, A.InvtId, A.UOM

	-- Now get data for 'free form' PO's
	Insert into EDWrkPOToSO
		Select 	@AccessNbr, A.CpnyId, A.EDIPOID,Coalesce(B.InvtId, A.InvtId),
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
				On C.CustId = D.CustId
		Where 	C.UpdateStatus = 'IN' And
			D.S4Future03 = 4 And
			Not Exists (Select * From EDWrkPOToSO
					Where 	CpnyId = A.CpnyId And
						EDIPOID = A.EDIPOID)
		Group By A.CpnyId, A.EDIPOID, Coalesce(B.InvtId, A.InvtId), Coalesce(B.UOM, A.UOM)


