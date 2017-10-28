 /****** Object:  Stored Procedure dbo.ARDoc_Sum_UnapplCRA_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_Sum_UnapplCRA_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 6) As
 Select SUM(DocBal) from ARDoc WHERE ARDoc.CustId = @parm1
 AND ARDoc.DocType IN ('PA', 'CM', 'DA') AND ARDoc.DocBal > 0
 AND ARDoc.Rlsed = 1
 AND ARDoc.CpnyID = @parm2
 AND ARDoc.PerPost <= @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Sum_UnapplCRA_CpnyID] TO [MSDSL]
    AS [dbo];

