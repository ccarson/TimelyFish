 Create Proc  PRTran_Type_WrkLocId_DEDId_CalYr @parm1 varchar ( 2), @parm2 varchar ( 6), @parm3 varchar ( 10), @parm4 varchar ( 4) as
       Select * from PRTran
           where Type_       LIKE  @parm1
             and WrkLocId   LIKE  @parm2
             and EarnDedId  LIKE  @parm3
             and CalYr = @parm4
           order by EarnDedId, Type_, WrkLocId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_Type_WrkLocId_DEDId_CalYr] TO [MSDSL]
    AS [dbo];

