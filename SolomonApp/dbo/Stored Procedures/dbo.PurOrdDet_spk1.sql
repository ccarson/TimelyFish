 create procedure PurOrdDet_spk1 as
select * from PURORDDET, PURCHORD, PJ_ACCOUNT
where    PURORDDET.PONbr   = PURCHORD.PONbr and
PURORDDET.PurAcct = PJ_ACCOUNT.gl_acct and
PURCHORD.POType  in ('OR','BL','DP') and
PURCHORD.Status  in ('P','O','C') and
PURORDDET.User4 = 1
order by PURORDDET.PONbr,
PURORDDET.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_spk1] TO [MSDSL]
    AS [dbo];

