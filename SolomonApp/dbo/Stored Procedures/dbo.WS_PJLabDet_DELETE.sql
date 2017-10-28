
            CREATE PROCEDURE WS_PJLabDet_DELETE
            @docnbr char(10),
            @linenbr smallint,
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJLabDet]
            WHERE [docnbr] = @docnbr AND 
            [linenbr] = @linenbr;
            END
            

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJLabDet_DELETE] TO [MSDSL]
    AS [dbo];

