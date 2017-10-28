 /****** Object:  Stored Procedure dbo.ARDoc_Sum_AgeBal2_CpnyId    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_Sum_AgeBal2_CpnyId @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 smalldatetime, @parm4 smalldatetime As
 Select SUM(DocBal) from ARDoc WHERE ARDoc.CustId = @parm1
 AND ARDoc.CpnyID = @parm2
 AND ARDoc.Rlsed = 1
 AND ARDoc.DueDate < @parm3
 AND ARDoc.DueDate >= @parm4
 AND ARDoc.DocType IN ('IN','DM','FI')
 AND ARDoc.DocBal > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Sum_AgeBal2_CpnyId] TO [MSDSL]
    AS [dbo];

