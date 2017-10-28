

CREATE FUNCTION [dbo].[GetTphonenbr] 
     (@ContactID as int)  
RETURNS varchar(10)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(10)
	SET @pcharReturn=
	(select xx.PhoneNbr
	 from (select top 1 c.ContactID, c.shortname, c.contactname, ph.phonenbr,  pt.description phonetype
			, case when cp.PhoneTypeID = 1 then 3 when cp.PhoneTypeID = 3 then 1 when cp.PhoneTypeID = 18 then 2 else 9	end as ordseq
			from  dbo.contact c (nolock)
			left outer join  dbo.contactphone cp  (nolock) on cp.contactid = c.contactid
			left outer join  dbo.phonetype pt  (nolock) on pt.phonetypeid = cp.phonetypeid
			left outer join  dbo.phone ph  (nolock) on ph.phoneid = cp.phoneid
			where cp.phonetypeid in (1,3,18) -- main, cell, office
			and c.ContactID = @contactid
			order by ordseq) xx)
		-- trucker phone numbers retrieved in this sequence, cell/office/main)


	 RETURN @pcharReturn
	END


