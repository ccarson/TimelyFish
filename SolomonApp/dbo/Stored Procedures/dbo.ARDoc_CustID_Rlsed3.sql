 Create Procedure ARDoc_CustID_Rlsed3 @parm1 varchar (15), @parm2 varchar (6), @parm3 varchar(47),
                                     @parm4 varchar(7), @parm5 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT *
  FROM ARDoc, Currncy
 WHERE ARDoc.CuryId = Currncy.CuryId
   AND ARDoc.CustId = @parm1
   AND ARDoc.curyDocBal <> 0
   AND ARDoc.Rlsed = 1
   AND ARDoc.DocType <> 'AD'
   AND ARDoc.PerPost <= @parm2
   AND ARDoc.cpnyid IN (SELECT Cpnyid
                          FROM vs_share_usercpny
                         WHERE userid = @parm3
                           AND scrn = @parm4
                           AND seclevel >= @parm5)
 ORDER BY CustId DESC, DocDate DESC


