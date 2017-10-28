 /****** Object:  Stored Procedure dbo.DEL_GLTran_GL_Post_PerPost_    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc DEL_GLTran_GL_Post_PerPost_ @parm1 varchar ( 6), @parm2 varchar ( 6) as
       Delete gltran from GLTran
           where Module  = 'GL'
             and Posted   = 'P'
             and PerPost <= @parm1
             and PerEnt  <  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DEL_GLTran_GL_Post_PerPost_] TO [MSDSL]
    AS [dbo];

