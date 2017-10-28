 Create Proc PJInvDet_Aged2 @CpnyID Varchar(10)
as

	declare @Today smalldatetime

	select @Today = convert(smalldatetime, GETDATE())

select c3060 =sum(case when DATEDIFF(Day, pjinvdet.source_trx_date, @Today) > CONVERT(INT,30) and DATEDIFF(Day, pjinvdet.source_trx_date, @Today) <= CONVERT(INT,60) 
  THEN(pjinvdet.amount)  Else 0 End),
 c6090 = sum(case when DATEDIFF(Day, pjinvdet.source_trx_date, @Today) > CONVERT(INT,60) and DATEDIFF(Day, pjinvdet.source_trx_date, @Today) <= CONVERT(INT,90) 
  THEN(pjinvdet.amount)  Else 0 End),
 c90120 = sum(case when DATEDIFF(Day, pjinvdet.source_trx_date, @Today) > CONVERT(INT,90) and DATEDIFF(Day, pjinvdet.source_trx_date, @Today) <= CONVERT(INT,120) 
  THEN(pjinvdet.amount)  Else 0 End),
cOver120 = sum(case when DATEDIFF(Day, pjinvdet.source_trx_date, @Today) > CONVERT(INT,120) 
  THEN(pjinvdet.amount)  Else 0 End),
  cTotal = sum(case when DATEDIFF(Day, pjinvdet.source_trx_date, @Today) > CONVERT(INT,30) 
  THEN(pjinvdet.amount)  Else 0 End)
 from pjinvdet
where pjinvdet.bill_status <> 'B' and hold_status <> 'PG' and pjinvdet.CpnyId like @CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJInvDet_Aged2] TO [MSDSL]
    AS [dbo];

