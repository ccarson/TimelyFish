
-- ===========================================================================
-- Author:		Nick Honetschlager
-- Create date: 02/05/2015
-- Description:	Checks that a SiteContactID is valid for a particular PMLoadID
--				and PigGroupID. Adapted from CF518p_cftPM_PMLoadID.
-- ===========================================================================
CREATE Procedure [dbo].[CF518p_cftPM_SourceContactID] @parm1 varchar (6), @parm2 varchar(10) AS 
    SELECT * 
    FROM cftPM 
    WHERE PMLoadID LIKE @parm1
    AND SourcePigGroupID LIKE @parm2
	AND cftpm.highlight NOT IN ('255')
	ORDER BY PMLoadID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF518p_cftPM_SourceContactID] TO [MSDSL]
    AS [dbo];

