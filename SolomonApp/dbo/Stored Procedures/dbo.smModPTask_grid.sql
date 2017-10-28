 CREATE PROCEDURE
	smModPTask_grid
		@parm1	varchar(10)
		,@parm2	varchar(40)
		,@parm3	varchar(10)
AS
	SELECT
		*
	FROM
		smModPTask
		,smPMHeader
	WHERE
		smModPTask.Manuf = @parm1
			AND
		smModPTask.Model = @parm2
			AND
		smModPTask.PMCode LIKE @parm3
			AND
		smModPTask.PMCode = smPMHeader.PMType
 	ORDER BY
		smModPTask.Manuf
		,smModPTask.Model
		,smModPTask.PMCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smModPTask_grid] TO [MSDSL]
    AS [dbo];

