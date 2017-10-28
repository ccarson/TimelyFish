 Create Proc  PRTableDetail_PayTblId_LineNbr @parm1 varchar ( 4), @parm2 varchar( 4), @parm3beg smallint, @parm3end smallint as
       Select * from PRTableDetail
           where PayTblId       =  @parm1
             and CalYr = @parm2
             and LineNbr  BETWEEN  @parm3beg and @parm3end
           order by PayTblId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTableDetail_PayTblId_LineNbr] TO [MSDSL]
    AS [dbo];

