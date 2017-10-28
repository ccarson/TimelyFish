--*************************************************************
--	Purpose:Pig Group list based on user parameters
--		
--	Author: Charity Anderson
--	Date: 8/25/2005
--	Usage: Pig Group Verification Screen Pig Group DBNav 
--	Parms:UnVerifiedFlag, VerifiedFlag,PigGroup
--*************************************************************

CREATE PROC dbo.pXP236PigGroup
	(@parm1 as varchar(1),@parm2 as varchar(1), @parm3 as varchar(10), @parm4 varchar(10))
AS

Select pg.*, ct.ContactName from cftPigGroup pg
JOIN cftContact ct ON pg.SiteContactID=ct.ContactID
where pg.PGStatusID='A' AND 
	((@parm1=1 and pg.PGStatusID='A' and pg.UseActualsFlag=0 and pg.PigGroupID like @parm3 + '%')
     or (@parm1=0 and @parm2=0 and pg.PigGroupID like @parm3 + '%'))
     and pg.PigGroupID like @parm4

order by ct.ContactName, pg.BarnNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP236PigGroup] TO [MSDSL]
    AS [dbo];

