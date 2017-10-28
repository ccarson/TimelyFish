
Create Proc EarnDed_CHCK_ArrgEmpAllow  @parm1 varchar (10), @parm2 varchar (4), @parm3 varchar (10) as
       Select ArrgEmpAllow from EarnDed
            where EmpId     = @parm1
              and CalYr     = @parm2
              and EarnDedId = @parm3
              and EDType    = "D"



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_CHCK_ArrgEmpAllow] TO [MSDSL]
    AS [dbo];

