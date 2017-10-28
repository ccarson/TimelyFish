
           CREATE PROCEDURE WS_PJTIMHDR_DELETE
            @docnbr char(10),
            @tstamp timestamp
            AS
			UPDATE [PJTIMHDR] SET [docnbr] = [docnbr] WHERE [docnbr] = @docnbr AND [tstamp] = @tstamp    
			IF @@ROWCOUNT >0
            BEGIN
            DELETE FROM [PJUOPDET] WHERE [docnbr] = @docnbr;
            DELETE FROM [PJTIMDET] WHERE [docnbr] = @docnbr;
            DELETE FROM [PJTIMHDR] WHERE [docnbr] = @docnbr;
            End
            

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJTIMHDR_DELETE] TO [MSDSL]
    AS [dbo];

