 Create Proc  ExmptCredit_PayTblId @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from ExmptCredit
           where PayTblId  LIKE  @parm1
             and CalYr = @parm2
           order by DedId    ,
                    MarStat  ,
                    ExmptCr  ,
                    ExmptCrId


