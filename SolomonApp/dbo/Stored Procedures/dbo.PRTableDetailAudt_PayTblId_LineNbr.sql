 Create Proc  PRTableDetailAudt_PayTblId_LineNbr @parm1 varchar ( 4), @parm2 varchar( 4), @parm3 varchar( 25), @parm4beg smallint, @parm4end smallint as
       Select * from PRTableDetailAudt
           where PayTblId       =  @parm1
             and CalYr = @parm2
	     and audtdatesort = @parm3
             and LineNbr  BETWEEN  @parm4beg and @parm4end
           order by PayTblId, audtdatesort, LineNbr

