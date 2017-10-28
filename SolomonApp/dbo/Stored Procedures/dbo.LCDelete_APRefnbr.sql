 Create Proc LCDelete_APRefnbr
	@RcptNbr varchar(15)
as
Delete from Refnbr
WHERE
	Refnbr in (Select Refnbr from Aptran where
			JrnlType = 'LC'
			and crtd_Prog LIKE '61200%'
			AND Rlsed = 0
			and ExtRefnbr = @RcptNbr)


