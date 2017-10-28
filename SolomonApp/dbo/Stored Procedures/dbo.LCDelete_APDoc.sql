 Create Proc LCDelete_APDoc
	@RcptNbr varchar(15)
as
Delete from Apdoc
WHERE
	Crtd_Prog LIKE '61200%'
	and Refnbr in (Select Refnbr from Aptran where
			JrnlType = 'LC'
			and crtd_Prog LIKE '61200%'
			AND Rlsed = 0
			and ExtRefnbr = @RcptNbr)

