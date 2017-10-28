 Create Procedure SCM_10400_Batch_Validation
	@BatNbr			Varchar(10)
As
		-- Validate the batch for duplicate lineref in INTran records
	SELECT  COUNT(*) FROM INTran (nolock)
				WHERE BatNbr = @BatNbr
					AND INTran.TranType Not In ('CG', 'CT')
				GROUP BY LineRef HAVING  COUNT(*) > 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Batch_Validation] TO [MSDSL]
    AS [dbo];

