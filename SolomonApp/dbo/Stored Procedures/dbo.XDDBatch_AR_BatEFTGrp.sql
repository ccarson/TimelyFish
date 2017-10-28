
CREATE PROCEDURE XDDBatch_AR_BatEFTGrp
  	@BatNbr		varchar( 10 ),
	@BatSeq		smallint
AS

	Declare	@HighEFTGrp	smallint
	
	SET @HighEFTGrp = 0
	
	-- If @HighEFGGrp is found, then use it
	SELECT TOP 1	@HighEFTGrp = BatEFTGrp
	FROM		XDDBatch (nolock)
	WHERE		Module = 'AR'
			and FileType IN ('R', 'X')
			and BatNbr = @BatNbr
			and BatSeq = @BatSeq
			and (KeepDelete = '' or KeepDelete IN ('N', 'P', 'F', 'T'))
	ORDER BY	BatEFTGrp DESC

	-- No Records found that have not been processed
	if @HighEFTGrp = 0
	BEGIN
		SELECT TOP 1	@HighEFTGrp = BatEFTGrp
		FROM		XDDBatch (nolock)
		WHERE		Module = 'AR'
				and FileType IN ('R', 'X')
				and BatNbr = @BatNbr
				and BatSeq = @BatSeq
		ORDER BY	BatEFTGrp DESC
	
		-- >= 1 then found a record - but completely processed - return next Sequence
		if @HighEFTGrp >= 1 
			SET @HighEFTGrp = -(@HighEFTGrp + 1)
	END	
	
	-- New XDDBatchAREFT can be created if negative number is returned
	-- Return	0	- No XDDBatch yet or no AREFTs against the batch
	-- Return	1-n	- Highest number that has not been fully processed (number to use)
	-- Return	-(1-n)	- Highest number has been fully processed, returns Next number to use

	-- New Grp if:
	--	No XDDBatch yet				0
	--	XDDBatch, but all are completed		-)1-n)
	
	SELECT @HighEFTGrp
