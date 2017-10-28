
           CREATE PROCEDURE WS_PJLabHdr_DELETE
            @docnbr char(10),
            @tstamp timestamp
            AS
			UPDATE [PJLabHdr] SET [docnbr] = [docnbr] WHERE [docnbr] = @docnbr AND [tstamp] = @tstamp    
			IF @@ROWCOUNT >0
            BEGIN
            DELETE FROM [PJLABDET] WHERE [docnbr] = @docnbr;
            DELETE FROM [PJLabHdr] WHERE [docnbr] = @docnbr;
            End
            

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJLabHdr_DELETE] TO [MSDSL]
    AS [dbo];

