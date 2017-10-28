
-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 6/10/2011
-- Description:	Takes multiple sire lines at the same sow site and fy period and puts them in a single string.
-- ===================================================================
	CREATE FUNCTION dbo.cffn_SOW_FLOW_SIRE_LINE 
	( 
		@PigFlowID VARCHAR(32)
	   ,@GroupPeriod VARCHAR(32) 
	) 
	RETURNS VARCHAR(8000) 
	AS 
	BEGIN 
		DECLARE @r VARCHAR(8000) 
		SELECT @r = ISNULL(@r+',', '') + rtrim(SireLine) 
			FROM  dbo.cft_LOAD_TABLE_SOW_FLOW_SIRE_LINE
			WHERE PigFlowID = @PigFlowID
			and GroupPeriod = @GroupPeriod 
		RETURN @r 
	END 

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_SOW_FLOW_SIRE_LINE] TO [db_sp_exec]
    AS [dbo];

