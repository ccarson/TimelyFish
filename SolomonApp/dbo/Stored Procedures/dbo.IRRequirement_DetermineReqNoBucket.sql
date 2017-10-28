


CREATE Procedure IRRequirement_DetermineReqNoBucket @InvtId VarChar(30) AS
Set NoCount On
-- Call each of the different types of documents
Exec IRRequirement_HandlePurchOrd @InvtId
-- Exec IRRequirement_HandleSalesOrd @InvtId
Exec IRRequirement_HandlePlanPOrd @InvtId
-- Exec IRRequirement_HandleShippers @InvtId

Set NoCount Off





GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequirement_DetermineReqNoBucket] TO [MSDSL]
    AS [dbo];

