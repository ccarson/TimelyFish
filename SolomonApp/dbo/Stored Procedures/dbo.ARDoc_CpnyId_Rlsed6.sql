 Create Procedure ARDoc_CpnyId_Rlsed6 @parm1 varchar ( 15), @parm2 varchar ( 10) As
Select d1.*, c.* from ARDoc d1 INNER JOIN Currncy c ON d1.CuryId = c.CuryId
	LEFT OUTER JOIN ARDoc d2 ON d1.CustID = d2.CustID AND d1.RefNbr = d2.RefNbr AND d2.DocType = 'RA' AND d2.Rlsed = 1
Where d1.CustId = @parm1 and
	d1.Rlsed = 1 and
	d1.DocType = 'AD' AND
	d2.CustID IS NULL AND
	d1.cpnyid = @parm2
Order by d1.CustId, d1.DocDate DESC


