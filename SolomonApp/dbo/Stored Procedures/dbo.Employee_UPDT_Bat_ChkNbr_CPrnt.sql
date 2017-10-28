 Create Proc  Employee_UPDT_Bat_ChkNbr_CPrnt @parm1 varchar ( 10), @parm2 smallint as
       Update Employee
           Set  CurrCheckPrint   =  @parm2
           where CurrBatNbr      =  @parm1
             and ChkNbr          <> ""
             and CurrCheckPrint  <>  @parm2


