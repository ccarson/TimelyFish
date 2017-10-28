 CREATE PROCEDURE DMG_CheckMissingHistoryRecords
	@RIID	smallint
AS

	DECLARE @FiscYr     		Integer
	DECLARE @TmpFiscYr		Integer
	DECLARE @MinFiscYr		Integer
	DECLARE @MaxFiscYr		Integer
	DECLARE @PrevFiscYr     	Integer
	DECLARE @INPerNbr		Integer
	DECLARE	@ItemHistCount		Integer
	DECLARE @Item2HistCount 	Integer
	DECLARE @ItemBMIHistCount 	Integer
	DECLARE @HistRecMissing		SmallInt
		SELECT	@MinFiscYr = Cast(Left(BegPerNbr, 4) As Integer) from RptRuntime WHERE RI_ID = @RIID
	SELECT	@MaxFiscYr = Cast(Left(EndPerNbr, 4) As Integer) from RptRuntime WHERE RI_ID = @RIID
	SELECT	@INPerNbr = Cast(Left(PerNbr, 4) as Integer) from INSetup

	If @MinFiscYr < @InPerNbr - 5
		SELECT @MinFiscYr = @InPerNbr - 5

	If @MaxFiscYr > @InPerNbr + 5
		SELECT @MaxFiscYr = @InPerNbr + 5

	SELECT	@FiscYr = @MinFiscYr

	SELECT @HistRecMissing = 0

	CREATE TABLE #RangeFiscYrs(FiscYr INT)
	SELECT @TmpFiscYr = @MinFiscYr
		WHILE @TmpFiscYr <= @MaxFiscYr
	BEGIN
		INSERT INTO #RangeFiscYrs VALUES (@TmpFiscYr)
		SELECT @TmpFiscYr = @TmpFiscYr +1
	END

	SELECT @HistRecMissing = count(*)
		FROM 	Inventory
			Inner Join InventoryADG
			On Inventory.InvtID = InventoryADG.InvtID
			Inner Join ItemSite
			On Inventory.InvtID = ItemSite.InvtID
			Inner Join Site
			On ItemSite.SiteID = Site.SiteID
			Cross Join #RangeFiscYrs
			Left Join ItemHist
			On ItemSite.InvtID = ItemHist.InvtID
			And ItemSite.SiteID = ItemHist.SiteID
			And #RangeFiscYrs.FiscYr = ItemHist.FiscYr
			Left Join Item2Hist
			On ItemHist.InvtID = Item2Hist.InvtID
			And ItemHist.SiteID = Item2Hist.SiteID
			And ItemHist.FiscYr = Item2Hist.FiscYr
			Left Join ItemBMIHist
			On ItemHist.InvtID = ItemBMIHist.InvtID
			And ItemHist.SiteID = ItemBMIHist.SiteID
			And ItemHist.FiscYr = ItemBMIHist.FiscYr
		WHERE
			(ItemHist.InvtID IS NULL OR
			Item2Hist.InvtID IS NULL OR
			ItemBMIHist.InvtID IS NULL) AND
			exists(select * from INTran where
				INTran.InvtID=ItemSite.InvtID
				And INTran.SiteID =ItemSite.SiteID
				And Cast(Left(INTran.PerPost, 4) as Integer) = #RangeFiscYrs.FiscYr
				And INTran.Rlsed = 1
				And INTran.S4Future05 = 0)

	SELECT @HistRecMissing

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


