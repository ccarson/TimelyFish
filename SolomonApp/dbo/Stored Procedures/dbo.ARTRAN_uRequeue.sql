 create procedure  ARTRAN_uRequeue  @parm1 varchar (6)  as
update ARTRAN
set pc_status = '1'
where
ARTRAN.perpost =  @parm1  and
ARTRAN.pc_status =  '9' and
ARTRAN.projectid <> '' and
ARTRAN.taskid <> ''
update ARTRAN
set pc_status = ' '
where
ARTRAN.perpost =  @parm1  and
ARTRAN.pc_status =  '9' and
ARTRAN.projectid = '' and
ARTRAN.taskid = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTRAN_uRequeue] TO [MSDSL]
    AS [dbo];

