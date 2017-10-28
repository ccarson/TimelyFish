--*************************************************************
--	Purpose:PGStatusUpd Lookup		
--	Author: Charity Anderson
--	Date: 8/9/2005
--	Usage: TransportRecord Entry Batch Release
--	Parms: (PigGroupID,BatNbr,RefNbr
--	      
--*************************************************************

CREATE  PROC dbo.pXP135PGStatUpdLKUP
	@parm1 as varchar(10),
	@parm2 as varchar(10),
	@parm3 as varchar(10)
	
AS
Select * from cftPGStatusUpd
WHERE PigGroupID=@parm1
and BatNbr=@parm2 
and RefNbr=@parm3 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PGStatUpdLKUP] TO [MSDSL]
    AS [dbo];

