 create procedure PurOrdDet_stran as
select * from PURORDDET, PURCHORD, PJ_ACCOUNT
where
PURORDDET.pc_status = '1' and
PURORDDET.PONbr   = PURCHORD.PONbr and
PURORDDET.PurAcct = PJ_ACCOUNT.gl_acct and
PURCHORD.POType  in ('OR','BL','DP') and
PURCHORD.status <> 'Q' and
PURCHORD.status <> 'X' and
PURCHORD.status <> 'M'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_stran] TO [MSDSL]
    AS [dbo];

