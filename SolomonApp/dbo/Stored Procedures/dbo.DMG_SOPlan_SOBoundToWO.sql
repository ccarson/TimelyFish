 CREATE PROCEDURE DMG_SOPlan_SOBoundToWO
   	@CpnyID           varchar(10),
	@WONbr            Varchar(16),
	@WOBTLineRef      varchar(5)
AS
	IF PATINDEX('%[%]%', @WOBTLineRef) > 0
		SELECT            CpnyID, SOOrdNbr, SOLineRef, SOSchedRef
		FROM              SOPlan
		WHERE             Cpnyid = @CpnyID and
		                  WONbr = @WONbr and
		                  WOBTLineRef + '' LIKE @WOBTLineRef and
		                  SOOrdNbr <> '' and
		                  SOLineRef <> '' and
		                  PlanType IN ('54')		-- SO Bound to WO
		ORDER BY          CpnyID, WONbr, WOBTLineRef
	ELSE
		SELECT            CpnyID, SOOrdNbr, SOLineRef, SOSchedRef
		FROM              SOPlan
		WHERE             Cpnyid = @CpnyID and
		                  WONbr = @WONbr and
		                  WOBTLineRef = @WOBTLineRef and
		                  SOOrdNbr <> '' and
		                  SOLineRef <> '' and
		                  PlanType IN ('54')		-- SO Bound to WO
		ORDER BY          CpnyID, WONbr, WOBTLineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOPlan_SOBoundToWO] TO [MSDSL]
    AS [dbo];

