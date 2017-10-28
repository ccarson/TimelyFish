 Create Proc EDSOHeader_GetStepData @CpnyId varchar(10), @OrdNbr varchar(15) As
Select A.CpnyId, A.OrdNbr, A.SOTypeId, A.AdminHold, A.CreditHold, A.CreditChk, A.NextFunctionId,
A.NextFunctionClass, A.Status, B.Status From SOHeader A Inner Join Customer B On
A.CustId = B.CustId Inner Join SOStep C On A.CpnyId = C.CpnyId And A.SOTypeId = C.SOTypeId
And A.NextFunctionId = C.FunctionId And A.NextFunctionClass = C.FunctionClass
Where A.CpnyId = @CpnyId And A.OrdNbr = @OrdNbr And C.Auto = 1 And (C.AutoPgmId <> '' Or
RptProg = 1) And Not Exists (Select * From SOShipHeader D Where D.CpnyId = A.CpnyId And
D.OrdNbr = A.OrdNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_GetStepData] TO [MSDSL]
    AS [dbo];

