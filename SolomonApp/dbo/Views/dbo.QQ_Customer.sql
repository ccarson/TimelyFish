
CREATE VIEW [QQ_Customer]
AS
SELECT	
     CustId AS [Customer ID],  CASE WHEN CHARINDEX('~', Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(Name, 1, CHARINDEX('~', Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX('~', Name) + 1, 60)))) ELSE Name END AS [Customer Name], 
     Addr1 AS [Address Line 1], Addr2 As [Address Line 2],
     City, State, Zip AS [Zip Code],Attn AS [Attention],
     '(' + SUBSTRING(Phone, 1, 3) + ')' + SUBSTRING(Phone,4,3) + '-' + RTRIM(SUBSTRING(Phone,7,24)) AS [Phone Number], 
     Status, ClassId AS [Customer Class ID], StmtCycleId AS [Statement Cycle ID], 
     ArAcct AS [A/R Account], ArSub AS [A/R Subaccount],  
     ApplFinChrg AS [Apply Finance Charges], AccrRevAcct AS [Accrued Revenue Account], AccrRevSub AS [Accrued Revenue Subaccount],   
     AutoApply AS [Auto Apply Payments], BankID, BillAddr1 AS [Billing Address Line 1], BillAddr2 AS [Billing Address Line 2], BillAttn AS [Billing Attention Line], 
     BillCity AS [Billing City], BillCountry AS [Billing Country], BillFax AS [Billing Fax Number],  CASE WHEN CHARINDEX('~', BillName) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(BillName, 1, CHARINDEX('~', BillName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(BillName, CHARINDEX('~', BillName) + 1, 60)))) ELSE BillName END AS [Billing Name], 
     '(' + SUBSTRING(BillPhone, 1, 3) + ')' + SUBSTRING(BillPhone,4,3) + '-' + RTRIM(SUBSTRING(BillPhone,7,24)) AS [Billing Phone], 
     BillSalut AS [Billing Salutation], BillState AS [Billing State], BillZip AS [Billing Zip Code], convert(date,CardExpDate) AS [Card Expiration Date], 
     CardHldrName AS [Card Holder Name], CardNbr AS [Card Number], CardType,  
     ConsolInv As [Consolidate Invoices], Country, CrLmt AS [Credit Limit], convert(date,Crtd_DateTime) AS [Create Date], Crtd_Prog AS [Create Program], 
     Crtd_User AS [Create User], CuryId AS [Currency ID], CuryPrcLvlRtTp AS [Currency Price Level Rate Type], CuryRateType AS [Currency Rate Type], CustFillPriority AS [Customer Priority], 
     DfltShipToId AS [Default Shipping Address ID], DocPublishingFlag AS [Publish Documents], DunMsg AS [Dunning Message], EMailAddr AS [Email Address], 
     '(' + SUBSTRING(Fax, 1, 3) + ')' + SUBSTRING(Fax,4,3) + '-' + RTRIM(SUBSTRING(Fax,7,24)) AS [Fax Number], 
     LanguageID, convert(date,LUpd_DateTime) AS [Last Update Date], LUpd_Prog AS [Last Update Program], 
     LUpd_User AS [Last Update User], NoteId, OneDraft, PerNbr AS [Period Number], 
     PmtMethod AS [Payment Method], PrcLvlId AS [Price Level ID], PrePayAcct AS [Prepayment Account], PrePaySub AS [Prepayment Subaccount], 
     PriceClassID, PrtMCStmt AS [Print Multi Currency Statements], PrtStmt AS [Print Statements],  
     Salut AS [Customer Salutation], convert(date,SetupDate) AS [SetupDate], ShipCmplt AS [Ship Complete],  
     SingleInvoice, SlsAcct AS [Sales Account], SlsperId AS [Sales Person ID], 
     SlsSub AS [Sales Subaccount], StmtType As [Statement Type], 
     TaxDflt AS [Tax Default], TaxExemptNbr AS [Tax Exemption Number], TaxID00, TaxID01, TaxID02, 
     TaxID03, TaxLocId AS [Tax Location ID], TaxRegNbr AS [Tax ID Number], Terms, Territory, 
     TradeDisc AS [Trade Discount], User1, User2, User3, User4, 
     User5, User6, convert(date,User7) AS [User7], convert(date,User8) AS [User8]
FROM	Customer with (nolock)

