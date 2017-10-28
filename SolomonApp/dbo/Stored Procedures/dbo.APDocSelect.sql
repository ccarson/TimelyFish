 /****** Object:  Stored Procedure dbo.APDocSelect    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDocSelect @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3beg smalldatetime, @parm3end smalldatetime As
Select * from APDoc Where
APDoc.OpenDoc = 1
and APDoc.Rlsed = 1
and APDoc.Selected = 0
and APDoc.CuryDocBal <> 0.00
and APDoc.Status = 'A'
and APDoc.VendId like @parm1
and (APDoc.DocType = 'VO' or APDoc.DocType = 'AC')
and APDoc.RefNbr like @parm2
and APDoc.PayDate Between @parm3beg and @parm3end


