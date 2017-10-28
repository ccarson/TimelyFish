 Create Proc  PRTableDetail_PayTblId_MinAmt_ @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from PRTableDetail
           where PayTblId  LIKE  @parm1
             and CalYr = @parm2
           order by  PayTblId     ,
                     MinAmt   DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTableDetail_PayTblId_MinAmt_] TO [MSDSL]
    AS [dbo];

