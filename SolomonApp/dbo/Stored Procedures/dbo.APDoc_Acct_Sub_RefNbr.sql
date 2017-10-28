 /****** Object:  Stored Procedure dbo.APDoc_Acct_Sub_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Acct_Sub_RefNbr
@parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10) as
Select * from APDoc (NOLOCK) where Acct = @parm1
and Sub = @parm2
and RefNbr = @parm3
and Doctype in ("CK" ,"HC" ,"EP", "MC", "QC", "SC", "VC" , "ZC"  )
Order by Acct, Sub, DocType, RefNbr


