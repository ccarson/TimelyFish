 Create PROCEDURE AcctHist_Alloc_YTD_RatioValue
	@CpnyID varchar ( 10),
	@Acct varchar ( 10),
	@Sub varchar ( 24),
	@LedgerID  varchar(10),
	@FiscYr varchar(4),
	@Period smallint

	As
    
    Select SUM(Case @Period When 1 Then (YtdBal00 - PtdAlloc00)
				When 2 Then (YtdBal01 - PtdAlloc01)
				When 3 Then (YtdBal02 - PtdAlloc02)
				When 4 Then (YtdBal03 - PtdAlloc03)
				When 5 Then (YtdBal04 - PtdAlloc04)
				When 6 Then (YtdBal05 - PtdAlloc05)
				When 7 Then (YtdBal06 - PtdAlloc06)
				When 8 Then (YtdBal07 - PtdAlloc07)
				When 9 Then (YtdBal08 - PtdAlloc08)
				When 10 Then (YtdBal09 - PtdAlloc09)
				When 11 Then (YtdBal10 - PtdAlloc10)
				When 12 Then (YtdBal11 - PtdAlloc11)
				When 13 Then (YtdBal12 - PtdAlloc12)
			End)
    
  From AcctHist
           where CpnyId = @CpnyID
             and Acct like @Acct
             and Sub like @Sub
             and LedgerID = @LedgerID
             and Fiscyr = @FiscYr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Alloc_YTD_RatioValue] TO [MSDSL]
    AS [dbo];

