

--*************************************************************
--	Purpose:Selection for date grid in Internal and Marketing
--		
--	Author: Charity Anderson
--	Date: 2/8/2005
--	Usage: FlowBoardModule 
--	Parms: Date, System, Company
--  Update: Added "order by PMID"  - DDahle 11/23/2011
--  Update: Added "Conflict check"  - DDahle 11/19/2013
--  Update: Removed "Conflict check"  - DDahle 01/06/2014  Removed for performance reasons
--*************************************************************

CREATE PROC [dbo].[pXT200PMSpecDate_20140115_replaced]
	(@parm1 as smalldatetime,@parm2 as varchar(2), @parm3 as varchar(3))
AS
Select pm.*
	,s.ContactName as Source
	,d.ContactName as Destination
	--,CASE pm.PMSystemID
	--	When '01' THEN dbo.CFF_HATCheck (pm.id)
	--	ELSE 0
	-- END as Conflict
	,0 as Conflict
from cftPM pm 
LEFT JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
where pm.MovementDate=@parm1
and PMTypeID='01'
and PMSystemID like @parm2
order by PMID
--d CpnyID=@parm3




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200PMSpecDate_20140115_replaced] TO [MSDSL]
    AS [dbo];

