 /****** Object:  Stored Procedure dbo.DeleteAPHist    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteAPHist @parm1 varchar ( 4) As
Delete aphist from APHist Where
FiscYr <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteAPHist] TO [MSDSL]
    AS [dbo];

