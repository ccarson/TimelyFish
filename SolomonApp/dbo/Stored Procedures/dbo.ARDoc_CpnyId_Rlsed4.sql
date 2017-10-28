 /****** Object:  Stored Procedure dbo.ARDoc_CpnyId_Rlsed4    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROCEDURE ARDoc_CpnyId_Rlsed4 @parm1 VARCHAR ( 15), @parm2 VARCHAR ( 10) , @parm3 VARCHAR ( 6) AS
SELECT *
  FROM ARDoc, Currncy
 WHERE ARDoc.CuryId = Currncy.CuryId AND
       ARDoc.CustId = @parm1 AND
       ARDoc.cpnyID = @parm2 AND
       ARDoc.DocType <> 'AD' AND
       ARDoc.curyDocBal <> 0 AND
       ARDoc.Rlsed = 1	AND
       PerPost > @parm3
 ORDER BY CustId, DocDate DESC


