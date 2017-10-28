CREATE   Proc pCF512PigInvAdj_ALL
	 @parm1 varchar(10)
as
	Select * From cftPigInvAdj
	WHERE BatNbr LIKE @parm1
	Order by BatNbr

