
CREATE PROCEDURE [dbo].[WSL_ProjectBudget]
  @page  int
,@size  int
,@sort   nvarchar(200)
,@parm1 varchar (16) -- Project
,@parm2 varchar(20) -- Direct Or Revision
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Project, Task, [Acct Cat]'
         
  IF @page = 0  -- Don't do paging
         BEGIN
             SET @STMT = 
                    'SELECT Project, Task, [Task Description], [Acct Cat], [Description], [Original Budget Units], [Rate], 
                    [Original Budget Amount], [EAC Units], [EAC Amount], [FAC Units], [FAC Amount], Noteid 
                     FROM QQ_pjbudgets (nolock)
                    where QQ_pjbudgets.project = ' + quotename(@parm1,'''') + ' AND [Budget Type] = ' + quotename(@parm2, '''') + '
                    ORDER BY ' + @sort
         END        
  ELSE
         BEGIN
                    IF @page < 1 SET @page = 1
                    IF @size < 1 SET @size = 1
                    SET @lbound = (@page-1) * @size
                    SET @ubound = @page * @size + 1
                    SET @STMT = 
                           'WITH PagingCTE AS
                           (
                           SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Project, Task, [Task Description], [Acct Cat], [Description], [Original Budget Units], [Rate], 
                    [Original Budget Amount], [EAC Units], [EAC Amount], [FAC Units], [FAC Amount], Noteid 
                           ,ROW_NUMBER() OVER(
                           ORDER BY ' + @sort + ') AS row
                           FROM QQ_pjbudgets (nolock)
                           where QQ_pjbudgets.project = ' + quotename(@parm1,'''') + ' AND [Budget Type] = ' + quotename(@parm2, '''') + '
                           ) 
                           SELECT Project, Task, [Task Description], [Acct Cat], [Description], [Original Budget Units], [Rate], 
                    [Original Budget Amount], [EAC Units], [EAC Amount], [FAC Units], [FAC Amount], Noteid 
                           FROM PagingCTE                     
                           WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
                                    row <  ' + CONVERT(varchar(9), @ubound) + '
                           ORDER BY row'
         END                      
  EXEC (@STMT) 



