 Create Procedure CuryAcTb_CuryId_AdjAcct @parm1 varchar ( 4), @parm2 varchar ( 10) as
    select *
	from CuryAcTb
		left outer join Account
			on CuryAcTb.AdjAcct = Account.Acct
    where CuryAcTb.CuryID = @parm1
		and AdjAcct like @parm2
    order by CuryAcTb.CuryID, CuryAcTb.AdjAcct


