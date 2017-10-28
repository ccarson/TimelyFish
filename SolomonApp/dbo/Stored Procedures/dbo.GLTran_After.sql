
CREATE proc [dbo].[GLTran_After]
 @batnbr varchar(10),
 @userid varchar (10)
as 

update 
	Batch 
SET 
	Batch.CrTot = COALESCE((select sum(a.cramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.CtrlTot = COALESCE((select sum(a.cramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.CuryCrTot = COALESCE((select sum(a.curycramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.CuryCtrlTot = COALESCE((select sum(a.curycramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.CuryDrTot = COALESCE((select sum(a.curydramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.DrTot = COALESCE((select sum(a.dramt)from GLTran a where a.module = 'PA' and a.batnbr = @batnbr and a.trantype <> 'IC'),0),
	Batch.LUpd_DateTime = getdate(),
	Batch.LUpd_Prog = 'PARPT',
	Batch.LUpd_User = @userId
where
	batch.batnbr = @batnbr and
	batch.module = 'PA'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_After] TO [MSDSL]
    AS [dbo];

