
CREATE PROCEDURE CF538p_GroupList
	@GroupID varchar(10)
 AS 
 SELECT pg.*, IsNull(sc.StartValue,0)
	FROM cftPigGroup pg
	LEFT JOIN cfv_StartCharge sc ON pg.PigGroupID = sc.PigGroupID
	WHERE pg.PigGroupID LIKE @GroupID
	AND pg.InitialPigValue = 0
	AND pg.PGStatusID <> 'X'
	ORDER BY pg.PigGroupID


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF538p_GroupList] TO [MSDSL]
    AS [dbo];

