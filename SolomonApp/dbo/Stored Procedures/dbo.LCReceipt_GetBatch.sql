 Create Proc LCReceipt_GetBatch
	@RcptNbr varchar(15)
as
Select * FROM Batch
WHERE
	batnbr = (Select Batnbr from poreceipt
			WHERE RcptNbr = @RcptNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_GetBatch] TO [MSDSL]
    AS [dbo];

