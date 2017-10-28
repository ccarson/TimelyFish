 CREATE PROCEDURE smSCQStatusCall_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smSCQStatusCall
	left outer join smCallStatus
		on smSCQStatusCall.CallStatus = smCallStatus.CallStatusId
WHERE ConfigCode = @parm1
	AND CallStatus LIKE @parm2
ORDER BY ConfigCode
	,CallStatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSCQStatusCall_All] TO [MSDSL]
    AS [dbo];

