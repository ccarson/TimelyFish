 /****** Object:  Stored Procedure dbo.ARDoc_FC_OpenDrDocs_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_FC_OpenDrDocs_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2), @parm4 smalldatetime As
 Select * from ARDoc WHERE ARDoc.CustId = @parm1
 ANd ARDoc.CpnyId = @parm2
 AND (ARDoc.DocType IN ('IN', 'DM') OR ARDoc.DocType = @parm3)
 AND ARDoc.DueDate <= @parm4
 AND ARDoc.curyDocBal > 0
 And Rlsed = 1
 Order By CustId, DueDate


