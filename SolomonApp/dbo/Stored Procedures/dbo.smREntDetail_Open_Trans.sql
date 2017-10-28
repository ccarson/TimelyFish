 CREATE PROCEDURE smREntDetail_Open_Trans
	@parm1 varchar(10)
	,@parm2 varchar(10)
	,@parm3Min smallint
	,@parm3max smallint
AS
SELECT *
FROM smRentDetail
	left outer join smRentHeader
		on smREntDetail.TransId = smRentHeader.TransId
WHERE smREntDetail.EquipID = @Parm1
	AND smREntDetail.TransID LIKE @parm2
	AND smREntDetail.LineID BETWEEN @parm3min AND @parm3Max
	AND smRentHEader.Status IN ('R','N','P')
ORDER BY smREntDetail.EquipID
	,smRentDetail.TransID DESC
	,smREntDetail.StartDate DESC
	,smRentDetail.LineId DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smREntDetail_Open_Trans] TO [MSDSL]
    AS [dbo];

