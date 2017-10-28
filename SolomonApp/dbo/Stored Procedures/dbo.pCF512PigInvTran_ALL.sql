CREATE   Proc pCF512PigInvTran_ALL
	 @parm1 varchar(10)
as
	Select * From cftPigInvTran
	WHERE BatNbr LIKE @parm1
	Order by BatNbr

