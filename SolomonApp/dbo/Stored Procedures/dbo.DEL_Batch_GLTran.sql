 Create Proc  DEL_Batch_GLTran @parm1 varchar ( 6), @parm2 varchar ( 6) as
       Delete batch
			from Batch
				left outer join GLTran
					on Batch.Module = GLTran.Module
					and Batch.BatNbr = GLTran.BatNbr
			where Batch.Module  =  'GL'
				and Batch.Status  in ('V', 'D', 'P')
				and Batch.PerPost <= @parm1
				and Batch.PerEnt  <  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DEL_Batch_GLTran] TO [MSDSL]
    AS [dbo];

