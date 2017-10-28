 Create Proc LCDelete_APBatch
	@RcptNbr varchar(15)
as
Delete from Batch
	WHERE Module = 'AP'
	and Crtd_Prog LIKE '61200%'
	and Batnbr in (Select Batnbr from APTran where
			JrnlType = 'LC'
			and crtd_Prog LIKE '61200%'
			AND Rlsed = 0
			and ExtRefnbr = @RcptNbr)


