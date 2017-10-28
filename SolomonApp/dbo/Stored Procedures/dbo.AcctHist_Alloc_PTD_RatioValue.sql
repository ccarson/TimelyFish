 Create PROCEDURE AcctHist_Alloc_PTD_RatioValue
	@CpnyID varchar ( 10),
	@Acct varchar ( 10),
	@Sub varchar ( 24),
	@LedgerID  varchar(10),
	@FiscYr varchar(4),
	@Period smallint

	As
    
    Select SUM(Case @Period When 1 Then (PtdBal00 - PtdAlloc00)
				When 2 Then (PtdBal01 - PtdAlloc01)
				When 3 Then (PtdBal02 - PtdAlloc02)
				When 4 Then (PtdBal03 - PtdAlloc03)
				When 5 Then (PtdBal04 - PtdAlloc04)
				When 6 Then (PtdBal05 - PtdAlloc05)
				When 7 Then (PtdBal06 - PtdAlloc06)
				When 8 Then (PtdBal07 - PtdAlloc07)
				When 9 Then (PtdBal08 - PtdAlloc08)
				When 10 Then (PtdBal09 - PtdAlloc09)
				When 11 Then (PtdBal10 - PtdAlloc10)
				When 12 Then (PtdBal11 - PtdAlloc11)
				When 13 Then (PtdBal12 - PtdAlloc12)
			End)
    
  From AcctHist
           where CpnyId = @CpnyID
             and Acct like @Acct
             and Sub like @Sub
             and LedgerID = @LedgerID
             and Fiscyr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Alloc_PTD_RatioValue] TO [MSDSL]
    AS [dbo];

