 create procedure  ARDOC_sprj @parm1 varchar (16)   as
select docbal, docdate, doctype, refnbr, user1, user2, user4, rlsed,
bankacct, jobcntr
from  ARDOC
where ARDOC.projectid =  @parm1 and
ARDOC.rlsed =  1 and
ARDOC.docbal <> 0 and
(ARDOC.doctype = 'IN' or
ARDOC.doctype = 'FI' or
ARDOC.doctype = 'DM')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_sprj] TO [MSDSL]
    AS [dbo];

