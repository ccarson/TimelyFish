 /****** Object:  Stored Procedure dbo.HistDocSlsTax_TaxId_YrMon    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc HistDocSlsTax_TaxId_YrMon @parm1 varchar ( 10), @parm2 varchar ( 6), @parm3 varchar ( 2), @parm4 varchar ( 10) as
           Select * from HistDocSlsTax
                       where HistDocSlsTax.TaxId = @parm1
                         and HistDocSlsTax.YrMon like @parm2
                         and HistDocSlsTax.DocType like @parm3
                         and HistDocSlsTax.RefNbr like @parm4
                       order by HistDocSlsTax.TaxId ,
                                HistDocSlsTax.YrMon,
                                HistDocSlsTax.DocType,
                                HistDocSlsTax.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[HistDocSlsTax_TaxId_YrMon] TO [MSDSL]
    AS [dbo];

