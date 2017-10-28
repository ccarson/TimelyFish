CREATE PROCEDURE WS_PJEXPHDR_DELETE
    @docnbr char(10), @tstamp timestamp
AS
    UPDATE [PJExpHdr] SET [docnbr] = [docnbr] WHERE [docnbr] = @docnbr AND [tstamp] = @tstamp  

    IF @@ROWCOUNT > 0   
       BEGIN
            DELETE FROM [PJExpDet]
             WHERE [docnbr] = @docnbr;      
                                          
            DELETE FROM [PJExpHdr]
             WHERE [docnbr] = @docnbr
        END

