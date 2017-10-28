CREATE PROCEDURE pXP215_GroupList
	@ContactID varchar(6),
	@IncludeFlag smallint,
	@GroupID varchar(10)
 AS 
 SELECT *
	FROM cftPigGroup
	WHERE SiteContactID LIKE @ContactID
	AND PigGroupID LIKE @GroupID
	AND PGStatusID Not IN('X')
	AND len(rtrim(CF03)) <= @IncludeFlag
	ORDER BY SiteContactID, EstStartDate, BarnNbr


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP215_GroupList] TO [MSDSL]
    AS [dbo];

