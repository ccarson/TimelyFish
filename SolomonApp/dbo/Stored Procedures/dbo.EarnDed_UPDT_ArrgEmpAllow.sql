 Create Proc EarnDed_UPDT_ArrgEmpAllow @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Update EarnDed set ArrgEmpAllow = 0
           where EarnDedId =  @parm1
             and EDType    =  "D"
             and CalYr     =  @parm2
             and ArrgEmpAllow <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_UPDT_ArrgEmpAllow] TO [MSDSL]
    AS [dbo];

