
CREATE PROCEDURE WS_PJPROJEDDReceiver_DELETE
     @CpnyID char(10), @DocType char(2), @LineNbr smallint,
     @Project char(16), @tstamp timestamp
AS
  BEGIN
    DELETE 
      FROM [PJPROJEDDReceiver]
     WHERE [CpnyID] = @CpnyID AND 
           [DocType] = @DocType AND 
           [LineNbr] = @LineNbr AND 
           [Project] = @Project AND 
           [tstamp] = @tstamp;
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJPROJEDDReceiver_DELETE] TO [MSDSL]
    AS [dbo];

