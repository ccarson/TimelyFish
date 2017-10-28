
CREATE PROCEDURE XDDMCB_Batch_Update
	@BatNbr		    varchar( 10 )

AS

    Declare @BaseCuryPrec     smallint
    Declare @BatchCuryPrec    smallint

   	-- Total APDocs to Batch   	
   	-- First check to be sure we have some APDocs in this batch
	if Exists(Select * FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr)
	BEGIN
		-- Get the base currency precision
		SELECT	@BaseCuryPrec = c.DecPl
		FROM	GLSetup s (NOLOCK),
			    Currncy c (NOLOCK)
		WHERE	s.BaseCuryID = c.CuryID
	
	   -- Get the batch currency precision
	   SELECT	@BatchCuryPrec = c.DecPl
	   FROM		Batch B left outer join Currncy c (nolock)
				ON B.CuryID = C.CuryID
	   WHERE	B.Module = 'AP'
				and B.BatNbr = @BatNBr

	   UPDATE	Batch
	   SET		CrTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
			    CtrlTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
			    CuryCrTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BatchCuryPrec),
			    CuryCtrlTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BatchCuryPrec),
			    CuryDepositAmt = 0,
			    CuryDrTot = 0	
	   WHERE	Module = 'AP'
			    and BatNbr = @BatNbr
	END
	
	else
	
	BEGIN
		-- All APDocs have been deleted
		DELETE FROM Batch Where BatNbr = @BatNbr and Module = 'AP'
	END
	
	Select * from Batch (nolock) Where BatNbr = @BatNbr and Module = 'AP'
	
