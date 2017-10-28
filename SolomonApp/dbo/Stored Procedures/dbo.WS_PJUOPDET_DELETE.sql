
            CREATE PROCEDURE WS_PJUOPDET_DELETE
            @docnbr char(10),
            @linenbr smallint
            AS
            BEGIN
            DELETE FROM [PJUOPDET]
            WHERE [docnbr] = @docnbr AND 
            [linenbr] = @linenbr ;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUOPDET_DELETE] TO [MSDSL]
    AS [dbo];

