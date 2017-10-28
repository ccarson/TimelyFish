





create FUNCTION [dbo].[GetSMphonenbr] 
     (@ContactID as int)  
RETURNS varchar(10)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(10)
	SET @pcharReturn=
	(select xx.PhoneNbr
	 from (select top 1
				sm.ContactID, sm.shortname, sm.contactname
				, case
					when s.facilitytypeid in (1,2)
					then sph.PhoneNbr
					else ph.PhoneNbr
					end		as phonenbr
				, case
					when s.facilitytypeid in (1,2)
					then spt.Description
					else pt.Description
					end	as phonetype --pt.description phonetype
				, case
					when s.facilitytypeid not in (1,2)
					then
						case 
							when scp.PhoneTypeID = 1 then 3 
							when scp.PhoneTypeID = 3 then 1
							when scp.PhoneTypeID = 2 then 2 
							when cp.PhoneTypeID = 1 then 6
							when cp.PhoneTypeID = 3 then 4
							when cp.PhoneTypeID = 2 then 5
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
				left outer join  dbo.contactphone scp (nolock) on scp.contactid = c.contactid
				left outer join  dbo.phonetype pt  (nolock) on pt.phonetypeid = cp.phonetypeid
				left outer join  dbo.PhoneType spt (nolock) on spt.PhoneTypeID = scp.PhoneTypeID
				left outer join  dbo.phone ph  (nolock) on ph.phoneid = cp.phoneid
				left outer join  dbo.phone sph  (nolock) on sph.phoneid = scp.phoneid
			where  (cp.phonetypeid in (1,3,2) -- main, cell, home
				or scp.PhoneTypeID in (1,3,2))
			and c.ContactID = @contactid
			order by ordseq)
			 xx)
		-- trucker phone numbers retrieved in this sequence, cell/office/main)


	 RETURN @pcharReturn
	END



