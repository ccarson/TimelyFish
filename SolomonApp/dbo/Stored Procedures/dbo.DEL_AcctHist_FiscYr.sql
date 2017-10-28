 /****** Object:  Stored Procedure dbo.DEL_AcctHist_FiscYr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc DEL_AcctHist_FiscYr @parm1 varchar ( 4) as
       Delete accthist from AcctHist
           where FiscYr <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DEL_AcctHist_FiscYr] TO [MSDSL]
    AS [dbo];

