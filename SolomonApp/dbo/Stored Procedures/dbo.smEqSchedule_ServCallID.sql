 CREATE PROCEDURE smEqSchedule_ServCallID
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smEqSchedule
	left outer join smEquipment
		on smEqSchedule.EquipmentID = smEquipment.EquipmentID
WHERE smEqSchedule.ServiceCallID = @parm1
	AND smEqSchedule.EquipmentID LIKE @parm2
ORDER BY smEqSchedule.ServiceCallID
	,smEqSchedule.EquipmentID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEqSchedule_ServCallID] TO [MSDSL]
    AS [dbo];

