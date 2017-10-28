 create procedure PurOrdDet_stran2 as
select PURORDDET.*, PURCHORD.POtype, PURCHORD.status, PURCHORD.cpnyid,
    PURCHORD.ponbr, PURCHORD.podate, PURCHORD.vendid, PURCHORD.curyratetype, PURCHORD.CuryEffDate,
    PJ_ACCOUNT.*
from PURORDDET, PURCHORD, PJ_ACCOUNT
where
PURORDDET.pc_status = '1' and
PURORDDET.PONbr   = PURCHORD.PONbr and
(PURORDDET.PurAcct = PJ_ACCOUNT.gl_acct OR PURORDDET.WIP_COGS_Acct = PJ_ACCOUNT.gl_acct) and
PURCHORD.POType  in ('OR','BL','DP') and
PURCHORD.status <> 'Q' and
PURCHORD.status <> 'X' and
PURCHORD.status <> 'M'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_stran2] TO [MSDSL]
    AS [dbo];

