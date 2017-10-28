 CREATE Proc EDWrkPOToSO_AddSalesQty @AccessNbr smallint
As
	Update EDWrkPOToSO
	Set SOQty = (Select IsNull(Sum(B.QtyOrd),0)
			From SOLine B
				Inner Loop Join SOHeader C
					On 	B.CpnyId = C.CpnyId And
						B.OrdNbr = C.OrdNbr
			Where 	C.EDIPOID = A.EDIPOID And
				C.CpnyId = A.CpnyId And
				A.InvtId In (B.InvtId,B.AlternateId) And
				B.UnitDesc = A.POUOM And
				C.Cancelled = 0)
	From EDWrkPOToSO A
	Where AccessNbr = @AccessNbr


