
Create PROC PJInvDet_Comment @SourceID int
AS
    SELECT comment
    FROM   PJInvDet (nolock)
    WHERE  source_trx_id = @SourceID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJInvDet_Comment] TO [MSDSL]
    AS [dbo];

