 CREATE PROC ARDoc_CustID_CpnyID_GetRanges @CustID varchar (15), @CpnyID varchar (10), @PerPost varchar (6),
                                          @DetailOpt varchar(1), @Size smallint AS

 DECLARE @StartDate smalldatetime, @StartType char(2), @StartRef char(10)
 DECLARE @StopDate smalldatetime, @StopType char(2), @StopRef char(10), @i int
  SELECT @StartDate='06/06/2079', @StartType='zz', @StartRef='zzzzzzzzzz', @i=1

  CREATE TABLE #Ranges (StartDate smalldatetime, StartType char(2), StartRef char(10),
                        StopDate smalldatetime, StopType char(2), StopRef char(10), i int)

  DECLARE SelDocs CURSOR FOR
   SELECT convert(smalldatetime, floor(convert(float, ARDoc.DocDate))), ARDoc.DocType, ARDoc.RefNbr
     FROM ARDoc
    WHERE ARDoc.CustId = @CustID
      AND ARDoc.CpnyID = @CpnyID
      AND ARDoc.Rlsed = 1
           -- All Documents
      AND (@DetailOpt = 'A' OR
           -- Current Plus Open Documents
          (@DetailOpt = 'C' AND (ARDoc.CuryDocBal <> 0 OR ARDoc.CurrentNbr = 1 OR
                                 ARDoc.PerPost = @PerPost)) OR
           -- Open Only Documents
          (@DetailOpt = 'O' AND ARDoc.CuryDocBal <> 0))
    ORDER BY DocDate DESC, RefNbr DESC, DocType DESC

  OPEN SelDocs
   FETCH NEXT FROM SelDocs INTO @StopDate, @StopType, @StopRef

  WHILE @@FETCH_STATUS=0
     BEGIN
        -- Get the remainder to determine the number of documents to display. When the remainder is 1,
        --   then set the Start Date, StartType, and StartRef. When the remainder is zero, then
        --   insert the Startdate, StartType,StartRef, StopDate, StopType, StopRef.
        --   Example if @Size = 500, then Remainders of 1 will be 1, and 501. Remainder of 0 are 500 and 1000.
        IF @i%@Size=1 SELECT @StartDate=@StopDate, @StartType=@StopType, @StartRef=@StopRef
        IF @i%@Size=0 INSERT #Ranges VALUES(@StartDate,@StartType,@StartRef,@StopDate,@StopType,@StopRef,@i)
        SELECT @i=@i+1
        FETCH NEXT FROM SelDocs INTO @StopDate, @StopType, @StopRef
     END

   IF @i%@Size<>1 OR NOT EXISTS(SELECT * FROM #Ranges)
      INSERT #Ranges VALUES(@StartDate,@StartType,@StartRef,'','','',@i)

   CLOSE SelDocs

   DEALLOCATE SelDocs

   SELECT StartDate,StartType,StartRef,StopDate,StopType,StopRef
     FROM #Ranges
    ORDER BY i


