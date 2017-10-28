
            CREATE PROCEDURE WS_PJExpDet_DELETE
            @docnbr char(10),
            @linenbr smallint
            AS
            BEGIN
            DELETE FROM [PJExpDet]
            WHERE [docnbr] = @docnbr AND 
            [linenbr] = @linenbr ;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJExpDet_DELETE] TO [MSDSL]
    AS [dbo];

