 Create Proc LCDelete_InBatch
	@RcptNbr Varchar(15)
	AS
Delete from Batch
	WHERE Module = 'IN'
	and Crtd_Prog LIKE '61200%'
	and Batnbr in
	(Select batnbr from intran Where
		JrnlType = 'LC'
		and crtd_Prog LIKE '61200%'
		AND Rlsed = 0
		and RcptNbr = @rcptnbr)


