 /****** Object:  Stored Procedure dbo.ARDoc_CpnyId_Rlsed3    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CpnyId_Rlsed3 @parm1 varchar (15), @parm2 varchar (6), @parm3 varchar ( 10) As

SELECT *
  FROM ARDoc, Currncy
 WHERE ARDoc.CuryId = Currncy.CuryId
   AND ARDoc.CustId = @parm1
   AND ARDoc.DocType <> 'AD'
   AND ARdoc.PerPost <= @parm2
   AND ARDoc.cpnyID = @parm3
   AND ARDoc.curyDocBal <> 0
   AND ARDoc.Rlsed = 1
ORDER BY CustId, DocDate DESC


