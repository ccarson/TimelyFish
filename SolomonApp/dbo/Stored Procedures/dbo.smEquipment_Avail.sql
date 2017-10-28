 CREATE PROCEDURE smEquipment_Avail
	@sd smalldatetime
	,@ed smalldatetime
	,@st char(4)
	,@et char(4)
AS
SELECT *
FROM smEquipment
	left outer join smEqSchedule
		on smEquipment.EquipmentID = smEqSchedule.EquipmentID
WHERE (EqEndDate < @sd
	OR
	EqStartDate > @ed
	OR
	EqEndTime <= @st
	OR
	EqStartTime >= @et)
ORDER BY smEquipment.EquipmentID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEquipment_Avail] TO [MSDSL]
    AS [dbo];

