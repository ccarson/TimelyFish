
CREATE VIEW [QQ_vendor]
AS
SELECT  
     VendId AS [Vendor ID], CASE WHEN CHARINDEX('~', Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(Name, 1, CHARINDEX('~', Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX('~', Name) + 1, 60)))) ELSE Name END AS [Vendor Name], 
     Vend1099 AS [1099 Vendor], Addr1 AS [Address 1], Addr2 AS [Address2], City, Zip AS [Zip Code], State, Attn AS [Attention],
     '(' + SUBSTRING(Phone, 1, 3) + ')' + SUBSTRING(Phone,4,3) + '-' + RTRIM(SUBSTRING(Phone,7,24)) AS [Phone Number], 
     '(' + SUBSTRING(Fax, 1, 3) + ')' + SUBSTRING(Fax,4,3) + '-' + RTRIM(SUBSTRING(Fax,7,24)) AS [Fax Number], APAcct AS [A/P Account], APSub AS [A/P Subaccount],  
     ClassID, ContTwc1099 AS [TIN/Name Reported Incorrectly], Country, convert(date,Crtd_DateTime) AS [Create Date], Crtd_Prog AS [Create Program], 
     Crtd_User AS [Create User], Curr1099Yr AS [Current 1099 Year], CuryId AS [Currency ID], CuryRateType AS [Currency Rate Type], DfltBox AS [Default 1099 Box], 
     DfltOrdFromId AS [Default Purchase Order Address], DfltPurchaseType AS [Default Purchase Type],  DocPublishingFlag AS [Document Publishing Flag], 
     EMailAddr AS [Email Address], ExcludeFreight, ExpAcct AS [Expense Account], ExpSub AS [Expense Subaccount], LCCode AS [Landed Cost Code], 
     convert(date,LUpd_DateTime) AS [Last Update Date], LUpd_Prog AS [Last Update Program], LUpd_User AS [Last Update User], MultiChk AS [Multiple Check], 
     Next1099Yr AS [Next 1099 Year], NoteID, PayDateDflt AS [Default Pay Date], PerNbr AS [Period Number], PmtMethod AS [Payment Method], 
     PPayAcct AS [Prepayment Account], PPaySub AS [Prepayment Subaccount], RcptPctAct AS [Receipt Percent Action], RcptPctMax AS [Maximum Percent], 
     RcptPctMin AS [Minimum Percent], RemitAddr1 AS [Remittance Address 1], RemitAddr2 AS [Remittance Address 2], RemitAttn AS [Remittance Attention], 
     RemitCity AS [Remittance City], RemitCountry AS [Remittance Country], 
     '(' + SUBSTRING(RemitFax, 1, 3) + ')' + SUBSTRING(RemitFax,4,3) + '-' + RTRIM(SUBSTRING(RemitFax,7,24)) AS [Remittance Fax Number], 
     CASE WHEN CHARINDEX('~', RemitName) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(RemitName, 1, CHARINDEX('~', RemitName) - 1)) + ', ' + 
     LTRIM(RTRIM(SUBSTRING(RemitName, CHARINDEX('~', RemitName) + 1, 60)))) ELSE RemitName END AS [Remittance Name], 
     '(' + SUBSTRING(RemitPhone, 1, 3) + ')' + SUBSTRING(RemitPhone,4,3) + '-' + RTRIM(SUBSTRING(RemitPhone,7,24)) AS [Remittance Phone Number], 
     RemitSalut AS [Remittance Salutation], RemitState AS [Remittance State], RemitZip AS [Remittance Zip Code], Salut AS [Salutation], Status, 
     TaxDflt AS [Tax Default], TaxId00, TaxId01, TaxId02, TaxId03, TaxLocId AS [Tax Location ID], TaxPost, TaxRegNbr AS [Tax Registration Number], Terms, 
     TIN AS [Taxpayer Identification Number], User1, User2, User3, User4, User5, User6, convert(date,User7) AS [User7], convert(date,User8) AS [User8]
FROM   vendor with (nolock)
        
