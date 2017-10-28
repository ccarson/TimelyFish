
/****** Object:  View dbo.cfv_PigGroup_Capacity    Script Date: 12/2/2005 7:37:59 AM ******/
CREATE VIEW cfv_PigGroup_Capacity (PigGroupID, Capacity)
AS

Select PigGroupID, dbo.PGGetCapacity(PigGroupID)
From cftPigGroup


/*
--Old incorrect method

Select Distinct p.PigGroupID, (CASE When p.PigProdPhaseID='NUR' THEN
	CONVERT(INT, Case When r.RoomNbr is Null Then 
		Coalesce((Select Sum(MaxCap) from cftBarn Where BarnNbr = p.BarnNbr 
			and ContactId = p.SiteContactId), 0) 
		Else 
		Coalesce((Select Sum(b.MaxCap * m.BrnCapPrct) 
			From cftBarn b 
			Join cftRoom m on b.ContactId = m.ContactId 
			and b.BarnNbr = m.BarnNbr 
			Where b.ContactId = p.SiteContactId 
			and b.BarnNbr = p.BarnNbr 
			and m.RoomNbr = r.RoomNbr 
			and b.StatusTypeID='1'), 0) 
		End) * bn.CapMultiplier
	Else
		CONVERT(INT, Case When r.RoomNbr is Null Then 
		Coalesce((Select Sum(MaxCap) 
			from cftBarn Where BarnNbr = p.BarnNbr 
			and ContactId = p.SiteContactId), 0) 
		Else 
		Coalesce((Select Sum(b.MaxCap * m.BrnCapPrct) 
			From cftBarn b 
			Join cftRoom m on b.ContactId = m.ContactId 
			and b.BarnNbr = m.BarnNbr Where b.ContactId = p.SiteContactId 
			and b.BarnNbr = p.BarnNbr and m.RoomNbr = r.RoomNbr 
			and b.StatusTypeID='1'), 0) 
		End) 
	End))
	from cftPigGroup p WITH (NOLOCK)
	Left Join cftPigGroupRoom r WITH (NOLOCK) on p.PigGroupId = r.PigGroupId  */





 
