

--*************************************************************
--	Purpose: Pig Group Packer Certification
--	Author: Sue Matter
--	Date: 5/12/2006
--	Usage: Packer Certification Report
--	Parms: 
--	       
--*************************************************************

CREATE   View [dbo].[cfvPackerCertification]
AS
Select ct2.ContactName As Site, pg.SiteContactID, pg.PigGroupID, pg.Description,
ct3.ContactName As GroupApproval, s.EligType, pe.DateSubmitted As GroupApprovalDate, ct4.ContactName As BinApproval, bc.BinNbr, 
bc.WithdrawalDate,
ct5.ContactName As PackerApproval, p.ExpirationDate As SWAPPermitDate
FROM cftPigGroup pg
LEFT JOIN cftBinCert bc ON pg.PigGroupID=bc.PigGroupID 
LEFT JOIN cftPigGroupElig pe ON pg.PigGroupID=pe.PigGroupID 
LEFT JOIN cftSitePkrCert ct ON pg.SiteContactID=ct.SiteContactID
JOIN cftContact ct2 ON pg.SiteContactID=ct2.ContactID
LEFT JOIN cftContact ct3 ON pe.SubmitContactID=ct3.ContactID
LEFT JOIN cftContact ct4 ON bc.VerfContactID=ct4.ContactID
LEFT JOIN cftContact ct5 ON ct.PackerContactID=ct5.ContactID
LEFT JOIN CentralData.dbo.Permit p ON pg.SiteContactID=p.SiteContactID AND p.PermitTypeID='16' 
LEFT JOIN cftEligCode s ON pe.EligCode=s.EligCode AND pe.EligType=s.EligType AND s.EligScr='P'
Where pg.PGStatusID IN ('A','T') 

 


