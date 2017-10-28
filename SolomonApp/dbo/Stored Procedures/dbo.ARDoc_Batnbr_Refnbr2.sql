 /****** Object:  Stored Procedure dbo.ARDoc_Batnbr_Refnbr2    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_Batnbr_Refnbr2 @parm1 varchar ( 10), @parm2 varchar ( 10) as
Select * from ARDoc where (BatNbr = @parm1   and ARDoc.RefNbr like @parm2 and
DocType <> 'VT' and DocType <>'RC')
order by BatNbr, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Batnbr_Refnbr2] TO [MSDSL]
    AS [dbo];

