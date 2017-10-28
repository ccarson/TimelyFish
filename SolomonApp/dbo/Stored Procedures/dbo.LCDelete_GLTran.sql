 Create proc LCDelete_GLTran
	@RcptNbr varchar(15)
as
DELETE FROM GLTran
WHERE
	JrnlType = 'LC'
	and crtd_Prog LIKE '61200%'
	AND Rlsed = 0
	and Refnbr = @RcptNbr


