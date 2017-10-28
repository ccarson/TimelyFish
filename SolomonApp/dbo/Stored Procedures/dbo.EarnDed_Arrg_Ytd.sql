 Create Proc  EarnDed_Arrg_Ytd @parm1 varchar ( 10), @parm2 varchar ( 4), @parm3 varchar (10) as
       Select * from EarnDed
           where EarnDedId =  @parm1
             and EDType    =  "D"
             and CalYr     =  @parm2
             and EmpId  LIKE  @parm3
             and ArrgYTD   <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_Arrg_Ytd] TO [MSDSL]
    AS [dbo];

