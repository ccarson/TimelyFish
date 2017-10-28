 CREATE PROCEDURE smREntDetail_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
	,@parm3Min smallint
	,@parm3max smallint
AS
SELECT *
FROM smRentDetail
	left outer join smRentHeader
		on smREntDetail.TransId = smRentHeader.TransId
WHERE smREntDetail.EquipID = @parm1
	AND smREntDetail.TransID LIKE @parm2
	AND smREntDetail.LineID BETWEEN @parm3min AND @parm3Max
ORDER BY smREntDetail.EquipID
	,smREntDetail.StartDate DESC
	,smRentDetail.LineId DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smREntDetail_All] TO [MSDSL]
    AS [dbo];

