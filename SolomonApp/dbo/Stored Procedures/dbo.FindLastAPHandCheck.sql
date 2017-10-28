 /****** Object:  Stored Procedure dbo.FindLastAPHandCheck    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure FindLastAPHandCheck @parm1 varchar ( 10), @parm2 varchar ( 24) As
Select CASE WHEN MAX(APDoc.RefNbr) IS null then "0" ELSE MAX(APDoc.RefNbr) END from APDoc
Where APDoc.DocClass = 'C' And
APDoc.Acct = @parm1 AND
APDoc.Sub = @parm2


