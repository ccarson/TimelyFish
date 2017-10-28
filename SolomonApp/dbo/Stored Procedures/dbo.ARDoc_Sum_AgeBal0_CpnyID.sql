 /****** Object:  Stored Procedure dbo.ARDoc_Sum_AgeBal0_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_Sum_AgeBal0_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 smalldatetime As
 Select SUM(DocBal) from ARDoc WHERE ARDoc.CustId = @parm1
 AND ARDoc.CpnyID = @parm2
 AND ARDoc.Rlsed = 1
 AND ARDoc.DueDate >= @parm3
 AND ARDoc.DocType IN ('IN','DM','FI')
 AND ARDoc.DocBal > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Sum_AgeBal0_CpnyID] TO [MSDSL]
    AS [dbo];

