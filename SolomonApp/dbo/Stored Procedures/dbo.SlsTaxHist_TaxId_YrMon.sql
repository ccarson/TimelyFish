 /****** Object:  Stored Procedure dbo.SlsTaxHist_TaxId_YrMon    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SlsTaxHist_TaxId_YrMon @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 6) as
           Select * from SlsTaxHist
                       where SlsTaxHist.TaxId = @parm2
					     and SlsTaxHist.CpnyId like @parm1
                         and SlsTaxHist.YrMon like @parm3
                       order by SlsTaxHist.TaxId , SlsTaxHist.CpnyId, SlsTaxHist.YrMon



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsTaxHist_TaxId_YrMon] TO [MSDSL]
    AS [dbo];

