--Uncomment the lines below for server testing

--:SETVAR SolomonApp SolomonApp
--DECLARE @expirdate smalldatetime = '2050-12-31' ; 


CREATE PROCEDURE 
    dbo.cfp_PQA_Report( 
        @expirdate AS smalldatetime )
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_PQA_Report
     Author:    Thomas Thomsen
    Created:    2015-07-28
    Purpose:    Extract PQA permit data from Central Data for Excel spreadsheet


    Revision History:    
    revisor         date                description
    ---------       -----------         ----------------------------
    Thomsen         2015-07-28          created
    unknown         2015-10-01          Issue Date not current fix, PQA Certified blank fix
    unknown         2015-10-29          JoDee requested some change to the report
    ccarson         2016-09-30          Help Desk ticket G9UH192224    
                                        restricted report to only PQA Permit and PQA Plus Permit Types
                                        revised logic for SiteManager retrieval
                
    Notes:

************************************************************************************************************************************
*/        

SET NOCOUNT, XACT_ABORT ON ; 

DECLARE
    @PQAPermitType              AS int          = 12
  , @PQAPlusPermitType          AS int          = 27
  , @PQAPlusAdvisor             AS int          = 31 
            
  , @ContactTypeSite            AS int          = 4
  , @ContactTypeIndividual      AS int          = 3
  , @ContactStatusTypeActive    AS int          = 1 
  , @ContactPQARequired         AS varchar(03)  = 'Yes' ; 

SELECT 
    [Contact ID]                 = pq.ContactID
  , [Contact Name]               = pq.ContactName  
  , [Permit Number]              = pq.PermitNumber
  , [Related Site]               = RelatedContactName 
  , Phase                        = fct.FacilityTypeDescription 
  , [Issue Date]                 = pq.IssueDate
  , [Expiration Date]            = pq.ExpirationDate
  , [Service Manager]            = ssm.SvcMgrName         
  , [Production Farm Manager]    = pfm.ProdMgrName 
  , [Site Manager]               = stm.SiteMgrName           
  , [Round Trip To Sleepy Eye]   = mm_se.OneWayMiles * 2  
  , [Round Trip To Forest City]  = mm_fc.OneWayMiles * 2 
  , [Round Trip To Iowa Falls]   = mm_if.OneWayMiles * 2  
  , [PQA Required]               = pq.PQA_Required
FROM(
    SELECT 
        c.ContactID 
	  , c.ContactName 
	  , PermitNumber          = p.PermitNbr
	  , ExpirationDate        = MAX(p.ExpirationDate) 
	  , IssueDate             = MAX(p.IssueDate) 
	  , StatusType            = c.StatusTypeID 
	  , PQA_Required          = c.PQACertRequired
	  , SiteNumCount          = ROW_NUMBER() 
                                    OVER (  PARTITION BY c.ContactID 
                                            ORDER BY 
                                                c.ContactID
                                              , MAX( ISNULL( p.ExpirationDate, GETDATE() ) ) DESC
                                              , ISNULL( rec.ContactName, 'zzzz' ) ) 
	  , rc.RelatedID
	  , RelatedContactName    = rec.ContactName
	FROM 
        dbo.Contact AS c
	LEFT JOIN 
        dbo.Permit AS p 
            ON p.SiteContactID = c.ContactID
	LEFT JOIN 
        dbo.RelatedContact AS rc 
            ON rc.ContactID = c.ContactID
	LEFT JOIN 
        dbo.Contact AS rec 
            ON rec.ContactID = rc.RelatedID AND rec.ContactTypeID = 4 AND rec.StatusTypeID = 1
	WHERE 
        c.PQACertRequired = 'Yes' 
            AND c.StatusTypeID = '1' 
            AND c.ContactTypeID = '3'
            AND ISNULL ( p.ExpirationDate, GETDATE() ) >= '01/01/1900'
            AND ( p.PermitTypeID IN( @PQAPermitType, @PQAPlusPermitType ) OR p.PermitTypeID IS NULL )
	GROUP BY 
        c.ContactID, c.ContactName, c.StatusTypeID, c.PQACertRequired, p.PermitNbr, rc.RelatedID, rec.ContactName ) AS pq

-- Get the facility type of the related site
LEFT JOIN 
    dbo.Site AS rsi 
        ON rsi.ContactID = pq.RelatedID
LEFT JOIN 
    dbo.FacilityType AS fct 
        ON fct.FacilityTypeID = rsi.FacilityTypeID
	

-- Get the distance from the related site to the feed mills
LEFT JOIN 
    [$(SolomonApp)].dbo.vCFContactMilesMatrix AS mm_se 
        ON mm_se.SourceSite = RIGHT( '000' + CAST( pq.RelatedID AS VARCHAR ), 6 ) AND mm_se.DestSite = '001327'
LEFT JOIN 
    [$(SolomonApp)].dbo.vCFContactMilesMatrix AS mm_if 
        ON mm_if.SourceSite = RIGHT( '000' + CAST( pq.RelatedID AS VARCHAR ), 6 ) AND mm_if.DestSite = '001330'
LEFT JOIN 
    [$(SolomonApp)].dbo.vCFContactMilesMatrix AS mm_fc 
        ON mm_fc.SourceSite = RIGHT( '000' + CAST( pq.RelatedID AS VARCHAR ), 6 ) AND mm_fc.DestSite = '005248'

-- Get the current Service Manager for the Related Site (not the person with the PQA)
LEFT JOIN(
    SELECT 
        SiteContactID         = RIGHT( '0000' + CONVERT( VARCHAR(10) , ssm1.SiteContactID ) , 6 ) 
      , sm1.SvcMgrContactID   
      , sm1.EffectiveDate     
      , SvcContactID          = c.ContactID 
      , SvcMgrName            = c.ContactName 
      , SiteName              = c2.ContactName 
    FROM( SELECT SiteContactID, MAX(EffectiveDate) AS EffectiveDate FROM dbo.SiteSvcMgrAssignment GROUP BY SiteContactID ) AS ssm1
	LEFT JOIN 
        dbo.SiteSvcMgrAssignment AS sm1 
            ON sm1.SiteContactID = ssm1.SiteContactID AND sm1.EffectiveDate = ssm1.EffectiveDate
	LEFT JOIN 
        dbo.Contact c ON c.ContactID = sm1.SvcMgrContactID
	LEFT JOIN 
        dbo.Contact c2 ON c2.ContactID = ssm1.SiteContactID ) AS ssm 
    ON ssm.SiteContactID = pq.RelatedID

-- Get the current Production Farm Manager for the Related Site (not the person with the PQA)
LEFT JOIN(
    SELECT 
        SiteContactID         = RIGHT( CAST( '0000' AS VARCHAR(6) ) + CAST( LTRIM( pfm1.SiteContactID ) AS VARCHAR(06) ), 6 )
      , sm1.ProdSvcMgrContactID   
      , sm1.EffectiveDate     
      , SvcContactID          = c.ContactID 
      , ProdMgrName           = c.ContactName 
      , SiteName              = c2.ContactName 
    FROM( SELECT SiteContactID, MAX(EffectiveDate) AS EffectiveDate FROM dbo.ProdSvcMgrAssignment GROUP BY SiteContactID ) AS pfm1
	LEFT JOIN 
        dbo.ProdSvcMgrAssignment AS sm1 
            ON sm1.SiteContactID = pfm1.SiteContactID AND sm1.EffectiveDate = pfm1.EffectiveDate
    LEFT JOIN 
        dbo.Contact AS c ON c.ContactID = sm1.ProdSvcMgrContactID
    LEFT JOIN 
        dbo.Contact AS c2 ON c2.ContactID = pfm1.SiteContactID ) pfm ON pq.RelatedID = pfm.SiteContactID

       
-- Get the current Site Manager for the Related Site (not the person with the PQA)
LEFT JOIN(
	SELECT 
        SiteContactID         = RIGHT( CAST( '0000' AS VARCHAR(6) ) + CAST( LTRIM( stm1.ContactID ) AS VARCHAR(6) ), 6 )
      , sm1.SiteMgrContactID
      , c.ContactID 
      , SiteMgrName           = c.ContactName 
      , SiteName              = c2.ContactName 
    FROM( SELECT ContactID FROM dbo.Site ) AS stm1
    LEFT JOIN 
        dbo.Site AS sm1 
            ON sm1.ContactID = stm1.ContactID
    LEFT JOIN 
        dbo.Contact AS c 
            ON c.ContactID = sm1.SiteMgrContactID
    LEFT JOIN 
        dbo.Contact AS c2 
            ON c2.ContactID = stm1.ContactID ) AS stm ON pq.RelatedID = stm.SiteContactID

WHERE 
    SiteNumCount = 1
        AND( ExpirationDate IS NULL OR @expirdate > ExpirationDate ) 
ORDER BY 
    [Contact ID] ;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PQA_Report] TO [SE\PQA Individuals]
    AS [dbo];

