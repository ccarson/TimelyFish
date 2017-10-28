 /****** Object:  Stored Procedure dbo.upd_08240ARTran_PerPost    Script Date: 11/29/00 12:30:33 PM ******/
CREATE PROC upd_08240ARTran_PerPost @parm1 varchar(10), @parm2 VarChar (6) AS
UPDATE ARTran
  SET PerPost = @parm2
 WHERE Batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[upd_08240ARTran_PerPost] TO [MSDSL]
    AS [dbo];

