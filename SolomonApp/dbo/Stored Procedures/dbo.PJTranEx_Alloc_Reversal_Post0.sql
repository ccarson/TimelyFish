
CREATE proc [dbo].[PJTranEx_Alloc_Reversal_Post0]
	@batnbr varchar(10),
	@userid varchar (10)
as 

select 
	batch_id	=	c.batnbr,
	crtd_datetime	=	getdate(),
	crtd_prog	=	'PAPTT00',
	crtd_user	=	@userid,
	detail_num	=	'same as corresponding PJTran',
	equip_id	=	b.equip_id,
	fiscalno	=	c.perpost,
	invtid		=	b.invtid,
	lotsernbr	=	b.lotsernbr,
	lupd_datetime	=	getdate(),
	lupd_prog	=	'PAPTT00',
	lupd_user	=	@userid,
	siteid		=	b.siteid,
	system_cd	=	'PA',
	tr_id11		=	'Concatenated key - this transaction',
	tr_id12		=	'concatenated key - reversed transaction',
	tr_id13		=	'concatenated key - reversed transaction',
	tr_id14		=	b.tr_id14,
	tr_id15		=	b.tr_id15,
	tr_id16		=	b.tr_id16,
	tr_id17		=	b.tr_id17,
	tr_id18		=	b.tr_id18,
	tr_id19		=	b.tr_id19,
	tr_id20		=	b.tr_id20,
	tr_id21		=	b.tr_id21,
	tr_id22		=	b.tr_id22,
	tr_status2	=	b.tr_status2,
	tr_status3	=	b.tr_status3,
	whseloc		=	b.whseloc,
	tstamp		=	NULL
from
	PJTrnsfr a 
join
	PJTranEx b 
on
	a.Origfiscalno = b.fiscalno and
	a.Origsystem_cd = b.system_cd and
	a.Origbatch_id = b.batch_id and
	a.Origdetail_num = b.detail_num
join
	Batch c 
on
	a.batch_id = c.batnbr and 
	c.module = 'PA'
Join
	PJAllAud d on
	a.Origfiscalno = d.fiscalno and
	a.Origsystem_cd = d.system_cd and
	a.Origbatch_id = d.batch_id and
	a.Origdetail_num = d.detail_num and
	d.post_project <> '' and
	d.recalc_flag = ''
where
	c.batnbr = @batnbr and
	c.module = 'PA'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTranEx_Alloc_Reversal_Post0] TO [MSDSL]
    AS [dbo];

