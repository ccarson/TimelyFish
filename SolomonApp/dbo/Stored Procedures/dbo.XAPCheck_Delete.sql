CREATE PROCEDURE XAPCheck_Delete @BatNbr char(10) AS
Delete from XAPCheck where BatNbr = @BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheck_Delete] TO [MSDSL]
    AS [dbo];

