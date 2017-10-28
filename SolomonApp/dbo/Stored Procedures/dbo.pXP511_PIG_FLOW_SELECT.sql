

CREATE PROCEDURE [dbo].[pXP511_PIG_FLOW_SELECT]
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
BEGIN
                                SELECT [PigFlowID]
                                      , substring([PigFlowDescription] +'  '+ case when pigflowtodate is null then ' ' when pigflowtodate is not null then CONVERT(char(10),pigflowtodate, 101)   end,1,100) as [PigFlowDescription]  -- 2014-01-13 smr application code required column header
                                FROM CFApp_PigManagement.dbo.cft_PIG_FLOW (NOLOCK)
                                WHERE (PigFlowToDate IS NULL
              and len(PigFlowDescription) > 0)
       OR (PigFlowToDate >= dateadd(d,-180,getdate()) and len(PigFlowDescription) > 0)
                                ORDER BY PigFlowDescription asc
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP511_PIG_FLOW_SELECT] TO [MSDSL]
    AS [dbo];

