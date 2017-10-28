
-- =========================================================================
-- Author:		Nick Honetschlager
-- Create date: 01/21/2015
-- Description:	Checks that a pig group is valid for a particular site.
--				Adapted from CF518p_cftPigGroup_CPigGroupId.
-- ==========================================================================

Create Procedure [dbo].[CF51850p_cftPigGroup_Check] @parm1  varchar (10), @parm3 as varchar (10) AS 
    Select pg.* from cftPigGroup pg
	Where SiteContactId = @parm1
        and pg.PigGroupId Like @parm3 and PGStatusID<>'I' and PGStatusID<>'X'
	and Exists (Select * from cftPGStatus Where pg.PGStatusId = PGStatusId and Status_PA = 'A' 
	and Status_AR = 'A')
	Order by pg.PigGroupId

