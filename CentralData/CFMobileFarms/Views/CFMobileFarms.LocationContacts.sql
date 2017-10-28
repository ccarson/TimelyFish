



CREATE VIEW [CFMobileFarms].[LocationContacts]  
AS
SELECT distinct
        c.ContactID as LocationContactID
	   ,isnull(SSM.SrSvcContactID,'') as 'ContactContactID'       
       ,isnull(SSM.SrSvcName,'') as 'ContactName'
	   ,'Service Manager' as 'ContactType'
	   ,isnull(svmp.phonenbr,'') as 'ContactPhone'
	   ,isnull(ssm.SrSvcEmail,'') as 'ContactEmail'
       ,CONVERT(nvarchar(128), s.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
       JOIN dbo.Site s on c.ContactID = s.ContactID
       --ServiceMgr
       JOIN
              (SELECT sm1.SiteContactID,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c1.ContactID SrSvcContactID, c1.EMailAddress SrSvcEmail,c1.ContactName SrSvcName
              FROM (SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                           FROM  dbo.ProdSvcMgrAssignment 
                                  GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c1 ON c1.ContactID=sm2.ProdSvcMgrContactID) SSM ON SSM.SiteContactID=s.ContactID

	    --ServiceMgr phone 
	   LEFT JOIN
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON SSM.SrSvcContactID = svmphone.ContactID 
	   LEFT JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID

WHERE
	c.ContactTypeID = 4 AND c.StatusTypeID = 1
	AND s.Siteid NOT IN ('9999','1660','8000','8010','0001') 

UNION
 --Production/Farm ServiceMgr
SELECT distinct
        c.ContactID as LocationContactID
	   ,isnull(SM.SvcContactID,'') as 'ContactContactID'       
       ,isnull(SM.SvcMgrName,'') as 'ContactName'
	   ,'Production/Farm Manager' as 'ContactType'
	   ,isnull(svmp.phonenbr,'') as 'ContactPhone'
	   ,isnull(sm.SvcEmail,'') as 'ContactEmail'
       ,CONVERT(nvarchar(128), s.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
       JOIN dbo.Site s on c.ContactID = s.ContactID

       JOIN
              (SELECT sm1.SiteContactID,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID, c.EMailAddress SvcEmail,c.ContactName SvcMgrName
              FROM(
                     SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                     FROM  dbo.SiteSvcMgrAssignment 
                           GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID) SM ON SM.SiteContactID=s.ContactID

	    -- --Production/Farm ServiceMgr phone 
	   LEFT JOIN
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON SM.SvcContactID = svmphone.ContactID 
	   LEFT JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID

WHERE
	c.ContactTypeID = 4 AND c.StatusTypeID = 1
	AND s.Siteid NOT IN ('9999','1660','8000','8010','0001') 

UNION
 ----MarketMgr
SELECT distinct
        c.ContactID as LocationContactID
	   ,isnull(MM.MarketSvcMgrContactID,'') as 'ContactContactID'       
       ,isnull(MM.MarketMgrName,'') as 'ContactName'
	   ,'Market Manager' as 'ContactType'
	   ,isnull(svmp.phonenbr,'') as 'ContactPhone'
	   ,isnull(MM.MarketMgrEmail,'') as 'ContactEmail'
       ,CONVERT(nvarchar(128), s.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
      JOIN dbo.Site s on c.ContactID = s.ContactID
      JOIN(SELECT sm1.SiteContactID,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.EMailAddress MarketMgrEmail,c.ContactName MarketMgrName
              FROM(
                     SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                     FROM  dbo.MarketSvcMgrAssignment 
                           GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID) MM ON MM.SiteContactID = s.ContactID

	    --MarketMgr phone 
	   LEFT JOIN
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON MM.MarketSvcMgrContactID = svmphone.ContactID 
	   LEFT JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID

WHERE
	c.ContactTypeID = 4 AND c.StatusTypeID = 1
	AND s.Siteid NOT IN ('9999','1660','8000','8010','0001') 

UNION

 --SiteMgr
SELECT distinct
        c.ContactID as LocationContactID
	   ,isnull(sitemgr.ContactID,'') as 'ContactContactID'       
       ,isnull(sitemgr.ContactName,'') as 'ContactName'
	   ,'Site Manager' as 'ContactType'
	   ,isnull(svmp.phonenbr,'') as 'ContactPhone'
	   ,isnull(sitemgr.EMailAddress,'') as 'ContactEmail'
       ,CONVERT(nvarchar(128), s.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
      JOIN dbo.Site s on c.ContactID = s.ContactID
      JOIN  dbo.Contact sitemgr (NOLOCK) ON sitemgr.ContactID = s.SiteMgrContactID

	    --MarketMgr phone 
	   LEFT JOIN
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON sitemgr.ContactID = svmphone.ContactID 
	   LEFT JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID

WHERE
	c.ContactTypeID = 4 AND c.StatusTypeID = 1
	AND s.Siteid NOT IN ('9999','1660','8000','8010','0001') 

UNION

 --Load Crew

SELECT distinct
       c.ContactID as LocationContactID
	   ,loadcrew.ContactID as 'ContactContactID'       
       ,loadcrew.ContactName as 'ContactName'
	   ,'Load Crew' as 'ContactType'
	  ,isnull(svmp.phonenbr,'') as 'ContactPhone'
	   ,isnull(loadcrew.EMailAddress,'') as 'ContactEmail'
      ,CONVERT(nvarchar(128), s.ContactID) as Id
	 	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
      JOIN dbo.Site s on c.ContactID = s.ContactID
     
	  LEFT JOIN  dbo.RelatedContact rcx on rcx.RelatedID = c.ContactID and rcx.SummaryOfDetail like '%Load Crew%'
      LEFT JOIN  dbo.Contact loadcrew (NOLOCK) on loadcrew.ContactID = rcx.ContactID
    
	LEFT JOIN
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON rcx.ContactID = svmphone.ContactID 
	   LEFT JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID


WHERE
	c.ContactTypeID = 4 AND c.StatusTypeID = 1
AND s.Siteid NOT IN ('9999','1660','8000','8010','0001') 	


GO
GRANT SELECT
    ON OBJECT::[CFMobileFarms].[LocationContacts] TO [hybridconnectionlogin_permissions]
    AS [HybridConnectionLogin];

