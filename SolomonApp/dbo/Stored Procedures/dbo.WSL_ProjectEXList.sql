
CREATE PROCEDURE WSL_ProjectEXList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) --Employee
 ,@parm2 varchar (18) -- Project, with % before and after
 ,@parm3 varchar (60) -- Project Description
 ,@parm4 varchar (17) -- Customer ID, with % before and after
 ,@parm5 varchar (60) -- Customer Name
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@APSet nvarchar(1),
    @whereExpression nvarchar(180)
    
	set @APSet = (SELECT SUBSTRING(PJCONTRL.control_data,103,1) FROM PJCONTRL where PJCONTRL.control_code = 'SETUP' and PJCONTRL.control_type = 'TE')

	SET @whereExpression = ''

    IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
		SET @whereExpression = @whereExpression + ' AND PJPROJ.project LIKE ' + QUOTENAME(@parm2, '''');
	IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
		SET @whereExpression = @whereExpression + ' AND PJPROJ.project_desc LIKE ' + QUOTENAME(@parm3, '''');
	IF @parm4 IS NOT NULL AND LEN(@parm4) > 0 AND @parm4 <> '%'
		SET @whereExpression = @whereExpression + ' AND CUSTOMER.CustId LIKE ' + QUOTENAME(@parm4, '''');
    IF @parm5 IS NOT NULL AND LEN(@parm5) > 0 AND @parm5 <> '%'
		SET @whereExpression = @whereExpression + ' AND CUSTOMER.Name LIKE ' + QUOTENAME(@parm5, '''');
	IF @APSet = 'Y' 
		SET @whereExpression = @whereExpression + ' AND status_ap = ''A'' '

    IF @sort = ''
	BEGIN
		IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJPROJ.project'
		ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'PJPROJ.project_desc'
		ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'CUSTOMER.CustId'
		ELSE IF @parm5 IS NOT NULL AND LEN(@parm5) > 1 SET @sort = 'CUSTOMER.Name'
		ELSE SET @sort = 'PJPROJ.project'	
	END
	  
	IF @sort = 'Project' SET @sort = 'PJPROJ.project'
	ELSE IF @sort = 'Description' SET @sort = 'PJPROJ.project_desc'
	ELSE IF @sort = 'Customer' SET @sort = 'CUSTOMER.CustId'
	ELSE IF @sort = 'Name' SET @sort = 'CUSTOMER.Name'

  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT PJPROJ.project [Project], PJPROJ.project_desc [Description], PJPROJ.customer [Customer], ISNULL(Customer.Name, '''') AS Name, PJPROJ.cpnyid [Company]
			 FROM PJPROJ (nolock) LEFT OUTER JOIN Customer (nolock) ON Customer.CustId = PJPROJ.customer, PJPROJEM (nolock)
			 where PJPROJ.project = PJPROJEM.project and
			 (PJPROJEM.employee = ' + quotename(@parm1,'''') + ' or PJPROJEM.employee = ''*'')' +
			 @whereExpression +
			 ' and PJPROJ.status_pa = ''A''
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJPROJ.project, PJPROJ.project_desc, PJPROJ.customer, ISNULL(Customer.Name, '''') AS Name, PJPROJ.cpnyid  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJPROJ (nolock) LEFT OUTER JOIN Customer (nolock) ON Customer.CustId = PJPROJ.customer, PJPROJEM (nolock)
				where PJPROJ.project = PJPROJEM.project and
				(PJPROJEM.employee = ' + quotename(@parm1,'''') + ' or PJPROJEM.employee = ''*'')' +
				@whereExpression +
				' and PJPROJ.status_pa = ''A''
				) 
				SELECT PagingCTE.project [Project], PagingCTE.project_desc [Description], PagingCTE.customer [Customer], PagingCTE.Name [Name], PagingCTE.cpnyid [Company]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectEXList] TO [MSDSL]
    AS [dbo];

