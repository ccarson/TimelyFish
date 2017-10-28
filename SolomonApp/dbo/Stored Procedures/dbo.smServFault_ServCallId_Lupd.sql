 CREATE PROCEDURE
	smServFault_ServCallId_Lupd
		@parm1	varchar(10),
		@parm2	smallint,
		@parm3	datetime
AS
	SELECT
		*
	FROM
		smServFault
	WHERE
		ServiceCallId = @parm1
		AND LineNbr = @parm2
--		AND Lupd_DateTime <= @parm3
		AND CONVERT(DATETIME,SF_ID03)  <= @parm3
	ORDER BY
		ServiceCallId
		,LineNbr


