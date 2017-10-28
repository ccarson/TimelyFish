 CREATE PROC ARDoc_CustID_CpnyID_Range @CustID varchar (15), @CpnyID varchar (10), @PerPost varchar (6),
  @StartDate smalldatetime, @StartType varchar(2), @StartRef varchar(10),
  @StopDate smalldatetime, @StopType varchar(2), @StopRef varchar(10),
  @DetailOpt varchar(1) AS

  SELECT *
    FROM ARDoc, Currncy
   WHERE ARDoc.CuryId = Currncy.CuryId
     AND ARDoc.CustId = @CustID
     AND ARDoc.CpnyID = @CpnyID
     AND ARDoc.Rlsed = 1
          -- All Documents
     AND (@DetailOpt = 'A' OR
          -- Current Plus Open Documents
         (@DetailOpt = 'C' AND (ARDoc.CuryDocBal <> 0 OR ARDoc.CurrentNbr = 1 OR
                                ARDoc.PerPost = @PerPost)) OR
          -- Open Only Documents
         (@DetailOpt = 'O' AND ARDoc.CuryDocBal <> 0))

     AND (convert(smalldatetime, floor(convert(float, ARDoc.DocDate))) < @StartDate OR convert(smalldatetime, floor(convert(float, ARDoc.DocDate))) = @StartDate AND
         (ARDoc.RefNbr < @StartRef OR ARDoc.RefNbr = @StartRef AND ARDoc.DocType <= @StartType))
     AND (convert(smalldatetime, floor(convert(float, ARDoc.DocDate))) > @StopDate OR convert(smalldatetime, floor(convert(float, ARDoc.DocDate))) = @StopDate AND
         (ARDoc.RefNbr > @StopRef OR ARDoc.RefNbr = @StopRef AND ARDoc.DocType >= @StopType))
   ORDER BY DocDate DESC, RefNbr DESC, DocType DESC


