CREATE PROCEDURE XAPCheckDet_Delete @BatNbr char (10) AS
Delete from XAPCheckDet where BatNbr = @BatNbr
GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheckDet_Delete] TO [MSDSL]
    AS [dbo];

