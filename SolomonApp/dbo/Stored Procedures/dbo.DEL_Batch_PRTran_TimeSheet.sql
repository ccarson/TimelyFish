 Create Proc  DEL_Batch_PRTran_TimeSheet @parm1 varchar ( 6), @parm2 varchar ( 6) as
       Delete batch
			from Batch
				left outer join PRTran
					on Batch.BatNbr = PRTran.BatNbr
			where Batch.EditScrnNbr IN ('02010', '02020')
				and Batch.Status  in ('V', 'D', 'C')
				and Batch.PerPost <= @parm1
				and Batch.PerEnt  <  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DEL_Batch_PRTran_TimeSheet] TO [MSDSL]
    AS [dbo];

