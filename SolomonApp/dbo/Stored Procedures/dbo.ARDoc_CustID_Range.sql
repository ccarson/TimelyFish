 CREATE PROC ARDoc_CustID_Range @CustID varchar (15), @UserID varchar (47), @PerPost varchar (6),
  @StartDate smalldatetime, @StartType varchar(2), @StartRef varchar(10),
  @StopDate smalldatetime, @StopType varchar(2), @StopRef varchar(10),
  @DetailOpt varchar(1)   
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
  As
  SELECT *
    FROM ARDoc, Currncy
   WHERE ARDoc.CuryId = Currncy.CuryId
     AND ARDoc.CustId = @CustID
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
     AND EXISTS(SELECT *
                  FROM vs_Share_UserCpny
                 WHERE UserID = @UserID AND CpnyID = ARDoc.CpnyID
                   AND Scrn = '08260' and SecLevel >=1)
   ORDER BY DocDate DESC, RefNbr DESC, DocType DESC


