 /****** Object:  Stored Procedure dbo.APDoc_Batch    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Batch @parm1 varchar ( 10) as
Select * from APDoc Where
APDoc.BatNbr = @parm1 and
APDoc.Rlsed = 0
Order by APDoc.BatNbr, APDoc.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Batch] TO [MSDSL]
    AS [dbo];

