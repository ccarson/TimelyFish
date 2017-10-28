--*************************************************************
--	Purpose:PGStatusHist Lookup		
--	Author: Charity Anderson
--	Date: 8/8/2005
--	Usage: TransportRecord Entry Batch Release
--	Parms: (PigGroupID,PGStatusID,StatusDatect
--	      
--*************************************************************

CREATE  PROC dbo.pXP135PGStatHistLKUP
	@parm1 as varchar(10),
	@parm2 as varchar(2),
	@parm3 as smalldatetime
	
AS
Select * from cftPGStatHist
WHERE PigGroupID=@parm1
and PGStatusID=@parm2 
and StatusDate=@parm3 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PGStatHistLKUP] TO [MSDSL]
    AS [dbo];

