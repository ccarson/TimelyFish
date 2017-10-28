CREATE PROCEDURE WS_PJDOCNUM_DELETE
    @Id char(10), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJDOCNUM]
      WHERE [Id] = @Id AND 
            [tstamp] = @tstamp;
    END
