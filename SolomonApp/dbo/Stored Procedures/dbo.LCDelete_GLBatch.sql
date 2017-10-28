 Create proc LCDelete_GLBatch
	@RcptNbr varchar(15)
as
Delete from Batch
WHERE
	Module = 'GL'
	and Crtd_Prog LIKE '61200%'
	and Batnbr in
		(Select Batnbr from GlTran where
			JrnlType = 'LC'
			and crtd_Prog LIKE '61200%'
			AND Rlsed = 0
			and Refnbr = @RcptNbr)


