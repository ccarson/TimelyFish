
create procedure XDDDispTranDetails
	@Module			varchar( 2 ),
	@MsgLayout		varchar( 1 ),
	@TranOption		varchar( 1 ),
	@ChkRefNbr		varchar( 10 ),
	@VchRefNbr		varchar( 10 ),
	@Indent			varchar( 30 ),
	@TranUser1 		varchar( 30 ),
	@TranUser2 		varchar( 30 ),
	@TranUser3 		varchar( 30 ),
	@TranUser4 		varchar( 30 ),
	@TranUser5 		varchar( 30 ),
	@TranUser6 		varchar( 30 ),
	@TranUser7 		varchar( 30 ),
	@TranUser8 		varchar( 30 )

AS

	declare @AnyRecs		bit
	declare @DetailLine		varchar( 500 )
	declare @DetAcctDescr		varchar( 30 )
	declare @DetCuryTranAmt		float
	declare @DetTranDescr		varchar( 30 )
	declare @DetUser1		varchar( 30 )
	declare @DetUser2		varchar( 30 )	
	declare @DetUser3		float	
	declare @DetUser4		float	
	declare @DetUser5		varchar( 10 )	
	declare @DetUser6		varchar( 10 )
	declare @DetUser7		smalldatetime	
	declare @DetUser8		smalldatetime
	declare @LineFull		varchar( 510 )

	if @Module = 'AR'
	BEGIN
		-- Cursor thru AR Tran
		DECLARE         Tran_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT	T.Trandesc, A.Descr,
			case when T.trantype = 'CM'
				then -T.curytranamt
				else T.curytranamt
				end,
			T.User1, T.User2, T.User3, T.User4, T.User5, T.User6, T.User7, T.User8	
		FROM	ARTran T (nolock) LEFT OUTER JOIN ARDoc D (nolock)
			ON T.BatNbr = D.BatNbr and T.RefNbr = D.RefNbr
			LEFT OUTER JOIN Account A (nolock)
			ON T.Acct = A.Acct
		WHERE	((T.trantype IN ('IN', 'DM') and T.drcr = 'C') or
			(T.trantype = 'CM' and T.drcr = 'D'))
			and T.Refnbr = @ChkRefNbr
			and T.CuryTranAmt > 0
		ORDER BY	T.LineNbr
	END

	else

	BEGIN
		-- Cursor thru AP Tran
		DECLARE         Tran_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT		T.Trandesc, A.Descr,
				case when T.trantype = 'AD'
					then -T.curytranamt
					else T.curytranamt
					end,
				T.User1, T.User2, T.User3, T.User4, T.User5, T.User6, T.User7, T.User8	
		FROM		APTran T (nolock) LEFT OUTER JOIN APDoc D (nolock)
				ON T.BatNbr = D.BatNbr and T.RefNbr = D.RefNbr
				LEFT OUTER JOIN Account A (nolock)
				ON T.Acct = A.Acct
		WHERE		((T.trantype IN ('VO', 'AC') and T.drcr = 'D') or
				(T.trantype = 'AD' and T.drcr = 'C'))
				and T.Refnbr = @VchRefNbr
		ORDER BY	T.LineNbr
	END

	if (@@error <> 0) GOTO ABORT

	OPEN Tran_Cursor

	SET @AnyRecs = 0
	Fetch Next From Tran_Cursor into
	@DetTranDescr,
	@DetAcctDescr,
	@DetCuryTranAmt,
	@DetUser1,
	@DetUser2,	
	@DetUser3,	
	@DetUser4,	
	@DetUser5,	
	@DetUser6,	
	@DetUser7,	
	@DetUser8
	
	-- Loop thru all checkes/invoices for a vendor/customer
	While (@@Fetch_Status = 0)
	BEGIN

		if @DetCuryTranAmt <> 0
		BEGIN
			SET @DetailLine = ''
			
			-- Tran Description
			if @TranOption = 'T'
				SET @DetailLine = @DetailLine + rtrim(@DetTranDescr)
			else
				SET @DetailLine = @DetailLine + rtrim(@DetAcctDescr)
	
			-- Amount
			SET @DetailLine = @DetailLine + ': ' + convert(varchar,cast(@DetCuryTranAmt as Money), 1)
	
			-- User1 (char)
			if rtrim(@TranUser1) <> '' and rtrim(@DetUser1) <> ''
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser1) + ': ' + rtrim(@DetUser1)
	
			-- User2 (char)
			if rtrim(@TranUser2) <> '' and rtrim(@DetUser2) <> ''
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser2) + ': ' + rtrim(@DetUser2)
	
			-- User3 (float)
			if rtrim(@TranUser3) <> '' and @DetUser3 <> 0
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser3) + ': ' + str(@DetUser3)
				
			-- User4 (float)
			if rtrim(@TranUser4) <> '' and @DetUser4 <> 0
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser4) + ': ' + str(@DetUser4)
	
			-- User5 (char)
			if rtrim(@TranUser5) <> '' and rtrim(@DetUser5) <> ''
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser5) + ': ' + rtrim(@DetUser5)
	
			-- User6 (char)
			if rtrim(@TranUser6) <> '' and rtrim(@DetUser6) <> ''
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser6) + ': ' + rtrim(@DetUser6)
	
			-- User7 (date)
			if rtrim(@TranUser7) <> '' and @DetUser7 <> 0
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser7) + ': ' + convert(varchar, @DetUser7, 101)
	
			-- User8 (date)
			if rtrim(@TranUser8) <> '' and @DetUser8 <> 0
				SET @DetailLine = @DetailLine + ', ' + rtrim(@TranUser8) + ': ' + convert(varchar, @DetUser8, 101)
			
			SET @LineFull = @Indent + @DetailLine
			EXEC XDDEmail_Insert @LineFull

			SET @AnyRecs = 1

		END
		
		Fetch Next From Tran_Cursor into
		@DetTranDescr,
		@DetAcctDescr,
		@DetCuryTranAmt,
		@DetUser1,
		@DetUser2,	
		@DetUser3,	
		@DetUser4,	
		@DetUser5,	
		@DetUser6,	
		@DetUser7,	
		@DetUser8
	END

ABORT: 	
	
	Close Tran_Cursor
	DeAllocate Tran_Cursor
	
	-- If Horizontal and some details were found - add extra blank line
	if @AnyRecs = 1 and @MsgLayout = 'H'
	BEGIN
		SET @LineFull = ' '
		EXEC XDDEmail_Insert @LineFull
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDispTranDetails] TO [MSDSL]
    AS [dbo];

