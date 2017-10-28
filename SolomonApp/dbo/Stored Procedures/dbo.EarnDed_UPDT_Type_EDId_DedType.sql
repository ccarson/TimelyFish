 Create Proc  EarnDed_UPDT_Type_EDId_DedType @parm1 varchar ( 1), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4 varchar ( 4) as
       Update EarnDed
           Set EarnDedType = @parm3
           where EDType       =  @parm1
             and EarnDedId  =  @parm2
             and CalYr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_UPDT_Type_EDId_DedType] TO [MSDSL]
    AS [dbo];

