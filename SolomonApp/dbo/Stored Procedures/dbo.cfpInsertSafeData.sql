
CREATE PROCEDURE [dbo].[cfpInsertSafeData]
	@FileName varchar(100)
AS
-------------------------------------------
--	FEED
-------------------------------------------
IF UPPER(LEFT(LTRIM(@FileName),1)) = 'F'
BEGIN
	INSERT INTO cftSafeFeed (BinInv,BinNbr,CallDate,CallTime,Company,DateReq,Manager,Phase,PigGroupID,QtyOrd,SDRefNo,SiteID,SiteRoom,Statusflg,SysDate)
	SELECT	DISTINCT 0 'BinInv'
	,	CAST(SUBSTRING(SafeDataRawImportText,12,3) AS INT) 'BinNbr'
	,	SUBSTRING(SafeDataRawImportText,15,8) 'CallDate'
	,	SUBSTRING(SafeDataRawImportText,23,5) 'CallTime'
	,	' ' 'Company'
	,	SUBSTRING(SafeDataRawImportText,28,8) 'DateReq'
	,	' ' 'Manager'
	,	CAST(CASE WHEN SUBSTRING(SafeDataRawImportText,46,1) = ''
			THEN 	'99'
			ELSE	SUBSTRING(SafeDataRawImportText,46,1)
		END AS SMALLINT) 'Phase'
	,	RIGHT(REPLICATE('0',5) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,5))),5) 'PigGroupID'
	,	CAST(SUBSTRING(SafeDataRawImportText,42,4) AS INT) 'QtyOrd'
	,	SUBSTRING(SafeDataRawImportText,36,6) 'SDRefNo'
	,	RIGHT(REPLICATE('0',4) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,6,4))),4) 'SiteID'
	,	SUBSTRING(SafeDataRawImportText,10,2) 'SiteRoom'
	,	'O' 'Statusflg'
	,	SUBSTRING(SafeDataRawImportText,15,8) 'SysDate'
	FROM cftSafeDataRawImport (NOLOCK)
	WHERE LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,11))) NOT LIKE 'No Records'
END

-------------------------------------------
--	MORTALITY
-------------------------------------------
IF UPPER(LEFT(LTRIM(@FileName),1)) = 'M'
BEGIN
	INSERT INTO cftSafeMort (CallDate,CallTime,CurrInv,PigGroupID,Qty,SDRefNo,SiteID,SiteRoom,Statusflg,SubType,TranDate,Type)
	SELECT	DISTINCT SUBSTRING(SafeDataRawImportText,31,8) 'CallDate'
	,	SUBSTRING(SafeDataRawImportText,39,5) 'CallTime'
	,	CAST(RTRIM(SUBSTRING(SafeDataRawImportText,44,5)) AS INT) 'CurrInv'
	,	RIGHT(REPLICATE('0',5) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,5))),5) 'PigGroupID'
	,	CAST(SUBSTRING(SafeDataRawImportText,20,4) AS INT) 'Qty'
	,	SUBSTRING(SafeDataRawImportText,25,6) 'SDRefNo'
	,	RIGHT(REPLICATE('0',4) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,6,4))),4) 'SiteID'
	,	SUBSTRING(SafeDataRawImportText,10,2) 'SiteRoom'
	,	'O' 'Statusflg'
	,	SUBSTRING(SafeDataRawImportText,24,1) 'SubType'
	,	SUBSTRING(SafeDataRawImportText,12,8) 'TranDate'
	,	1 'Type'
	FROM cftSafeDataRawImport (NOLOCK)
	WHERE LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,11))) NOT LIKE 'No Records'
END

-------------------------------------------
--	BIN
-------------------------------------------
IF UPPER(LEFT(LTRIM(@FileName),1)) = 'B'
BEGIN
	INSERT INTO cftBinReading (BinNbr,BinReadingDate,Crtd_Date,Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,NoteID,SiteContactID,Tons)
	SELECT	DISTINCT CAST(CASE WHEN LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,7,3))) = ''
			THEN
				COALESCE(cftBin.BinNbr,'000')
			ELSE
				SUBSTRING(SafeDataRawImportText,7,3)
		END AS INT) 'BinNbr'
	,	CAST('20' 
		+ SUBSTRING(SafeDataRawImportText,10,2) + '-' 
		+ SUBSTRING(SafeDataRawImportText,12,2) + '-' 
		+ SUBSTRING(SafeDataRawImportText,14,2) + ' ' 
		+ SUBSTRING(SafeDataRawImportText,16,5) AS SMALLDATETIME) 'BinReadingDate'
	,	GETDATE() 'Crtd_Date'
	,	GETDATE() 'Crtd_DateTime'
	,	'SAFEDATA' 'Crtd_Prog'
	,	SUBSTRING(SafeDataRawImportText,21,6) 'Crtd_User'
	,	GETDATE() 'Lupd_DateTime'
	,	'SAFEDATA' 'Lupd_Prog'
	,	SUBSTRING(SafeDataRawImportText,21,6) 'Lupd_User'
	,	0 'NoteID'
	,	cftSite.ContactID 'SiteContactID'
	,	CAST(SUBSTRING(SafeDataRawImportText,27,2) AS FLOAT) 'Tons'
	FROM cftSafeDataRawImport (NOLOCK)
	LEFT OUTER JOIN cftSite cftSite (NOLOCK)
		ON RIGHT(REPLICATE('0',4) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,4))),4) = cftSite.SiteID
	LEFT OUTER JOIN cftBin cftBin (NOLOCK)
		ON cftBin.ContactID = cftSite.ContactID
		AND cftBin.BinNbr = RIGHT(REPLICATE('0',3) + LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,7,3))),3)
	WHERE LTRIM(RTRIM(SUBSTRING(SafeDataRawImportText,1,11))) NOT LIKE 'No Records'

	--Updates BinNbr for 0 barns
	UPDATE cftBinReading
	SET BinNbr = Bin.BinNbr
	FROM cftBinReading BinReading
	JOIN cftBin Bin
		ON Bin.ContactID = BinReading.SiteContactID
		AND RIGHT('000000' + RTRIM(Bin.BinNbr),6) = RIGHT('000000' + RTRIM(BinReading.BinNbr),6)
	WHERE RTRIM(Bin.BinNbr) <> RTRIM(BinReading.BinNbr)
	AND RTRIM(Bin.BinNbr) LIKE '0%'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfpInsertSafeData] TO [SE\ssis_datawriter]
    AS [dbo];

