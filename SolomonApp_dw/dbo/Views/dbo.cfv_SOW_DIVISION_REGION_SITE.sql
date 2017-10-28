
-- ==================================================================
-- Author:		Mike Zimanski
-- Create date: 12/13/2010
-- Description:	Sow Division, Region, Site information
-- ==================================================================
CREATE VIEW [dbo].[cfv_SOW_DIVISION_REGION_SITE]
	(ContactName1, ContactName2, ContactID, SiteID, Division, Region)
	AS
	Select Distinct
	Rtrim(C.ContactName) as ContactName1,
	Case when C.ContactID in (000340,000341,000342,000343,000344,004001) then 'LDC Farrowing' 
	when C.ContactID in (000345,000346,000347,000348,000349,000350,004002) then 'ON Farrowing' else Rtrim(C.ContactName)
	end as ContactName2, 
	C.ContactID,
	S.SiteID,
	Case when C.ContactID in (002283,000838) then 'NUCLEUS'
	when C.ContactID in (000330,000335,002562,002563) then 'MULT' else 'COMMERCIAL' end as Division,
	Case when C.ContactID in (000315,000322,000323,000324,000325,000326,000327,000328,000329,000331,000332,000333,
	000337,000339,000837,000836,000835,004184,000316,000318,000319,000320,000321) then 'MN/CO'
	when C.ContactID in (000336,000338,000340,000341,000342,000343,000344,004001,000345,000346,000347,000348,000349,004183,
	000350,004002) then 'NE'
	when C.ContactID in (002547,002548,002549,002550,002551,002552,002553,004314,004742,002554) then 'SIA'
	when C.ContactID in (002555,002556,002557,002558,002559,002560,002561,005033,002687) then 'IL'
	when C.ContactID in (002283,000838) then 'NUCLEUS'
	when C.ContactID in (000330,000335,002562,002563) then 'MULT' else '' end as Region
		
	from [$(SolomonApp)].dbo.cftContact C (nolock)

	left join [$(SolomonApp)].dbo.cftSite S (nolock)
	on C.ContactID = S.ContactID 

	Where C.ContactTypeID = 04
	and S.FacilityTypeID = 001
	and C.ContactID not in (000334,000558,003980,004185)

	

