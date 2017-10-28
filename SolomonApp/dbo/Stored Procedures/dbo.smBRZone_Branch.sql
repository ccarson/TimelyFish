 CREATE PROCEDURE smBRZone_Branch
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smBRZone
	left outer join smArea
		on ZoneID = AreaId
WHERE BranchID = @parm1
	AND ZoneID LIKE @parm2
ORDER BY BranchID, ZoneID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smBRZone_Branch] TO [MSDSL]
    AS [dbo];

