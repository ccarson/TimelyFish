 Create Proc  Employee_UPDT_Bat_ChkNbrCPrnt2 @parm1 varchar ( 10) as
       Update Employee
           Set  CurrBatNbr      =  ''      ,
                ChkNbr          =  ''      ,
                CurrCheckPrint  =   0
           where CurrBatNbr     =  @parm1


