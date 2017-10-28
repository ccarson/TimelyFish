 Create Procedure ARDoc_CustID_Rlsed6 @parm1 varchar ( 15), @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select d1.*, c.* from ARDoc d1 INNER JOIN Currncy c ON d1.CuryId = c.CuryId
	LEFT OUTER JOIN ARDoc d2 ON d1.CustID = d2.CustID AND d1.RefNbr = d2.RefNbr AND d2.DocType = 'RA' AND d2.Rlsed = 1
Where d1.CustId = @parm1 and
	d1.Rlsed = 1 and
	d1.DocType = 'AD' AND
	d2.CustID IS NULL AND
	d1.cpnyid in
(select Cpnyid
 from vs_share_usercpny
   where userid = @parm2
   and scrn = @parm3
   and seclevel >= @parm4)

Order by d1.CustId DESC, d1.DocDate DESC


