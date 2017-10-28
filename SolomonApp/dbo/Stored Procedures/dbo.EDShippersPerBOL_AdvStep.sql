 CREATE Proc EDShippersPerBOL_AdvStep @BOLNbr varchar(20) As
Select A.CpnyId, A.ShipperId, A.SOTypeId, A.OrdNbr, A.SiteId, A.AdminHold, A.CreditHold,
  A.CreditChk, A.Status, A.CustId, A.NextFunctionId, A.NextFunctionClass From SOShipHeader A Inner Join EDShipTicket B
  On A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId Where B.BOLNbr = @BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShippersPerBOL_AdvStep] TO [MSDSL]
    AS [dbo];

