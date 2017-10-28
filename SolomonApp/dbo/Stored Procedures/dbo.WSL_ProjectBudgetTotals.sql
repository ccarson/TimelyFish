
CREATE PROCEDURE [dbo].[WSL_ProjectBudgetTotals]
  @page  int
,@size  int
,@sort   nvarchar(200)
,@parm1 varchar (16) -- Project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    -- Sort ignored
       -- Paging ignored (only two rows returned).
         
SELECT * FROM QQ_pjbudgettotals (nolock) where QQ_pjbudgettotals.project = @parm1


