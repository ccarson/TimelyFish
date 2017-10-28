
Create Proc Update_AssyDoc_PerPost 
	@parm1 varchar (10),
	@parm2 varchar (6)
as
	Update AssyDoc
	Set PerPost = @parm2
    Where BatNbr = @parm1
