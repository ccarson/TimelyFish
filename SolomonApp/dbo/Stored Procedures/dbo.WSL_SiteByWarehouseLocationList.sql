
CREATE PROCEDURE WSL_SiteByWarehouseLocationList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10) -- 
 ,@SiteID varchar(10) -- 
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @INInstalled int
    
    IF @sort = '' SET @sort = 'Site.SiteID'
	  
	SET @INInstalled = (SELECT count(*) FROM INSetup WITH(NOLOCK) WHERE Init = 1)
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Site.SiteID [Site], Site.Name [Name], Site.Addr1 [Address], Site.City [City], Site.State [State]'
			IF @INInstalled > 0
			 BEGIN
				SET @STMT = @STMT +
				'FROM Site, LocTable(nolock)
				 Where Loctable.SiteID = Site.SiteID AND LocTable.SalesValid <> ''N'' AND Site.CpnyID = ' + quotename(@CpnyID,'''') + ' AND Site.SiteID LIKE ' + quotename(@SiteID,'''')			  			 
			 END
			ELSE
			 BEGIN
				SET @STMT = @STMT +
				'FROM Site(nolock)
				 Where CpnyID = ' + quotename(@CpnyID,'''') + ' AND SiteID LIKE ' + quotename(@SiteID,'''')
			 END
			SET @STMT = @STMT + 
  			 'ORDER BY ' + @sort
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Site.SiteID, Site.Name, Site.Addr1, Site.City, Site.State
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row '
			IF @INInstalled > 0
			 BEGIN
				SET @STMT = @STMT +
				'FROM Site, LocTable(nolock)
				 Where Loctable.SiteID = Site.SiteID AND LocTable.SalesValid <> ''N'' AND Site.CpnyID = ' + quotename(@CpnyID,'''') + ' AND Site.SiteID LIKE ' + quotename(@SiteID,'''')			  			 
			 END
			ELSE
			 BEGIN
				SET @STMT = @STMT +
				'FROM Site(nolock)
				 Where CpnyID = ' + quotename(@CpnyID,'''') + ' AND SiteID LIKE ' + quotename(@SiteID,'''')
			 END
			SET @STMT = @STMT + '
				) 
				SELECT SiteID [Site], Name [Name], Addr1 [Address], City [City], State [State]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SiteByWarehouseLocationList] TO [MSDSL]
    AS [dbo];

