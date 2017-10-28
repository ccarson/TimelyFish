
CREATE PROCEDURE WSL_SiteByCompanyList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID 
 ,@parm2 varchar (10) -- SiteID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID, SiteID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Site.SiteId [Site], Site.Name [Name]
			 FROM Site(nolock)
			 Where CpnyID = ' + quotename(@parm1,'''') + ' 
			 and SiteID like ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Site.SiteId, Site.Name
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Site(nolock)
					Where CpnyID = ' + quotename(@parm1,'''') + ' 
					and SiteID like ' + quotename(@parm2,'''') + ' 
				) 
				SELECT SiteId [Site], Name [Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SiteByCompanyList] TO [MSDSL]
    AS [dbo];

