 CREATE PROCEDURE DMG_SOPlan_SOBoundToPO
   	@CpnyID           varchar(10),
	@PONbr            Varchar(10),
	@POLineRef        varchar(5)
AS
	IF PATINDEX('%[%]%', @POLineRef) > 0
		SELECT            CpnyID, SOOrdNbr, SOLineRef, SOSchedRef
		FROM              SOPlan
		WHERE             Cpnyid = @CpnyID and
		                  PONbr = @PONbr and
	        	          POLineRef + '' LIKE @POLineRef and
		                  SOOrdNbr <> '' and
		                  SOLineRef <> '' and
	        	          PlanType IN ('50','52')
		ORDER BY          CpnyID, PONbr, POLineRef
	ELSE
		SELECT            CpnyID, SOOrdNbr, SOLineRef, SOSchedRef
		FROM              SOPlan
		WHERE             Cpnyid = @CpnyID and
		                  PONbr = @PONbr and
	        	          POLineRef = @POLineRef and
		                  SOOrdNbr <> '' and
		                  SOLineRef <> '' and
	        	          PlanType IN ('50','52')
		ORDER BY          CpnyID, PONbr, POLineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOPlan_SOBoundToPO] TO [MSDSL]
    AS [dbo];

