
CREATE PROCEDURE WSL_BillOfMaterialSiteList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- KitID
 ,@parm2 varchar (10) -- SiteID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Kit.SiteID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Kit.SiteID [Site ID], Site.Name [Name] 
			 FROM Kit(nolock), Site(nolock)
			 where KitID = ' + quotename(@parm1,'''') + ' 
			 and Kit.Status = ''A''
			 and Kit.KitType = ''B''
			 and Kit.ExpKitDet = ''1''
			 and Kit.SiteID LIKE ' + QUOTENAME(@parm2,'''') + '
			 and Site.SiteID = Kit.SiteID
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Kit.SiteID, Site.Name
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Kit(nolock), Site(nolock)
					where KitID = ' + quotename(@parm1,'''') + ' 
					and Kit.Status = ''A''
					and Kit.KitType = ''B''
					and Kit.ExpKitDet = ''1''
					and Kit.SiteID LIKE ' + QUOTENAME(@parm2,'''') + '
					and Site.SiteID = Kit.SiteID
				) 
				SELECT SiteID [Site ID], Name [Name] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
