 /****** Object:  Stored Procedure dbo.delete_ARHist    Script Date: 4/7/98 12:30:34 PM ******/
Create PROC delete_ARHist @parm1 varchar ( 4) As
        DELETE arhist FROM ARHist WHERE ARHist.FiscYr <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[delete_ARHist] TO [MSDSL]
    AS [dbo];

