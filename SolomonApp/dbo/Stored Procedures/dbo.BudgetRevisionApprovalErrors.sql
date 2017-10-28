
Create proc BudgetRevisionApprovalErrors
@parm1 varchar(16), --Project ID
@parm2 varchar(4),  --Revision ID
@parm3 varchar(47)  --UserAddress
AS
 SELECT *
   FROM WrkBudgetRevPostBad
  WHERE Project = @parm1
    AND RevId = @parm2
    AND UserAddress = @parm3

