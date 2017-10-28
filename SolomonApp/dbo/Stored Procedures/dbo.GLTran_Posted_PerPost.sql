 /****** Object:  Stored Procedure dbo.GLTran_Posted_PerPost    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc GLTran_Posted_PerPost @parm1 varchar ( 1), @parm2 varchar ( 6) as
       Select * from GLTran
           where Posted             =  @parm1
             and PerPost  Like         @parm2
           order by Posted, Acct, Sub, PerPost



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Posted_PerPost] TO [MSDSL]
    AS [dbo];

