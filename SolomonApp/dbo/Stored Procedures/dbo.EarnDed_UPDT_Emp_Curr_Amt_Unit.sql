 Create Proc  EarnDed_UPDT_Emp_Curr_Amt_Unit @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Update EarnDed
           Set CurrEarnDedAmt     = 0.0,
               CurrRptEarnSubjDed = 0.0,
               CurrUnits          = 0.0,
               ArrgCurr           = 0.0
           where EmpId = @parm1
             and CalYr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_UPDT_Emp_Curr_Amt_Unit] TO [MSDSL]
    AS [dbo];

