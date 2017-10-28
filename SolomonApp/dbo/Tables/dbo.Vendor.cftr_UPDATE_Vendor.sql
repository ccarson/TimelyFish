

-- =============================================
-- Author:		Matt Dawson
-- Create date: 12/9/2008
-- Description:	replicate data over to cfapp_cornpurch
-- =============================================
CREATE TRIGGER [dbo].[cftr_UPDATE_Vendor]
   ON  [dbo].[Vendor]
with execute as '07718158D19D4f5f9D23B55DBF5DF1'
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
UPDATE CFApp_CornPurch.dbo.cft_Vendor
SET	[Addr1] = substring(u.[Addr1],1,30)
           ,[Addr2] = substring(u.[Addr2],1,30)
           ,[APAcct] = u.[APAcct]
           ,[APSub] = u.[APSub]
           ,[Attn] = u.[Attn]
           ,[BkupWthld] = u.[BkupWthld]
           ,[City] = u.[City]
           ,[ClassID] = u.[ClassID]
           ,[ContTwc1099] = u.[ContTwc1099]
           ,[Country] = u.[Country]
           ,[Crtd_DateTime] = u.[Crtd_DateTime]
           ,[Crtd_Prog] = u.[Crtd_Prog]
           ,[Crtd_User] = u.[Crtd_User]
           ,[Curr1099Yr] = u.[Curr1099Yr]
           ,[CuryId] = u.[CuryId]
           ,[CuryRateType] = u.[CuryRateType]
           ,[DfltBox] = u.[DfltBox]
           ,[DfltOrdFromId] = u.[DfltOrdFromId]
           ,[DfltPurchaseType] = u.[DfltPurchaseType]
           ,[DirectDeposit] = u.[DirectDeposit]
           ,[EMailAddr] = substring(u.[EMailAddr],1,30)
           ,[ExpAcct] = u.[ExpAcct]
           ,[ExpSub] = u.[ExpSub]
           ,[Fax] = u.[Fax]
           ,[LCCode] = u.[LCCode]
           ,[LUpd_DateTime] = u.[LUpd_DateTime]
           ,[LUpd_Prog] = u.[LUpd_Prog]
           ,[LUpd_User] = u.[LUpd_User]
           ,[MultiChk] = u.[MultiChk]
           ,[Name] = substring(u.[Name],1,30)
           ,[Next1099Yr] = u.[Next1099Yr]
           ,[NoteID] = u.[NoteID]
           ,[PayDateDflt] = u.[PayDateDflt]
           ,[PerNbr] = u.[PerNbr]
           ,[Phone] = u.[Phone]
           ,[PmtMethod] = u.[PmtMethod]
           ,[PPayAcct] = u.[PPayAcct]
           ,[PPaySub] = u.[PPaySub]
           ,[RcptPctAct] = u.[RcptPctAct]
           ,[RcptPctMax] = u.[RcptPctMax]
           ,[RcptPctMin] = u.[RcptPctMin]
           ,[RemitAddr1] = substring(u.[RemitAddr1],1,30)
           ,[RemitAddr2] = substring(u.[RemitAddr2],1,30)
           ,[RemitAttn] = u.[RemitAttn]
           ,[RemitCity] = u.[RemitCity]
           ,[RemitCountry] = u.[RemitCountry]
           ,[RemitFax] = u.[RemitFax]
           ,[RemitName] = substring(u.[RemitName],1,30)
           ,[RemitPhone] = u.[RemitPhone]
           ,[RemitSalut] = u.[RemitSalut]
           ,[RemitState] = u.[RemitState]
           ,[RemitZip] = u.[RemitZip]
           ,[S4Future01] = u.[S4Future01]
           ,[S4Future02] = u.[S4Future02]
           ,[S4Future03] = u.[S4Future03]
           ,[S4Future04] = u.[S4Future04]
           ,[S4Future05] = u.[S4Future05]
           ,[S4Future06] = u.[S4Future06]
           ,[S4Future07] = u.[S4Future07]
           ,[S4Future08] = u.[S4Future08]
           ,[S4Future09] = u.[S4Future09]
           ,[S4Future10] = u.[S4Future10]
           ,[S4Future11] = u.[S4Future11]
           ,[S4Future12] = u.[S4Future12]
           ,[Salut] = u.[Salut]
           ,[State] = u.[State]
           ,[Status] = u.[Status]
           ,[TaxDflt] = u.[TaxDflt]
           ,[TaxId00] = u.[TaxId00]
           ,[TaxId01] = u.[TaxId01]
           ,[TaxId02] = u.[TaxId02]
           ,[TaxId03] = u.[TaxId03]
           ,[TaxLocId] = u.[TaxLocId]
           ,[TaxPost] = u.[TaxPost]
           ,[TaxRegNbr] = u.[TaxRegNbr]
           ,[Terms] = u.[Terms]
           ,[TIN] = u.[TIN]
           ,[User1] = u.[User1]
           ,[User2] = u.[User2]
           ,[User3] = u.[User3]
           ,[User4] = u.[User4]
           ,[User5] = u.[User5]
           ,[User6] = u.[User6]
           ,[User7] = u.[User7]
           ,[User8] = u.[User8]
           ,[Vend1099] = u.[Vend1099]
           ,[Zip] = u.[Zip]
FROM CFApp_CornPurch.dbo.cft_Vendor v
JOIN Inserted u on RTRIM(u.VendID) = RTRIM(v.VendID)

END


