
CREATE PROCEDURE XDDAPDoc_Details_Count_Approve
   @EBFileNbr		varchar( 6 ),
   @FileType		varchar( 1 )

AS

	declare @Lvl1Amt		float
	declare @Lvl1Approved		smallint
	declare @Lvl1Cnt		smallint
	declare @Lvl1NbrApprovers	smallint
	declare @Lvl2Amt		float
	declare @Lvl2Approved		smallint
	declare @Lvl2Cnt		smallint
	declare @Lvl2NbrApprovers	smallint
		
	-- Number of Documents at each Level
	SET @Lvl1Cnt = 0
	SET @Lvl2Cnt = 0

	SELECT	@Lvl1Amt = APAmtAppLvl1Amt,
		@Lvl1NbrApprovers = APAmtAppLvl1NbrA
	FROM	XDDSetupEx (nolock)

	SELECT	@Lvl2Amt = APAmtAppLvl2Amt,
		@Lvl2NbrApprovers = APAmtAppLvl2NbrA
	FROM	XDDSetupEx (nolock)

	-- -----------------------------------------------------------
	-- -----------------------------------------------------------
	-- DETERMINE NUMBER OF APPROVAL DOCUMENTS AT EACH LEVEL
	-- -----------------------------------------------------------
	-- -----------------------------------------------------------
	if @Lvl1Amt > 0
	BEGIN
		-- All documents over Level 1 are included, even if they are over Level 2 as well
		SELECT	@Lvl1Cnt = count(*)
		FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN APDoc C (nolock)
			ON XB.BatNbr = C.BatNbr
		WHERE	XF.EBFileNbr = @EBFileNbr
			and XF.FileType = @FileType
			and C.Status <> 'V'
			and C.CuryOrigDocAmt >= @Lvl1Amt
	END
			
	if @Lvl2Amt > 0
	BEGIN
		SELECT	@Lvl2Cnt = count(*)
		FROM	XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
			ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN APDoc C (nolock)
			ON XB.BatNbr = C.BatNbr
		WHERE	XF.EBFileNbr = @EBFileNbr
			and XF.FileType = @FileType
			and C.Status <> 'V'
			and C.CuryOrigDocAmt >= @Lvl2Amt
	END

	-- -----------------------------------------------------------
	-- -----------------------------------------------------------
	-- REVIEW XDDEBFILE USERs/PWs and XDDUSER TO SEE IF OK
	-- -----------------------------------------------------------
	-- -----------------------------------------------------------
	-- ----------------------------------------------------------------------------
	-- REVIEW XDDEBFILE 
	-- ...NApproved = 0  (No approvals required)
	-- ...NApproved = NN (where NN is number of approvals still required 1-5)
	-- ...NApproved = -1 (All approvals entered and OK)

	SET @Lvl1Approved = 0
	SET @Lvl2Approved = 0

   	-- LvlApproved (Number Approved)
	-- 	0  (No approvals required)
	-- 	NN (where NN is number of approvals still required 1-5)
	-- 	-1 (All approvals entered and OK)

	-- Only need to check on approvals if any documents at Level 2 require approval
	if @Lvl2Cnt > 0
	BEGIN

		-- Pass EBFileNbr
		--	Number of the Level
		--	Number of Approvers required for the level
		--	Number of Approvals remaining
		EXEC XDDAPDoc_Details_Approvals @EBFileNbr, @FileType, 2, @Lvl2NbrApprovers, @Lvl2Approved OUTPUT
	
	END

	if @Lvl1Cnt > 0
	BEGIN

		-- Pass EBFileNbr
		--	Number of the Level
		--	Number of Approvers required for the level
		--	Number of Approvals remaining
		EXEC XDDAPDoc_Details_Approvals @EBFileNbr, @FileType, 1, @Lvl1NbrApprovers, @Lvl1Approved OUTPUT
	
	END

	SELECT @Lvl1Cnt, @Lvl2Cnt, @Lvl1Approved, @Lvl2Approved
