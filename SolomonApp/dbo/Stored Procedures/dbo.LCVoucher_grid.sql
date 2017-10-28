 create proc LCVoucher_grid
	@parmCpnyID varchar(10)as
	select distinct
		LCVoucher.CPNYID,
		LCVoucher.APBatNbr,
		LCVoucher.APRefNbr,
		APDoc.VendID
	from
		LCVoucher,
		Batch, APDoc
	where
		Batch.Module='AP'
		and
		LCVoucher.CpnyID like @parmCpnyID
		and
		Batch.BatNbr = LCVoucher.APBatNbr
		and
		Batch.status  in ('C','P','U')
		and
		transtatus = 'U'
		and
		APDoc.RefNbr = LCVoucher.APRefnbr
		and
		APDoc.Rlsed = 1
	order by
		LCVoucher.CpnyID,
		LCVoucher.APBatNbr,
		LCVoucher.APRefNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_grid] TO [MSDSL]
    AS [dbo];

