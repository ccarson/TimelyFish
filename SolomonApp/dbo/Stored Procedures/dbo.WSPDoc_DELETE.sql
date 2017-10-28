CREATE PROCEDURE WSPDoc_DELETE
            @DocumentType char(50),
            @Instance smallint,
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [WSPDoc]
            WHERE [DocumentType] = @DocumentType AND 
            [Instance] = @Instance AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPDoc_DELETE] TO [MSDSL]
    AS [dbo];

