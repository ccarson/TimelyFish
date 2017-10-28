 Create Proc LCDelete_APTran
	@RcptNbr varchar(15)
as
DELETE FROM APTran
WHERE
	JrnlType = 'LC'
	and crtd_Prog LIKE '61200%'
	AND Rlsed = 0
	and ExtRefnbr = @RcptNbr


