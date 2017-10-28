 CREATE PROCEDURE smConPMTask_Grid
	@parm1 varchar(10)
	,@parm2 varchar(10)
	,@parm3 varchar(10)
	,@parm4 smalldatetime
	,@parm5 smalldatetime
AS
SELECT *
FROM smConPMTask
	left outer join smPMHeader
		on smConPMTask.PMCode = smPMHeader.PMType
WHERE smConPMTask.ContractId = @parm1
	AND smConPMTask.EquipID = @parm2
	AND smConPMTask.PMCode LIKE @parm3
	AND smConPMTask.PMDate BETWEEN @parm4 AND @parm5
ORDER BY smConPMTask.ContractID
	,smConPMTask.EquipId
	,smConPMTask.PMCode
	,smConPMTask.PMDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPMTask_Grid] TO [MSDSL]
    AS [dbo];

