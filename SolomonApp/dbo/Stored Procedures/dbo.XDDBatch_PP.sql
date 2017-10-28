
CREATE PROCEDURE XDDBatch_PP
	@AP		smallint,
	@APVoid		smallint,
  	@APPerPost	varchar(6),
	@PR		smallint,
	@PRVoid		smallint,
  	@PRPerPost	varchar(6),
  	@IncludePosted	smallint,
  	@WdPosted	varchar(8),
  	@WdUnPosted	varchar(8),
  	@TopRecOnly	smallint
AS

	declare	@BaseCuryPrec	float

	-- Get the base currency precision
	SELECT	@BaseCuryPrec = c.DecPl
	FROM	GLSetup s (nolock),
		Currncy c (nolock)
	WHERE	s.BaseCuryID = c.CuryID

	-- The order of the fields is important - it matches the app's buffer layout
	CREATE TABLE #TempTableOut
	(	Selected    		char (1)	NOT NULL,
		Module			char (2)	NOT NULL,
		EditScrnNbr		char (5)	NOT NULL,
		BatNbr			char (10)	NOT NULL,
		PerPost			char (6)	NOT NULL,
		CpnyID			char (10)	NOT NULL,
		DepDate			smalldatetime	NOT NULL,
		SLBatTotal		float		NOT NULL,
		Status			char (8)	NOT NULL,
		Acct			char (10)	NOT NULL,
		Sub			char (24)	NOT NULL,
		KeepDelete		char (1)	NOT NULL,
		FormatID		char (15)	NOT NULL,
		ComputerName		char (30)	NOT NULL,
		FileType		char (1)	NOT NULL,
		EBFileNbr		char ( 6 )	NOT NULL,
		PmtBatTotal		float		NOT NULL
	)

	if @AP = 1 or @APVoid = 1
	BEGIN
		INSERT		INTO #TempTableOut
	  	Select Distinct	'N',
	  			B.Module,
	  			B.EditScrnNbr,
	  			B.BatNbr,
	  			B.PerPost,
	  			B.CpnyID,
	  			case when X.DepDate IS NULL
					then convert(smalldatetime, '1/1/1900')
					else X.DepDate
					end,
	  			B.CuryCtrlTot,
	  			case when B.Status = 'P'
	  				then @WdPosted
	  				else @WdUnPosted
	  				end,
	  			case when @TopRecOnly = 1
	  				then Coalesce(X.Acct, '')	-- this will show if XDDBatch record exists
	  				else Coalesce(A.Acct, '')
	  				end,		
	  			case when @TopRecOnly = 1
	  				then Coalesce(X.Sub, '')
	  				else Coalesce(A.Sub, '')
	  				end,
	  			case when X.BatNbr IS NULL
	  				then ''
	  				else X.KeepDelete
	  				end,
				case when X.Batnbr IS NOT NULL and X.KeepDelete IN ('T', 'K', 'C')
					then X.FormatID 		-- if XDDBatch and not transmitted - use XDDBatch.FormatID
					else coalesce(K.PPFormatID, '')	--
					end,
	  			case when X.SKFuture01 IS NULL		-- ComputerName
					then ''
					else X.SKFuture01
					end,
				coalesce(X.FileType, ''),
				coalesce(X.EBFileNbr, ''),
				coalesce((Select Sum(round(APDoc.CuryOrigDocAmt, @BaseCuryPrec)) FROM APDoc (nolock) WHERE APDoc.BatNbr = B.BatNbr and APDoc.DocType IN ('CK', 'HC') and APDoc.Status <> 'V'), 0)
	  	FROM 		Batch B (nolock) LEFT OUTER JOIN XDDBatch X (nolock)
	  			ON 'AP' = X.Module and B.BatNbr = X.BatNbr LEFT OUTER JOIN APDoc A (nolock)
	  			ON B.BatNbr = A.BatNbr LEFT OUTER JOIN XDDBank K (nolock)
				ON A.CpnyID = K.CpnyID and A.Acct = K.Acct and A.Sub = K.Sub
	  	Where		B.Module = 'AP'
	  			and 	(	(@IncludePosted = 0 and B.Status = 'U') or
	  					(@IncludePosted = 1 and B.Status IN ('U', 'P'))
	  				)
	  			and	(	(@APVoid = 0 and @AP = 1 and B.EditScrnNbr IN ('03620', '03030')) or		-- Computer, Manual
	  					(@APVoid = 1 and @AP = 0 and B.EditScrnNbr IN ('03040'))          or		-- Void only
	  					(@APVoid = 1 and @AP = 1 and B.EditScrnNbr IN ('03620', '03030', '03040'))	-- Both
	  				)
	  			and B.PerPost >= @APPerPost
	  			and B.OrigScrnNbr <> 'DD520'	-- EFT/Wire batches
				and K.PPFormatID Is Not Null	-- don't include Acct/Subs that are not setup
				and K.PPFormatID <> ''
				and ((X.FileType IS NOT NULL and X.FileType = 'P') or X.FileType IS NULL)  
	END

	if @PR = 1 or @PRVoid = 1
	BEGIN
		INSERT		INTO #TempTableOut
	  	Select Distinct	'N',
	  			B.Module,
	  			B.EditScrnNbr,
	  			B.BatNbr,
	  			B.PerPost,
	  			B.CpnyID,
	  			case when X.DepDate IS NULL
					then convert(smalldatetime, '1/1/1900')
					else X.DepDate
					end,
	  			B.CuryCtrlTot,
	  			case when B.Status = 'P'
	  				then @WdPosted
	  				else @WdUnPosted
	  				end,
	  			case when @TopRecOnly = 1
	  				then Coalesce(X.Acct, '')	-- this will show if XDDBatch record exists
	  				else Coalesce(P.Acct, '')
	  				end,		
	  			case when @TopRecOnly = 1
	  				then Coalesce(X.Sub, '')
	  				else Coalesce(P.Sub, '')
	  				end,
	  			case when X.BatNbr IS NULL
	  				then ''
	  				else X.KeepDelete
	  				end,
				case when X.Batnbr IS NOT NULL and X.KeepDelete IN ('T', 'K', 'C')
					then X.FormatID 		-- if XDDBatch and not transmitted - use XDDBatch.FormatID
					else coalesce(K.PPFormatID, '')	--
					end,
	  			case when X.SKFuture01 IS NULL		-- ComputerName
					then ''
					else X.SKFuture01
					end,
				coalesce(X.FileType, ''),	
				coalesce(X.EBFileNbr, ''),
				coalesce((Select Sum(round(PRDoc.NetAmt, @BaseCuryPrec)) FROM PRDoc (nolock) WHERE PRDoc.BatNbr = B.BatNbr), 0)
	  	FROM 		Batch B (nolock) LEFT OUTER JOIN XDDBatch X (nolock)
	  			ON 'PR' = X.Module and B.BatNbr = X.BatNbr LEFT OUTER JOIN PRDoc P (nolock)
	  			ON B.BatNbr = P.BatNbr and B.Module = 'PR' LEFT OUTER JOIN XDDBank K (nolock)
				ON P.CpnyID = K.CpnyID and P.Acct = K.Acct and P.Sub = K.Sub
	  	Where		B.Module = 'PR'
	  			and 	(	(@IncludePosted = 0 and B.Status = 'U') or
	  					(@IncludePosted = 1 and B.Status IN ('U', 'P'))
	  				)
	  			and	(	(@PRVoid = 0 and @PR = 1 and B.EditScrnNbr IN ('02630', '02040', '02080')) or	-- Computer, Manual, Net
	  					(@PRVoid = 1 and @PR = 0 and B.EditScrnNbr IN ('02070'))                   or	-- Void only
	  					(@PRVoid = 1 and @PR = 1 and B.EditScrnNbr IN ('02630', '02040', '02080', '02070')) -- Both
	  				)
	  			and B.PerPost >= @PRPerPost
				and K.PPFormatID Is Not Null	-- don't include Acct/Subs that are not setup
				and K.PPFormatID <> ''
				and ((X.FileType IS NOT NULL and X.FileType = 'P') or X.FileType IS NULL)  
	END

	if @TopRecOnly = 1
		SELECT TOP 1 * FROM #TempTableOut ORDER BY Module, BatNbr DESC
	else
		SELECT * FROM #TempTableOut ORDER BY Module, BatNbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_PP] TO [MSDSL]
    AS [dbo];

