 /****** Object:  Stored Procedure dbo.GLTran_DEL_Module_BatNbr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc GLTran_DEL_Module_BatNbr @parm1 varchar ( 2), @parm2 varchar ( 10) as
       Delete gltran from GLTran
           where Module  = @parm1
                          and BatNbr  = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_DEL_Module_BatNbr] TO [MSDSL]
    AS [dbo];

