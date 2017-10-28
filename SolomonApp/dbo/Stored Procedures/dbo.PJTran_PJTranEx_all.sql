
create procedure PJTran_PJTranEx_all @parm1 varchar (16)  as
select a.*, b.* from PJTran a inner join
pjtranex b on a.fiscalno = b.fiscalno and
			  a.system_cd = b.system_cd and
			  a.batch_id = b.batch_id and 
			  a.detail_num = b.detail_num

where a.project like @parm1
order by project

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_PJTranEx_all] TO [MSDSL]
    AS [dbo];

