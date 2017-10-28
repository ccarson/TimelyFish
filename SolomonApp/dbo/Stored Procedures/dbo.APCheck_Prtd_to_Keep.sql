 /****** Object:  Stored Procedure dbo.APCheck_Prtd_to_Keep    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APCheck_Prtd_to_Keep @parm1 varchar ( 10), @parm2 varchar ( 10) As
        Select Acct, Sub, RefNbr, DocType, CuryOrigDocAmt, Vendid, BatNbr
         From APDoc (NOLOCK) where BatNbr = @parm1 and RefNbr Like @parm2
         order by  Acct, Sub, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APCheck_Prtd_to_Keep] TO [MSDSL]
    AS [dbo];

