Create Proc Update_INTran_PerPost 
	@parm1 varchar (10),
	@parm2 varchar (6)
as
	Update INTran 
	Set PerPost = @parm2
	Where Batnbr = @parm1
