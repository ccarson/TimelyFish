 CREATE Proc EDWrkPOToSO_OrdersToAdvance @AccessNbr smallint As
Select Distinct B.CpnyId, B.OrdNbr, B.SOTypeId, B.AdminHold, B.CreditHold, B.CreditChk, B.NextFunctionId,
B.NextFunctionClass, B.Status, E.Status From EDWrkPOToSO A Inner Join SOHeader B On
A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID Inner Join SOStep C On A.CpnyId = C.CpnyId And
B.SOTypeId = C.SOTypeId And B.NextFunctionId = C.FunctionId And B.NextFunctionClass = C.FunctionClass
Inner Join Customer E On B.CustId = E.CustId
Where A.AccessNbr = @AccessNbr And C.Auto = 1 And (AutoPgmId <> '' Or RptProg = 1) And Not Exists
(Select * From SOShipHeader D Where D.CpnyId = B.CpnyId And D.OrdNbr = B.OrdNbr)


