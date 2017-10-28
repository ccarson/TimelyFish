--*************************************************************

--	Purpose:List of PigMovement Comments
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: Transporation Module
--	Parms: PMTypeID, PMSystemID, optional PMID
--	      
--*************************************************************
Create PROC [dbo].[pXT100PMComment]
		(@parm1 as varchar(2),@parm2 as varchar(2), @parm3 as varchar(10))

as

Select pm.MovementDate,pm.PMID as txtPMID, com.*,s.ContactName as Source, d.Contactname as Dest,t.ContactName as Trucker
	 from cftPM pm WITH (NOLOCK) 
	JOIN cftPMComm com WITH (NOLOCK) on pm.ID=com.PMID  
	join cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
	JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
	JOIN cftContact t WITH (NOLOCK) on pm.TruckerContactID=t.ContactID
	where pm.PMTypeID = @parm1 and pm.PMSystemID like @parm2 
	and pm.PMID like @parm3

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PMComment] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PMComment] TO [MSDSL]
    AS [dbo];

