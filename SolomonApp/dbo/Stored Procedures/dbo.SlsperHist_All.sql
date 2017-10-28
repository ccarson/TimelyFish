 /****** Object:  Stored Procedure dbo.SlsperHist_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc SlsperHist_All @parm1 varchar ( 10), @parm2 varchar ( 4) as
    Select * from SlsperHist where SlsperId like @parm1
           and FiscYr like @parm2 order by SlsperId, FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsperHist_All] TO [MSDSL]
    AS [dbo];

