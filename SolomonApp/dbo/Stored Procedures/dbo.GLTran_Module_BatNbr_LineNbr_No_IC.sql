Create Proc GLTran_Module_BatNbr_LineNbr_No_IC @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3beg smallint, @parm3end smallint as
       Select * from GLTran
           where Module  = @parm1
             and BatNbr  = @parm2
             and LineNbr between @parm3beg and @parm3end
             AND TranType <> 'IC'
           order by Module, BatNbr, LineNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Module_BatNbr_LineNbr_No_IC] TO [MSDSL]
    AS [dbo];

