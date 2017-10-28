

CREATE        VIEW cfvGeorgeCapacity (Company, ContactName, SiteID, NimberofBarns, SiteCapacity,
SumOfMaxCap, ProjectCpny, Description, Ownership, gl_subacct)
AS

SELECT st.CpnyID, ct.ContactName, st.SiteID, 
Count(bn.StdCap)AS NumberofBarns, Sum(bn.StdCap)AS SiteCapacity, Sum(bn.MaxCap)  AS SumOfMaxCap, pj.CpnyId As ProjectCpny, fc.Description, ot.Description As Ownership, pj.gl_subacct
FROM cftSite st 
JOIN cftBarn bn ON st.ContactID=bn.ContactID
JOIN cftFacilityType fc ON st.FacilityTypeID=fc.FacilityTypeID
JOIN cftContact ct ON st.ContactID=ct.ContactID
JOIN cftOwnershipType ot ON st.OwnerShipTypeID=ot.OwnerShipTypeID
JOIN pjproj pj ON st.SolomonProjectID = pj.Project
Where fc.Description IN ('WF', 'Finish') AND bn.StatusTypeID=1
GROUP BY st.CpnyID, ct.ContactName, st.SiteID, pj.CpnyId, fc.Description, ot.Description, pj.gl_subacct




 