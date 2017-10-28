 CREATE proc AcctHist_Close_year @today varchar(10), @fisc_year varchar(4), @user_name varchar(47)
as
set nocount on
set quoted_identifier off

declare @acct varchar(10),
        @sub varchar(24),
        @nextfiscyr varchar(4),
	@CpnyID     varchar(10),
        @iid int,
	@rowcount int,
	@error int

declare @ledgerid varchar(10),
        @balancetype char(1),
        @basecuryID varchar(4),
        @basecuryprec smallint,
        @curyprec smallint,
        @curyid  varchar(4),
        @begbal float,
        @curybegbal float,
	@YTDBal00 float,
	@CuryYTDBal00 float

declare @RetEarnAcct varchar(10),
	@YTDNetIncAcct varchar(10),
	@YearEndFiscPer varchar(10),
	@NbrPer smallint,
        @pernbr varchar(6),
        @r_pernbr varchar(6)

select  @ledgerid = '',
        @balancetype = '',
        @basecuryID = '',
        @curyID = '',
        @begbal = 0.0,
        @curybegbal = 0.0,
	@YTDBal00 = 0.0,
	@CuryYTDBal00=0.0,
	@iid = 0,
        @basecuryprec= 0,
        @curyprec=0

select @nextfiscyr = cast((cast(@fisc_year as int) + 1) as varchar)

SELECT @YTDNetIncAcct = YTDNetIncAcct, @RetEarnAcct = RetEarnAcct, @pernbr = PerNbr, @YearEndFiscPer = 'YTDBal' + CASE len(NbrPer-1) WHEN 1 THEN '0' + cast(NbrPer-1 as varchar) ELSE  cast(NbrPer-1 as varchar) END From glsetup (NOLOCK)
SELECT @r_pernbr = isnull(cast(cast(@pernbr as int)-1 as varchar),0)

create table #AcctHist
(	iid int not null Identity(1,1) Primary key,
	Acct                 varchar (10),
	Sub                  varchar (24),
	CpnyID               varchar (10),
	CuryId               varchar (4),
	FiscYr               varchar (4),
	LedgerID             varchar (10),
	BalanceType	     char(1) NULL,
	BaseCuryID	     varchar(4) NULL,
	BdgtRvsnDate         smalldatetime,
	LastClosePerNbr      varchar (6),
	YtdBal11             float NULL,
	BegBal               float NULL,
	PtdBal00             float NULL,
	YtdBal00             float NULL,
	PtdCon00    	     float NULL,
        updated              smallint Default 0
)IF @@error<>0
  Goto BAD_EXIT

Create unique nonclustered index #temp_ind_AcctHist on #AcctHist (CpnyID, Acct, Sub, LedgerID, FiscYr)

IF @@error<>0
  Goto BAD_EXIT

exec
("INSERT #AcctHist
(	Acct,
	Sub,
	CpnyID,
	CuryId,
	FiscYr,
	LedgerID,
	BalanceType,
	BdgtRvsnDate,
	LastClosePerNbr,
	YtdBal11,
	BegBal,
	PtdBal00,
	YtdBal00,
	PtdCon00

)
Select
	AcctHist.Acct,
	AcctHist.Sub,
	AcctHist.CpnyID,
	AcctHist.CuryID,
	AcctHist.FiscYr,
	AcctHist.LedgerID,
	AcctHist.BalanceType,
	AcctHist.BdgtRvsnDate,
	AcctHist.LastClosePerNbr,
	AcctHist.YTDBal11,
	AcctHist.BegBal,
	AcctHist.PtdBal00,
	AcctHist.YTDBal00,
	AcctHist.PtdCon00
from   AcctHist, Account
where (AcctHist.FiscYr = '" +@fisc_year +"' )
	and AcctHist.Acct = Account.Acct
	and AcctHist.BalanceType <> 'B'
	and (LastClosePerNbr <> '" + @pernbr + "')
	and (Account.AcctType like '' or account.AcctType like  '_A%'  or account.AcctType like '_L%'  )
	and (AcctHist.Acct <> '" + @YTDNetIncAcct + "')
	and (AcctHist." + @YearEndFiscPer + " <> 0.00)
order by AcctHist.FiscYr,
	AcctHist.Acct,
	AcctHist.Sub"
)IF @@error<>0
  Goto BAD_EXIT

exec(
"Update  #AcctHist
set YTDBal11 = b." + @YearEndFiscPer + "
From #AcctHist a, AcctHist b
Where a.CpnyID = b.CpnyID
	And   a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.FiscYr   = b.FiscYr")

IF @@error<>0
  Goto BAD_EXIT

Update #AcctHist
	set updated = 1
From #AcctHist a, AcctHist b
Where a.CpnyID = b.CpnyID
	And   a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   b.FiscYr = @nextfiscyr
        And   b.BalanceType <> 'B'

IF @@error<>0
  Goto BAD_EXIT

Update #AcctHist
	set updated = 99
From #AcctHist a
Where Not Exists
(Select 1 From Account b Where a.Acct = b.Acct)

IF @@error<>0
  Goto BAD_EXIT

If isnull(object_id('tempdb..#tt'),0) <> 0
Begin
  Insert #tt(acct, tab_name) Select acct, 'AcctHist' From AcctHist a Where
		Not Exists (Select 1 From Account b Where a.Acct = b.Acct)
		and Not Exists (select 1 from #tt b where a.acct = b.acct)

  If @@error<>0
    Goto BAD_EXIT
End

Update #AcctHist
	set BalanceType = b.BalanceType,
	    BaseCuryID = b.BaseCuryID
From #AcctHist a, Ledger b
Where a.Ledgerid = b.Ledgerid

IF @@error<>0
  Goto BAD_EXIT

INSERT into AcctHist
	(Acct, AnnBdgt, AnnMemo1, BalanceType, BdgtRvsnDate, BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryId, DistType, FiscYr, LastClosePerNbr, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
	PtdAlloc00, PtdAlloc01, PtdAlloc02, PtdAlloc03, PtdAlloc04, PtdAlloc05, PtdAlloc06, PtdAlloc07,
	PtdAlloc08, PtdAlloc09, PtdAlloc10, PtdAlloc11, PtdAlloc12, PtdBal00, PtdBal01, PtdBal02, PtdBal03,
	PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09, PtdBal10, PtdBal11, PtdBal12, PtdCon00,
	PtdCon01, PtdCon02, PtdCon03, PtdCon04, PtdCon05, PtdCon06, PtdCon07, PtdCon08, PtdCon09, PtdCon10,
	PtdCon11, PtdCon12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, SpreadSheetType, Sub, User1, User2, User3,
        User4, User5, User6, User7, User8, YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05, YtdBal06,
        YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11, YtdBal12, YTDEstimated)
select
	Acct, '', '', BalanceType, @today, YTDBal11, CpnyID, cast(getdate() as smalldatetime), '01560', @user_name, CuryId, '', @nextfiscyr, @pernbr,
	LedgerID, cast(getdate() as smalldatetime), '01560', @user_name, '', '', '', '', 	'', '', '', '', '', '', '', '', '', '', 0.0, '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', Sub, '', '', '', '', '', '', '', '', YTDBal11, '', '', '',
        '', '', '', '', '', '', '', '', '', ''
From #AcctHist a
where a.updated = 0

IF @@error<>0
  Goto BAD_EXIT

update AcctHist
set LastClosePerNbr = @pernbr,
    BegBal = b.YTDBal11,
    PtdBal00 = 0.0,
    YTDBal00 = b.YTDBal11,
    LUpd_DateTime = cast(getdate() as smalldatetime),
    LUpd_Prog = '01560',
    LUpd_User = @user_name
From AcctHist a, #AcctHist b
Where a.CpnyID = b.CpnyID
	And   a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   b.FiscYr = @nextfiscyr
        And   a.BalanceType <> 'B'

IF @@error<>0
  Goto BAD_EXIT

Truncate table #AcctHist

IF @@error<>0
  Goto BAD_EXIT

INSERT #AcctHist
(	Acct,
	Sub,
	CpnyID,
	CuryId,
	FiscYr,
	LedgerID,
	BalanceType,
	BdgtRvsnDate,
	LastClosePerNbr,
	YtdBal11,
	BegBal,
	PtdBal00,
	YtdBal00,
	PtdCon00

)
Select
	AcctHist.Acct,
	AcctHist.Sub,
	AcctHist.CpnyID,
	AcctHist.CuryID,
	AcctHist.FiscYr,
	AcctHist.LedgerID,
	AcctHist.BalanceType,
	AcctHist.BdgtRvsnDate,
	AcctHist.LastClosePerNbr,
	AcctHist.YTDBal11,
	AcctHist.BegBal,
	AcctHist.PtdBal00,
	AcctHist.YTDBal00,
	AcctHist.PtdCon00
from  AcctHist
where 	AcctHist.CpnyID LIKE '%'
        and AcctHist.Acct = @YTDNetIncAcct
	and AcctHist.Sub LIKE '%'
	and AcctHist.LedgerID LIKE '%'
	and AcctHist.FiscYr = @fisc_year
	and AcctHist.LastClosePerNbr <> @pernbr
order by  AcctHist.CpnyID,
	AcctHist.FiscYr,
	AcctHist.Acct,
	AcctHist.Sub,
	AcctHist.LedgerId

IF @@error<>0
  Goto BAD_EXIT

exec(
"Update  #AcctHist
set YTDBal11 = b." + @YearEndFiscPer + "
From #AcctHist a, AcctHist b
Where a.CpnyID = b.CpnyID
	And   a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.FiscYr   = b.FiscYr")

IF @@error<>0
  Goto BAD_EXIT

Update #AcctHist
	set BalanceType = b.BalanceType,
	    BaseCuryID = b.BaseCuryID
From #AcctHist a, Ledger b
Where a.Ledgerid = b.Ledgerid

IF @@error<>0
  Goto BAD_EXIT

While (1=1)
Begin
	select top 1 @iid=iid,
		@CpnyID = CpnyID,
		@Acct = Acct,
		@Sub = Sub,
		@LedgerID = LedgerID,
		@CuryID = CuryID
	from #AcctHist
	where iid>@iid
	order by iid
		if @@rowcount = 0
	 break

	Select
		@BegBal = Isnull(AcctHist.BegBal,0.0),
		@YTDBal00 = Isnull(AcctHist.YTDBal00,0.0),
                @CuryId = CuryId
	from  AcctHist
	where AcctHist.CpnyID =  @CpnyID
		and AcctHist.Acct =  @RetEarnAcct
		and AcctHist.Sub =  @Sub
		and AcctHist.LedgerID =  @LedgerID
		and AcctHist.FiscYr =  @nextfiscyr
	order by AcctHist.CpnyID,
		AcctHist.FiscYr,
		AcctHist.Acct,
		AcctHist.Sub,
		AcctHist.LedgerID

	if @@rowcount = 0
	 continue

	Select @BaseCuryId = BaseCuryId,
               @basecuryprec = DecPl
	From Ledger, Currncy
	Where  BaseCuryId = CuryId
	     and LedgerId = @LedgerId

        select @curyprec = DecPl From Currncy Where CuryId = @CuryId

	update #AcctHist
	set updated = 1,
            BegBal = Round(YTDBal11 + @BegBal,@basecuryprec),
            YTDBal00 = Round(YTDBal11 + @YTDBal00,@basecuryprec)
	where iid = @iid

	IF @@error<>0
	  Goto BAD_EXIT

End

INSERT into AcctHist
	(Acct, AnnBdgt, AnnMemo1, BalanceType, BdgtRvsnDate, BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryId, DistType, FiscYr, LastClosePerNbr, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
	PtdAlloc00, PtdAlloc01, PtdAlloc02, PtdAlloc03, PtdAlloc04, PtdAlloc05, PtdAlloc06, PtdAlloc07,
	PtdAlloc08, PtdAlloc09, PtdAlloc10, PtdAlloc11, PtdAlloc12, PtdBal00, PtdBal01, PtdBal02, PtdBal03,
	PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09, PtdBal10, PtdBal11, PtdBal12, PtdCon00,
	PtdCon01, PtdCon02, PtdCon03, PtdCon04, PtdCon05, PtdCon06, PtdCon07, PtdCon08, PtdCon09, PtdCon10,
	PtdCon11, PtdCon12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, SpreadSheetType, Sub, User1, User2, User3,
        User4, User5, User6, User7, User8, YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05, YtdBal06,
        YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11, YtdBal12, YTDEstimated)
select
	@RetEarnAcct, '', '', BalanceType, @today, YTDBal11, CpnyID, cast(getdate() as smalldatetime), '01560', @user_name, CuryId, '', @nextfiscyr, @pernbr,
	LedgerID, cast(getdate() as smalldatetime), '01560', @user_name, '', '', '', '', 	'', '', '', '', '', '', '', '', '', '', 0.0, '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', Sub, '', '', '', '', '', '', '', '', YTDBal11, '', '', '',
        '', '', '', '', '', '', '', '', '', ''
From #AcctHist a
where a.updated = 0

IF @@error<>0
  Goto BAD_EXIT

Update AcctHist
Set BegBal = b.BegBal,
    YTDBal00 = b.YTDBal00,
    PtdBal00 = 0.0,
    LUpd_DateTime = cast(getdate() as smalldatetime),
    LUpd_Prog = '01560',
    LUpd_User = @user_name
From  AcctHist a, #AcctHist b
Where a.CpnyID = b.CpnyID
        And   a.acct = @RetEarnAcct
        And   b.acct = @YTDNetIncAcct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   a.FiscYr = @nextfiscyr
        And   a.BalanceType <> 'B'
        And   b.BalanceType <> 'B'
        And   b.updated = 1

IF @@error<>0
  Goto BAD_EXIT

Update AcctHist
Set LastClosePerNbr = @pernbr,
    LUpd_Prog = '01560'
From   AcctHist, Account
Where (AcctHist.FiscYr =  @fisc_year )
	and AcctHist.Acct = Account.Acct
	and AcctHist.BalanceType <> 'B'
	and (LastClosePerNbr <>  @pernbr )
	and (Account.AcctType like '' or account.AcctType like  '_A%'  or account.AcctType like '_L%'  )
	and (AcctHist.YTDBal11 <> 0.00)

IF @@error<>0
  Goto BAD_EXIT

drop table #AcctHist

return 0

BAD_EXIT:
If isnull(object_id('tempdb..#AcctHist'),0) <> 0
  drop table #AcctHist
return -1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Close_year] TO [MSDSL]
    AS [dbo];

