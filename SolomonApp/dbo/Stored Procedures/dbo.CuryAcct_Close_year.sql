 CREATE proc CuryAcct_Close_year @cpnyid varchar(10), @fisc_year varchar(4), @user_name varchar(47)
as
set nocount on
set quoted_identifier off
declare @acct varchar(10),
        @sub varchar(24),
        @nextfiscyr varchar(4),
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
	@CuryYearEndFiscPer varchar(15),
        @pernbr varchar(6)

select  @ledgerid = '',
        @balancetype = '',
        @basecuryID = '',
        @curyID = '',
        @begbal = 0.0,
        @curybegbal = 0.0,
	@YTDBal00 = 0.0,
	@CuryYTDBal00=0.0,
	@iid = 0,
	@RetEarnAcct ='',
	@YTDNetIncAcct ='',
        @basecuryprec= 0,
        @curyprec=0

select @nextfiscyr = cast((cast(@fisc_year as int) + 1) as varchar)
SELECT @YTDNetIncAcct = YTDNetIncAcct, @RetEarnAcct = RetEarnAcct, @pernbr = PerNbr, @YearEndFiscPer = 'YTDBal' + CASE len(NbrPer-1) WHEN 1 THEN '0' + cast(NbrPer-1 as varchar) ELSE  cast(NbrPer-1 as varchar) END From glsetup (NOLOCK)
SELECT @CuryYearEndFiscPer = 'Cury' + @YearEndFiscPer

create table #CuryAcct
(	iid int not null Identity(1,1) Primary key,
	CpnyID               varchar (10),
	Acct                 varchar (10),
	Sub                  varchar (24),
	LedgerID             varchar (10),
	FiscYr               varchar (4),
	CuryId               varchar (4),
	YtdBal11             float NULL,
	CuryYtdBal11         float NULL,
	BegBal               float NULL,
	CuryBegBal           float NULL,
	PtdBal00             float NULL,
	CuryPtdBal00         float NULL,
	YtdBal00             float NULL,
	CuryYtdBal00         float NULL,
	BalanceType	     char(1) NULL,
	BaseCuryID	     varchar(4) NULL,
        updated              smallint Default 0
)IF @@error<>0
  Goto BAD_EXIT

Create unique nonclustered index #temp_ind_CuryAcct on #CuryAcct (CpnyID, Acct, Sub, LedgerID, FiscYr, CuryId)

IF @@error<>0
  Goto BAD_EXIT

exec ("
INSERT #CuryAcct
(	CpnyID,
	Acct,
	Sub,
	LedgerID,
	FiscYr,
	CuryID,
	YTDBal11,
	CuryYTDBal11,
	BegBal,
	CuryBegBal,
	PtdBal00,
	CuryPtdBal00,
	YTDBal00,
	CuryYTDBal00

)
Select
	CuryAcct.CpnyID,
	CuryAcct.Acct,
	CuryAcct.Sub,
	CuryAcct.LedgerID,
	CuryAcct.FiscYr,
	CuryAcct.CuryID,
	CuryAcct.YTDBal11,
	CuryAcct.CuryYTDBal11,
	CuryAcct.BegBal,
	CuryAcct.CuryBegBal,
	CuryAcct.PtdBal00,
	CuryAcct.CuryPtdBal00,
	CuryAcct.YTDBal00,
	CuryAcct.CuryYTDBal00
from   CuryAcct, Account
where
        CuryAcct.Acct = Account.Acct
	and (CuryAcct.FiscYr = '" + @fisc_year + "')
	and (Account.AcctType like '' or account.AcctType like  '_A%'  or account.AcctType like '_L%'  )
	and (CuryAcct.Acct <> '" + @YTDNetIncAcct + "')
	and (CuryAcct." + @YearEndFiscPer + "  <> 0.00)
order by  CuryAcct.Acct,
	CuryAcct.Sub,
	CuryAcct.LedgerId,
	CuryAcct.FiscYr"
)IF @@error<>0
  Goto BAD_EXIT

exec(
"Update  #CuryAcct
set YTDBal11 = b." + @YearEndFiscPer + ",
    CuryYTDBal11 = b." + @CuryYearEndFiscPer +"
From #CuryAcct a, CuryAcct b
Where a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   a.FiscYr   = b.FiscYr
        And   a.CpnyID = b.CpnyID")

Update #CuryAcct
	set updated = 1
From #CuryAcct a, CuryAcct b
Where a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   b.FiscYr = @nextfiscyr
	And   a.CpnyID = b.CpnyID

IF @@error<>0
  Goto BAD_EXIT

Update #CuryAcct
	set updated = 99
From #CuryAcct a
Where Not Exists
(Select 1 From Account b Where a.Acct = b.Acct)

IF @@error<>0
  Goto BAD_EXIT

If isnull(object_id('tempdb..#tt'),0) <> 0
Begin
	Insert #tt(acct, tab_name) Select acct, 'CuryAcct' From CuryAcct a Where Not Exists
		(Select 1 From Account b Where a.Acct = b.Acct) and Not Exists
		(Select 1 From #tt b Where a.Acct = b.Acct)

  If @@error<>0
    Goto BAD_EXIT
End

Update #CuryAcct
	set BalanceType = b.BalanceType,
	    BaseCuryID = b.BaseCuryID
From #CuryAcct a, Ledger b
Where a.Ledgerid = b.Ledgerid

IF @@error<>0
  Goto BAD_EXIT

insert into CuryAcct
	(Acct, BalanceType, BaseCuryID, BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryBegBal,
	CuryId, CuryPtdBal00, CuryPtdBal01, CuryPtdBal02, CuryPtdBal03, CuryPtdBal04, CuryPtdBal05,
	CuryPtdBal06, CuryPtdBal07, CuryPtdBal08, CuryPtdBal09, CuryPtdBal10, CuryPtdBal11,
	CuryPtdBal12, CuryYtdBal00, CuryYtdBal01, CuryYtdBal02, CuryYtdBal03, CuryYtdBal04,
	CuryYtdBal05, CuryYtdBal06, CuryYtdBal07, CuryYtdBal08, CuryYtdBal09, CuryYtdBal10,
	CuryYtdBal11, CuryYtdBal12, FiscYr, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
	PtdBal00, PtdBal01, PtdBal02, PtdBal03, PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09,
	PtdBal10, PtdBal11, PtdBal12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, Sub, User1,
	User2, User3, User4, User5, User6, User7, User8, YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04,
	YtdBal05, YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11, YtdBal12)
select
	Acct, BalanceType, BaseCuryID, YTDBal11, CpnyID, cast(getdate() as smalldatetime), '01560', @user_name, CuryYTDBal11, CuryId,
	CAST(0.0 as float), '', '', '', '', '', '', '', '', '', '', '', '', CuryYTDBal11, '', '', '', '', '', '', '', '', '', '', '',
	'', @nextFiscYr, LedgerID, cast(getdate() as smalldatetime), '01560', '', '', CAST(0.0 as float), '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
	'', '', '', '', '', '', '', '', '', Sub, '', '', '', '', '', '', '', '', YTDBal11, '', '', '', '', '', '', '', '', '', '',
	'', ''
From #CuryAcct a
where a.updated = 0

IF @@error<>0
  Goto BAD_EXIT

update CuryAcct
set BegBal = b.YTDBal11,
    PtdBal00 = 0.0,
    YTDBal00 = b.YTDBal11,
    CuryBegBal = b.CuryYtdBal11,
    CuryPtdBal00 = 0.0,
    CuryYTDBal00 = b.CuryYtdBal11,
    LUpd_DateTime = cast(getdate() as smalldatetime),
    LUpd_Prog = '01560'
From CuryAcct a, #CuryAcct b
Where a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   a.FiscYr = @nextfiscyr
	And   a.CpnyId = b.CpnyId
        And   b.updated = 1

IF @@error<>0
  Goto BAD_EXIT

Truncate table #CuryAcct

IF @@error<>0
  Goto BAD_EXIT

INSERT #CuryAcct
(	CpnyID,
	Acct,
	Sub,
	LedgerID,
	FiscYr,
	CuryID,
	YTDBal11,
	CuryYTDBal11,
	BegBal,
	CuryBegBal,
	PtdBal00,
	CuryPtdBal00,
	YTDBal00,
	CuryYTDBal00

)
Select
	CuryAcct.CpnyID,
	CuryAcct.Acct,
	CuryAcct.Sub,
	CuryAcct.LedgerID,
	CuryAcct.FiscYr,
	CuryAcct.CuryID,
	CuryAcct.YTDBal11,
	CuryAcct.CuryYTDBal11,
	CuryAcct.BegBal,
	CuryAcct.CuryBegBal,
	CuryAcct.PtdBal00,
	CuryAcct.CuryPtdBal00,
	CuryAcct.YTDBal00,
	CuryAcct.CuryYTDBal00
from  CuryAcct
where CuryAcct.Acct = @YTDNetIncAcct
	and CuryAcct.Sub LIKE '%'
	and CuryAcct.LedgerID LIKE '%'
	and CuryAcct.CuryID LIKE '%'
	and CuryAcct.FiscYr = @fisc_year
order by  CuryAcct.Acct,
	CuryAcct.Sub,
	CuryAcct.LedgerId,
	CuryAcct.FiscYr

IF @@error<>0
  Goto BAD_EXIT

exec(
"Update  #CuryAcct
set YTDBal11 = b." + @YearEndFiscPer + ",
    CuryYTDBal11 = b." + @CuryYearEndFiscPer +"
From #CuryAcct a, CuryAcct b
Where a.acct = b.acct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   a.FiscYr   = b.FiscYr
	And   a.CpnyId   = b.CpnyId")

IF @@error<>0
  Goto BAD_EXIT

Update #CuryAcct
	set BalanceType = b.BalanceType,
	    BaseCuryID = b.BaseCuryID
From #CuryAcct a, Ledger b
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
	from #CuryAcct
	where iid>@iid
	order by iid
		if @@rowcount = 0
	 break

	Select
		@BegBal = Isnull(CuryAcct.BegBal,0.0),
		@CuryBegBal = Isnull(CuryAcct.CuryBegBal,0.0),
		@YTDBal00 = Isnull(CuryAcct.YTDBal00,0.0),
		@CuryYTDBal00 = Isnull(CuryAcct.CuryYTDBal00,0.0)
	from  CuryAcct
	where CuryAcct.CpnyID =  @CpnyID
		and CuryAcct.Acct =  @RetEarnAcct
		and CuryAcct.Sub =  @Sub
		and CuryAcct.LedgerID =  @LedgerID
		and CuryAcct.FiscYr =  @nextfiscyr
		and CuryAcct.CuryID =  @CuryID
	order by CuryAcct.FiscYr,
		CuryAcct.Acct,
		CuryAcct.Sub,
		CuryAcct.LedgerID

	if @@rowcount = 0
	 continue

	Select @BaseCuryId = BaseCuryId,
               @basecuryprec = DecPl
	From Ledger, Currncy
	Where  BaseCuryId = CuryId
	     and LedgerId = @LedgerId

        select @curyprec = DecPl From Currncy Where CuryId = @CuryId

	update #CuryAcct
	set updated = 1,
            BegBal = Round(YTDBal11 + @BegBal,@basecuryprec),
            YTDBal00 = Round(YTDBal11 + @YTDBal00,@basecuryprec),
            CuryBegBal = Round(CuryYTDBal11 + @CuryBegBal,@curyprec),
	    CuryYTDBal00 = Round(CuryYTDBal11 + @CuryYTDBal00, @curyprec)
	where iid = @iid

	IF @@error<>0
	  Goto BAD_EXIT

End

insert into CuryAcct
	(Acct, BalanceType, BaseCuryID, BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryBegBal,
	CuryId, CuryPtdBal00, CuryPtdBal01, CuryPtdBal02, CuryPtdBal03, CuryPtdBal04, CuryPtdBal05,
	CuryPtdBal06, CuryPtdBal07, CuryPtdBal08, CuryPtdBal09, CuryPtdBal10, CuryPtdBal11,
	CuryPtdBal12, CuryYtdBal00, CuryYtdBal01, CuryYtdBal02, CuryYtdBal03, CuryYtdBal04,
	CuryYtdBal05, CuryYtdBal06, CuryYtdBal07, CuryYtdBal08, CuryYtdBal09, CuryYtdBal10,
	CuryYtdBal11, CuryYtdBal12, FiscYr, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
	PtdBal00, PtdBal01, PtdBal02, PtdBal03, PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09,
	PtdBal10, PtdBal11, PtdBal12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, Sub, User1,
	User2, User3, User4, User5, User6, User7, User8, YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04,
	YtdBal05, YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11, YtdBal12)
select
	@RetEarnAcct, BalanceType, BaseCuryID, YTDBal11, CpnyID, cast(getdate() as smalldatetime), '01560', @user_name, CuryYTDBal11, CuryId,
	CAST(0.0 as float), '', '', '', '', '', '', '', '', '', '', '', '', CuryYTDBal11, '', '', '', '', '', '', '', '', '', '', '',
	'', @nextFiscYr, LedgerID, cast(getdate() as smalldatetime), '01560', '', '', CAST(0.0 as float), '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
	'', '', '', '', '', '', '', '', '', Sub, '', '', '', '', '', '', '', '', YTDBal11, '', '', '', '', '', '', '', '', '', '',
	'', ''
From #CuryAcct a
where a.updated = 0

IF @@error<>0
  Goto BAD_EXIT

Update CuryAcct
Set BegBal = b.BegBal,
    CuryBegBal = b.CuryBegBal,
    YTDBal00 = b.YTDBal00,
    CuryYTDBal00 = b.CuryYTDBal00,
    LUpd_DateTime = cast(getdate() as smalldatetime),
    LUpd_Prog = '01560'
From  CuryAcct a, #CuryAcct b
Where a.acct = @RetEarnAcct
        And   b.acct = @YTDNetIncAcct
	And   a.sub = b.sub
	And   a.Ledgerid = b.LedgerId
	And   a.CuryId   = b.CuryId
	And   a.FiscYr = @nextfiscyr
    	And   a.CpnyId = b.CpnyId
        And   b.updated = 1

IF @@error<>0
  Goto BAD_EXIT

drop table #CuryAcct
return 0

BAD_EXIT:

If isnull(object_id('tempdb..#CuryAcct'),0) <> 0
  drop table #CuryAcct

return -1


