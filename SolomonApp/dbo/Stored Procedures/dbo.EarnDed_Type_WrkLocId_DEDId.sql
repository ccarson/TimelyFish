 Create Proc  EarnDed_Type_WrkLocId_DEDId @parm1 varchar ( 1), @parm2 varchar ( 6), @parm3 varchar ( 10) as
       Select * from EarnDed
           where EDType       LIKE  @parm1
             and WrkLocId   LIKE  @parm2
             and EarnDedId  LIKE  @parm3
       order by EarnDedId, EDType, WrkLocId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_Type_WrkLocId_DEDId] TO [MSDSL]
    AS [dbo];

