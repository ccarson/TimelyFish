
CREATE PROCEDURE XDDAPDoc_Details_Approvals
   @EBFileNbr		varchar( 6 ),
   @FileType		varchar( 1 ),
   @AppLvl		smallint,	-- 1 or 2
   @NbrApprovers	smallint,
   @LvlApproved		smallint OUTPUT

AS

	declare @Approver		varchar( 47 )
	declare @PW			varchar( 15 )
	declare @UserPW			varchar( 15 )
	
   -- LvlApproved (Number Approved)
	-- 0  (No approvals required - this case will not occur here - routine will not be called if no Approvals reqquired - for this level)
	-- NN (where NN is number of approvals still required 1-5)
	-- -1 (All approvals entered and OK)

	SET @LvlApproved = 0	
			
	-- Now check depending on Number of Approvers required
	-- Check Level 5
	if @NbrApprovers = 5
	BEGIN
		SET	@Approver = ''
		SET	@PW = ''
		SET	@UserPW = ''
					
		if @AppLvl = 2
		BEGIN		
			-- XDDEBFILE - Number 5 (E) User/PW			
			SELECT	@Approver = AmtApprvLvl2_E_User,
				@PW       = AmtApprvLvl2_E_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 2 Approver
			SELECT 	@UserPW = AmtAppLvl2PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl2 = 1
		END
		else
		BEGIN
			-- XDDEBFILE - Number 5 (E) User/PW			
			SELECT	@Approver = AmtApprvLvl1_E_User,
				@PW       = AmtApprvLvl1_E_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 1 Approver
			SELECT 	@UserPW = AmtAppLvl1PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl1 = 1
		END			

		If @Approver = '' or @PW = '' or @UserPW = ''	
			SET @LvlApproved = @LvlApproved + 1
		else
		BEGIN
			-- Approver/PW & User PW has been entered - now let's see if it's valid	
			if convert(varbinary, rtrim(@PW)) <> convert(varbinary, rtrim(@UserPW))
				SET @LvlApproved = @LvlApproved + 1
		END		
	END

	-- Check Level 4
	if @NbrApprovers >= 4
	BEGIN
		SET	@Approver = ''
		SET	@PW = ''
		SET	@UserPW = ''

		if @AppLvl = 2
		BEGIN		
			-- XDDEBFILE - Number 4 (D) User/PW			
			SELECT	@Approver = AmtApprvLvl2_D_User,
				@PW       = AmtApprvLvl2_D_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 2 Approver
			SELECT 	@UserPW = AmtAppLvl2PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl2 = 1
		END
		else
		BEGIN
			-- XDDEBFILE - Number 4 (D) User/PW			
			SELECT	@Approver = AmtApprvLvl1_D_User,
				@PW       = AmtApprvLvl1_D_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 1 Approver
			SELECT 	@UserPW = AmtAppLvl1PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl1 = 1
		END			
			
		If @Approver = '' or @PW = '' or @UserPW = ''	
			SET @LvlApproved = @LvlApproved + 1
		else
		BEGIN
			-- Approver/PW & User PW has been entered - now let's see if it's valid	
			if convert(varbinary, rtrim(@PW)) <> convert(varbinary, rtrim(@UserPW))
				SET @LvlApproved = @LvlApproved + 1
		END		
	END

	-- Check Level 3
	if @NbrApprovers >= 3
	BEGIN
		SET	@Approver = ''
		SET	@PW = ''
		SET	@UserPW = ''

		if @AppLvl = 2
		BEGIN		
			-- XDDEBFILE - Number 3 (C) User/PW			
			SELECT	@Approver = AmtApprvLvl2_C_User,
				@PW       = AmtApprvLvl2_C_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 2 Approver
			SELECT 	@UserPW = AmtAppLvl2PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl2 = 1
		END
		else
		BEGIN
			-- XDDEBFILE - Number 3 (C) User/PW			
			SELECT	@Approver = AmtApprvLvl1_C_User,
				@PW       = AmtApprvLvl1_C_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 1 Approver
			SELECT 	@UserPW = AmtAppLvl1PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl1 = 1
		END			
			
		If @Approver = '' or @PW = '' or @UserPW = ''	
			SET @LvlApproved = @LvlApproved + 1
		else
		BEGIN
			-- Approver/PW & User PW has been entered - now let's see if it's valid	
			if convert(varbinary, rtrim(@PW)) <> convert(varbinary, rtrim(@UserPW))
				SET @LvlApproved = @LvlApproved + 1
		END		
	END

	-- Check Level 2
	if @NbrApprovers >= 2
	BEGIN
		SET	@Approver = ''
		SET	@PW = ''
		SET	@UserPW = ''

		if @AppLvl = 2
		BEGIN		
			-- XDDEBFILE - Number 2 (B) User/PW			
			SELECT	@Approver = AmtApprvLvl2_B_User,
				@PW       = AmtApprvLvl2_B_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 2 Approver
			SELECT 	@UserPW = AmtAppLvl2PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl2 = 1
		END
		else
		BEGIN
			-- XDDEBFILE - Number 2 (B) User/PW			
			SELECT	@Approver = AmtApprvLvl1_B_User,
				@PW       = AmtApprvLvl1_B_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 1 Approver
			SELECT 	@UserPW = AmtAppLvl1PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl1 = 1
		END			
			
		If @Approver = '' or @PW = '' or @UserPW = ''	
			SET @LvlApproved = @LvlApproved + 1
		else
		BEGIN
			-- Approver/PW & User PW has been entered - now let's see if it's valid	
			if convert(varbinary, rtrim(@PW)) <> convert(varbinary, rtrim(@UserPW))
				SET @LvlApproved = @LvlApproved + 1
		END		
	END

	-- Check Level 1
	if @NbrApprovers >= 1
	BEGIN
		SET	@Approver = ''
		SET	@PW = ''
		SET	@UserPW = ''

		if @AppLvl = 2
		BEGIN		
			-- XDDEBFILE - Number 1 (A) User/PW			
			SELECT	@Approver = AmtApprvLvl2_A_User,
				@PW       = AmtApprvLvl2_A_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 2 Approver
			SELECT 	@UserPW = AmtAppLvl2PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl2 = 1
		END
		else
		BEGIN
			-- XDDEBFILE - Number 1 (A) User/PW			
			SELECT	@Approver = AmtApprvLvl1_A_User,
				@PW       = AmtApprvLvl1_A_PW
			FROM	XDDEBFile (nolock)
			WHERE	EBFileNbr = @EBFileNbr
				and FileType = @FileType
		
			-- XDDUSER - Must be in User Table and Marked as a Level 1 Approver
			SELECT 	@UserPW = AmtAppLvl1PW
			FROM	XDDUser (nolock)
			WHERE	UserID = @Approver
				and AmtAppLvl1 = 1
		END			
			
		If @Approver = '' or @PW = '' or @UserPW = ''	
			SET @LvlApproved = @LvlApproved + 1
		else
		BEGIN
			-- Approver/PW & User PW has been entered - now let's see if it's valid	
			if convert(varbinary, rtrim(@PW)) <> convert(varbinary, rtrim(@UserPW))
				SET @LvlApproved = @LvlApproved + 1
		END		
	END

	-- All levels that needed to be approved have been checked and none remain
	-- therefore set the OUTPUT var to -1
	
	if @LvlApproved = 0	SET @LvlApproved = -1
