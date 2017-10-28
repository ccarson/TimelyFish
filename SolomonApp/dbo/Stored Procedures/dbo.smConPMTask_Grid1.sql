 CREATE PROCEDURE smConPMTask_Grid1
	@parm1 varchar(10)
	,@parm2 varchar(10)
	,@parm3 smalldatetime
	,@parm4 smalldatetime
	,@parm5 varchar(10)
AS
SELECT *
FROM smConPMTask
	left outer join smPMHeader
		on smConPMTask.PMCode = smPMHeader.PMType
WHERE smConPMTask.ContractId = @parm1
	AND smConPMTask.EquipID = @parm2
	AND smConPMTask.PMDate BETWEEN @parm3 AND @parm4
	AND smConPMTask.PMCode LIKE @parm5
ORDER BY smConPMTask.ContractID
	,smConPMTask.EquipId
	,smConPMTask.PMDate
	,smConPMTask.PMCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPMTask_Grid1] TO [MSDSL]
    AS [dbo];

