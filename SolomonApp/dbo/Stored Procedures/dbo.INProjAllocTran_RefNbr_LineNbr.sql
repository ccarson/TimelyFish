Create Proc INProjAllocTran_RefNbr_LineNbr @parm1 varchar ( 15), @parm3beg smallint, @parm3end smallint as
       Select * from INProjAllocTran
           where RefNbr  = @parm1
           and LineNbr between @parm3beg and @parm3end
           order by RefNbr, LineNbr
