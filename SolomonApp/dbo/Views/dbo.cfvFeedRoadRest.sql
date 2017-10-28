


CREATE    VIEW cfvFeedRoadRest
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Road Restricion Feed Order Exception XF61000
-- CREATED BY: Sue Matter
-- CREATED ON: 3/3/2006
-- USED BY: XF61000
---------------------------------------------------------------------------------------
Select fo.OrdNbr, ct.ContactName, fo.ContactID, fo.BinNbr, st.RoadRestrictionTons, fo.DateReq, fo.QtyOrd 
From cftFeedOrder fo
JOIN cftContact ct on fo.ContactID=ct.ContactID
JOIN cftSite st on ct.ContactID=st.ContactID
Where fo.Status <> ('C') AND fo.Status <> ('X')
AND fo.OrdType IN ('E1','E2','E3','E4','E5','E6','E7','E8','OO','OP','WK')
AND st.RoadRestrictionTons<>0


