 CREATE PROCEDURE IRPlanOrd_all
	@parm1 varchar( 15 )
AS
	SELECT *
	FROM IRPlanOrd
	WHERE PlanOrdNbr LIKE @parm1
	ORDER BY PlanOrdNbr


