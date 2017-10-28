CREATE PROCEDURE WS_RQPurpose_DELETE 
            @PurposeNbr char(10), @PurposeType char(1), @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQPurpose]
            WHERE [PurposeNbr] = @PurposeNbr AND 
            [PurposeType] = @PurposeType AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQPurpose_DELETE] TO [MSDSL]
    AS [dbo];

