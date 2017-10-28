
           CREATE PROCEDURE WS_PJTIMDET_DELETE
            @docnbr char(10),
            @linenbr smallint,
            @tstamp timestamp
            AS
            BEGIN
              DELETE FROM [PJTIMDET] 
                    WHERE [docnbr] = @docnbr AND [linenbr] = @linenbr;
            END
            

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJTIMDET_DELETE] TO [MSDSL]
    AS [dbo];

