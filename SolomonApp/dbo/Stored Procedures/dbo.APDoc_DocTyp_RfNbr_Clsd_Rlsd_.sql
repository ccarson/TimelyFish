 /****** Object:  Stored Procedure dbo.APDoc_DocTyp_RfNbr_Clsd_Rlsd_    Script Date: 11/30/98  ******/
/****  11/30/98 CSS - Added new proc for use in 03.540.00 *****/
Create Procedure APDoc_DocTyp_RfNbr_Clsd_Rlsd_ @parm1 varchar ( 4), @parm2 varchar ( 10) as
Select * from APDoc
Where
APDoc.Doctype = @parm1
and APDoc.RefNbr LIKE  @parm2
and APDoc.OpenDoc  =  0
and APDoc.Rlsed    =  1
and APDoc.Selected =  0
Order by APDoc.RefNbr, APDoc.DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocTyp_RfNbr_Clsd_Rlsd_] TO [MSDSL]
    AS [dbo];

