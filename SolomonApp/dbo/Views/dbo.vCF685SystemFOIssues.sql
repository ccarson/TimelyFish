
--*************************************************************
--	Purpose:joins contactname and issue type by ord type to fo table
--		
--	Author: Charity Anderson
--	Date: 6/14/2005
--	Usage: Feed Order System Issues Report
--	Parms: none
--*************************************************************

CREATE  View dbo.vCF685SystemFOIssues

AS
Select
    fo.*
, ot.Descr
, ot.RespPty
, IssueType = Case when ot.User8 = 0 then ot.Descr else 'OverRun - Source' end
, Site = Case when ot.User8 = 0 then fo.ContactID else ovr.ContactID end

FROM cftFeedOrder fo WITH (NOLOCK)
JOIN cftOrderType ot WITH (NOLOCK)
            on fo.OrdType=ot.OrdType
LEFT JOIN cftFeedOrder ovr WITH (NOLOCK)
            on fo.SrcOrdNbr=ovr.OrdNbr
where RespPty<>'X'


 
