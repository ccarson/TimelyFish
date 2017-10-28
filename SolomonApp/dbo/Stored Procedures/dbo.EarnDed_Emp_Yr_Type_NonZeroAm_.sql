 Create Proc  EarnDed_Emp_Yr_Type_NonZeroAm_ @parm1 varchar ( 10), @parm2 varchar ( 4), @parm3 varchar ( 1) as
       Select * from EarnDed
           where EmpId           =     @parm1
             and CalYr           =     @parm2
             and EDType            LIKE  @parm3
             and
             (   (CurrEarnDedAmt     <> 0.0)
              or (CurrUnits          <> 0.0)
              or (CurrRptEarnSubjDed <> 0.0)
              or (CalYTDEarnDed      <> 0.0)
             )
           order by EmpId, CalYr, EDType, WrkLocId, EarnDedType, EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_Emp_Yr_Type_NonZeroAm_] TO [MSDSL]
    AS [dbo];

