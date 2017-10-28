--*************************************************************
--	Purpose:Destination PM record for the source offload
--	Author: Charity Anderson
--	Date: 7/14/2005
--	Usage: Pig Sales Entry		 
--	Parms: PMLoadID
--*************************************************************

CREATE PROC dbo.pCF518OffloadPM
	(@parm1 as varchar(10))
AS
Select pm.* from cftPM pm
JOIN cftPigOffload o on pm.ID=o.DestPMID
where SrcPMID=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518OffloadPM] TO [MSDSL]
    AS [dbo];

