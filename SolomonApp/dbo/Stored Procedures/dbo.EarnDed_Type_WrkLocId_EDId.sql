 Create Proc  EarnDed_Type_WrkLocId_EDId @parm1 varchar ( 1), @parm2 varchar ( 6), @parm3 varchar ( 10) as
       Select * from EarnDed
           where EDType       LIKE  @parm1
             and WrkLocId   LIKE  @parm2
             and EarnDedId  LIKE  @parm3
       order by EmpId, CalYr, EDType, WrkLocId, EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_Type_WrkLocId_EDId] TO [MSDSL]
    AS [dbo];

