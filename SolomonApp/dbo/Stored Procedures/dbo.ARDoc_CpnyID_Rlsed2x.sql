 Create Procedure ARDoc_CpnyID_Rlsed2x @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar (6) As

   Select * from ARDoc, Currncy
   Where ARDoc.CuryId = Currncy.CuryId and
   ARDoc.CustId = @parm1 and
   ARDoc.CpnyID = @parm2 and
   (ARDoc.curyDocBal <> 0 or ARDoc.CurrentNbr = 1 or ARDoc.PerPost = @parm3) and
   ARDoc.Rlsed = 1
   Order by CustId, DocDate DESC

