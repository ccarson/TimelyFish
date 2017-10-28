 Create Proc AcctHist_Acct_Sub_Mask_LMT @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 varchar ( 4) As
Select Acct, Sub  from AcctHist
where CpnyId = @parm1
and Acct like @parm2
and Sub like @parm3
and ledgerid like @parm4
and FiscYr like @parm5
order by CpnyID, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Acct_Sub_Mask_LMT] TO [MSDSL]
    AS [dbo];

