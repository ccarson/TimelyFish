 /****** Object:  Stored Procedure dbo.APDocCk_View_Select    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDocCk_View_Select @parm1 varchar ( 10) as
Select RefNbr, CuryOrigDocAmt, InvcNbr, VendId, CuryDiscBal, PmtMethod from APDoc
        Where BatNbr = @parm1
        Order by VendID, InvcNbr


