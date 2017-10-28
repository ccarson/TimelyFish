 Create Procedure ARDoc_CustID_Rlsed2 @parm1 varchar ( 15), @parm2 varchar(47), @parm3 varchar(7),
                                     @parm4 varchar(1), @parm5 varchar (6)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT * FROM ARDoc, Currncy
WHERE ARDoc.CuryId = Currncy.CuryId AND
      ARDoc.CustId = @parm1 AND
      (ARDoc.curyDocBal <> 0 OR ARDoc.CurrentNbr = 1 OR ARDoc.PerPost = @parm5) AND
      ARDoc.Rlsed = 1 AND
      ARDoc.Cpnyid IN

            (SELECT Cpnyid
               FROM vs_share_usercpny
              WHERE userid = @parm2
                AND scrn = @parm3
                AND seclevel >= @parm4)

ORDER BY CustId DESC, DocDate DESC


