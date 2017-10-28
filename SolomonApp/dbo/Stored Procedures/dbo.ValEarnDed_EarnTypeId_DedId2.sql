 Create Proc  ValEarnDed_EarnTypeId_DedId2 @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select EarnTypeId, DedId  from ValEarnDed
           where EarnTypeId  LIKE  @parm1
             and DedId       LIKE  @parm2
           order by EarnTypeId,
                    DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ValEarnDed_EarnTypeId_DedId2] TO [MSDSL]
    AS [dbo];

