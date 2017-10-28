 create procedure PRTRAN_stransum @parm1 varchar (6)   as
select *
from PRTRAN, PJ_ACCOUNT
where PRTRAN.perpost = @parm1 and
PRTRAN.acct = PJ_ACCOUNT.gl_acct and
((PRTRAN.pc_status = '1' and
PRTRAN.screennbr = '02020' and
PRTRAN.rlsed = 1 and
PRTRAN.type_ = 'TS')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.screennbr = '02010' and
PRTRAN.paid = 1 and
PRTRAN.type_ = 'TS')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.trantype = 'VC' and
PRTRAN.rlsed = 1 and
PRTRAN.type_ = 'E ')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.trantype = 'HC' and
PRTRAN.rlsed = 1)
OR
(PRTRAN.pc_status = '1' and
PRTRAN.screennbr = '58010' and
PRTRAN.rlsed = 1 and
PRTRAN.type_ = 'TS')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.screennbr = '58020' and
PRTRAN.rlsed = 1 and
PRTRAN.type_ = 'TS')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.screennbr = '02080' and
PRTran.TranType = 'CK' and
PRTRAN.rlsed = 1 and
PRTRAN.paid = 1 and
PRTRAN.type_ = 'E ')
OR
(PRTRAN.pc_status = '1' and
PRTRAN.rlsed = 1 and
PRTRAN.type_ = 'DE'))

Order by pj_account.acct, prtran.projectid, prtran.taskid, prtran.empid, prtran.trandate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTRAN_stransum] TO [MSDSL]
    AS [dbo];

