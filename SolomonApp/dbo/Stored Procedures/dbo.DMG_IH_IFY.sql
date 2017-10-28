 CREATE PROCEDURE DMG_IH_IFY
	@RIID	smallint
AS

	DECLARE @FiscYr     	Integer
	DECLARE @MinFiscYr	Integer
	DECLARE @MaxFiscYr	Integer
	DECLARE @PrevFiscYr     Integer
    	DECLARE @PerNbr         VARCHAR (6)
	DECLARE @ProgId 	VARCHAR (8)
	DECLARE @UserId 	VARCHAR (10)         -- User_Name
	DECLARE @BaseDecPl	SmallInt
	DECLARE @BMIDecPl 	SmallInt
	DECLARE @DecPlPrcCst 	SmallInt
	DECLARE @DecPlQty 	SmallInt
	DECLARE @INPerNbr	Integer

	SELECT 	@ProgID = 'INRPTS'
	SELECT  @UserID = 'INRPTS'
		SELECT	@BaseDecPl = BaseDecPl,
		@BMIDecPl = BMIDecPl,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
		FROM vp_DecPl

	SELECT	@MinFiscYr = Min(Cast(Left(PerPost, 4) As Integer)) from intran WHERE PerPost <> ''
	SELECT	@MaxFiscYr = Max(Cast(Left(PerPost, 4) As Integer)) from intran WHERE PerPost <> ''
	SELECT	@INPerNbr = Cast(Left(PerNbr, 4) as Integer) from INSetup

	If @MinFiscYr < @InPerNbr - 5
		SELECT @MinFiscYr = @InPerNbr - 5

	If @MaxFiscYr > @InPerNbr + 5
		SELECT @MaxFiscYr = @InPerNbr + 5

	SELECT	@FiscYr = @MinFiscYr


	-------------------------------------------------------------------
	-- Insert any missing ItemHist, Item2Hist and ItemBMIHist records
	-------------------------------------------------------------------

	While	(@FiscYr <= @MaxFiscYr)
	BEGIN

		If @FiscYr = (SELECT Cast(Left(PerNbr, 4) As Integer) from INSetup)
			SELECT @PerNbr = PerNbr from INSetup
		Else
			SELECT @PerNbr = ''

		-- Insert any ItemHist records for each InvtID / SiteID combination for
		-- the current fiscal year if it is missing.
	      	INSERT	ItemHist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
                             LUpd_DateTime, LUpd_Prog, LUpd_User, PerNbr, SiteId)
                	SELECT	GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
	                        GetDate(), @ProgId, @UserId, @PerNbr,S.SiteId
        	       	FROM 	ItemSite S Left Outer JOIN ItemHist H
                		  ON S.InvtId = H.InvtId
                     		  AND S.SiteId = H.SiteId
	                	  AND @FiscYr = H.FiscYr
	          	WHERE 	H.InvtId Is NULL

		-- Insert any Item2Hist records for each InvtID / SiteID combination for
		-- the current fiscal year if it is missing.
	      	INSERT	Item2Hist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
                             LUpd_DateTime, LUpd_Prog, LUpd_User, SiteId)
                	SELECT	GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
	                        GetDate(), @ProgId, @UserId, S.SiteId
        	       	FROM 	ItemSite S Left Outer JOIN Item2Hist H
                		  ON S.InvtId = H.InvtId
                     		  AND S.SiteId = H.SiteId
	                	  AND @FiscYr = H.FiscYr
	          	WHERE 	H.InvtId Is NULL

		-- Insert any ItemBMIHist records for each InvtID / SiteID combination for
		-- the current fiscal year if it is missing.
	      	INSERT	ItemBMIHist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
                             LUpd_DateTime, LUpd_Prog, LUpd_User, SiteId)
                	SELECT	GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
	                        GetDate(), @ProgId, @UserId, S.SiteId
        	       	FROM 	ItemSite S Left Outer JOIN ItemBMIHist H
                		  ON S.InvtId = H.InvtId
                     		  AND S.SiteId = H.SiteId
	                	  AND @FiscYr = H.FiscYr
	          	WHERE 	H.InvtId Is NULL

		Set	@FiscYr = @FiscYr + 1
		END

	-------------------------------------------------------------------
	-- Update the BegBal for the ItemHist, Item2Hist and ItemBMIHist records
	-------------------------------------------------------------------
	Exec SCM_10400_Upd_History_BegBal @ProgId, @UserId, @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IH_IFY] TO [MSDSL]
    AS [dbo];

