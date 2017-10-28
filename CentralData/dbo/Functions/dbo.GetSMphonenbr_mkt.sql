








CREATE FUNCTION [dbo].[GetSMphonenbr_mkt] 
     (@ContactID as int)  
RETURNS varchar(10)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(10)


;WITH    PhoneCTE
AS (
select sm.ContactID as smcontactid, sm.shortname, sm.contactname, s.contactid as sitecontactid	-- site manager phones
				, s.facilitytypeid
				, cast(sm.contactid as varchar(10)) as phonecontactid
				, ph.PhoneNbr
				, pt.Description phonetype
				, case
					when s.facilitytypeid not in (1,2)
					then
						case 
							when cp.PhoneTypeID = 1 then 2	-- 20130205 changed from 6 to 2
							when cp.PhoneTypeID = 3 then 1	-- 20130205 changed from 4 to 1
--							when cp.PhoneTypeID = 2 then 6	-- 20130205 removed the Home phone for site manager
							else 9	
						end 
					when s.facilitytypeid in (1,2)
					then
						case 
							when cp.PhoneTypeID = 1 then 1
							else 9	
						end 
					else 9
					end		as ordseq
			from  dbo.contact c (nolock)
				inner join  dbo.Site s (nolock) on c.ContactID = s.ContactID
				left outer join  dbo.contact sm (nolock)on s.SiteMgrContactID = sm.ContactID
				left outer join  dbo.contactphone cp  (nolock) on cp.contactid = sm.contactid
					and cp.phonetypeid in (1,3)	-- main,cell	-- removed home(2), home
				left outer join  dbo.phonetype pt  (nolock) on pt.phonetypeid = cp.phonetypeid
				left outer join  dbo.phone ph  (nolock) on ph.phoneid = cp.phoneid
			where  c.ContactID = @ContactID
union
select sm.ContactID as smcontactid, sm.shortname, sm.contactname, s.contactid as sitecontactid		-- site phones
				, s.facilitytypeid
				, cast(c.contactid as varchar(10)) as phonecontactid
				,sph.PhoneNbr
				, spt.Description phonetype
				, case
					when s.facilitytypeid not in (1,2)
					then
						case 
							when scp.PhoneTypeID = 1 then 5	-- 20130205 changd from 3 to 5 
							when scp.PhoneTypeID = 3 then 4 -- 20130205 changd from 1 to 4
							when scp.PhoneTypeID = 2 then 6 -- 20130205 changd from 2 to 6
							else 9	
						end 
					when s.facilitytypeid in (1,2)
					then
						case 
							when scp.PhoneTypeID = 1 then 1
							else 9	
						end 
					else 9
					end		as ordseq
			from  dbo.contact c (nolock)
				inner join  dbo.Site s (nolock) on c.ContactID = s.ContactID
				left outer join  dbo.contact sm (nolock)on s.SiteMgrContactID = sm.ContactID
				left outer join  dbo.contactphone scp (nolock) on scp.contactid = c.contactid
					and scp.PhoneTypeID in (1,3,2)	-- main, cell, home
				left outer join  dbo.PhoneType spt (nolock) on spt.PhoneTypeID = scp.PhoneTypeID
				left outer join  dbo.phone sph  (nolock) on sph.phoneid = scp.phoneid
			where  c.ContactID = @ContactID   
   )
SELECT  top 1 @pcharReturn=PhoneNbr
FROM    PHoneCTE
order by ordseq


	

		-- trucker phone numbers retrieved in this sequence, cell/office/main)


	 RETURN @pcharReturn
	END






