
CREATE proc [dbo].[PJTran_To_Trans_AllocCreated]
 @batnbr varchar(10)

as 

select t.* from pjtran t

join
	pjtranex e1
on
	t.fiscalno		= e1.fiscalno and
    	t.system_cd		= e1.system_cd and
    	t.batch_id		= e1.batch_id and
    	t.detail_num		= e1.detail_num

join
	pjtran a
on
	a.project = t.project and
	a.pjt_entity = t.pjt_entity

join
	pjtranex e2
on
	a.fiscalno		= e2.fiscalno and
    	a.system_cd		= e2.system_cd and
    	a.batch_id		= e2.batch_id and
    	a.detail_num	= e2.detail_num

where t.batch_id = @batnbr and 
	e1.tr_id11 = e2.tr_id12 and 
	t.tr_id25 = ''


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_To_Trans_AllocCreated] TO [MSDSL]
    AS [dbo];

