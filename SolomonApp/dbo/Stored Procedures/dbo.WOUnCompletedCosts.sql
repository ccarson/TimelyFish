 Create Proc WOUnCompletedCosts
	@WONbr		varchar( 16 ),
	@Task		varchar( 32 )

AS

	Set NoCount ON
		Declare
	@TotalCost	Float,
	@ComplCost	Float,
	@UncomplCost	Float,
	@BaseCury	SmallInt,
	@Acct		varchar( 16 ),
	@CompAcct	varchar( 16 )

	-- Get the base currency precision
	SELECT	@BaseCury = c.DecPl
	FROM	GLSetup s (NOLOCK),
		Currncy c (NOLOCK)
	WHERE	s.BaseCuryID = c.CuryID

   	DECLARE         XRef_Cursor CURSOR LOCAL
   	FOR
   	SELECT          Acct, Acct_Comp
   	FROM            WOAcctCategXRef (NOLOCK)

	Select @UnComplCost = 0

	if (@@error <> 0) GOTO ABORT

	Open XRef_Cursor
	Fetch Next From XRef_Cursor Into @Acct, @CompAcct
	While (@@Fetch_Status = 0)
	BEGIN

		if @Task = ''

			BEGIN
			Select 		@TotalCost = Coalesce( Sum ( Round(Act_Amount, @BaseCury) ), 0)
			FROM		PJPTDROL (NOLOCK)
			WHERE		Project = @WONbr
					and Acct = @Acct
			Select 		@ComplCost = Coalesce( Sum ( Round(Act_Amount, @BaseCury) ), 0)
			FROM		PJPTDROL (NOLOCK)
			WHERE		Project = @WONbr
					and Acct = @CompAcct
			END

		else

			BEGIN
			Select 		@TotalCost = Coalesce( Sum ( Round(Act_Amount, @BaseCury) ), 0)
			FROM		PJPTDSUM (NOLOCK)
			WHERE		Project = @WONbr
					and PJT_Entity = @Task
					and Acct = @Acct
			Select 		@ComplCost = Coalesce( Sum ( Round(Act_Amount, @BaseCury) ), 0)
			FROM		PJPTDSUM (NOLOCK)
			WHERE		Project = @WONbr
					and PJT_Entity = @Task
					and Acct = @CompAcct
			END

		Select @UncomplCost = Round( @UncomplCost + (@TotalCost - @ComplCost), @BaseCury)

		Fetch Next From XRef_Cursor Into @Acct, @CompAcct

	END

	Close XRef_Cursor
	Deallocate XRef_Cursor

	Select Coalesce( Round( @UncomplCost, @BaseCury), 0)
ABORT:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOUnCompletedCosts] TO [MSDSL]
    AS [dbo];

