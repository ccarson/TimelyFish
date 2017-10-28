Create Procedure baGLTran_INBASD @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (24) as 
    Select  * from GLTran Where Module = 'IN' and BatNbr = @parm1 and Acct = @parm2
	and Sub = @parm3 and DrAmt > CrAmt

