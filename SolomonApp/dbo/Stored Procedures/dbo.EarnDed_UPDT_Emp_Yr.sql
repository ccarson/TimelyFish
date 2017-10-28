 Create Proc  EarnDed_UPDT_Emp_Yr @parm1 smallint, @parm2 smallint, @parm3 float, @parm4 float,
                                 @parm5 float, @parm6 float, @parm7 smallint, @parm8 as smallint,
                                 @parm9 smallint, @parm10 varchar ( 10), @parm11 varchar ( 4), @parm12 varchar ( 10), @parm13 int as
       Update Earnded set NbrPersExmpt = @parm1,
                          NbrOthrExmpt = @parm2,
                          AddlExmptAmt = @parm3,
                          AddlCRAmt    = @parm4,
                          FxdPctRate   = @parm5,
                          CalMaxYTDDed = @parm6,
                          Exmpt        = @parm7,
                          Dedsequence  = @parm8,
                          ArrgEmpAllow = @parm9,
                          NoteId       = @parm13
           where EmpId      =     @parm10
             and CalYr      =     @parm11
             and EDType     =     "D"
             and EarnDedId  =     @parm12



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_UPDT_Emp_Yr] TO [MSDSL]
    AS [dbo];

