
CREATE PROCEDURE [dbo].[WSL_ScreenList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (2) -- Screen Type (SL for Rich Client app, WA for Web App)
 ,@parm2 varchar(7) -- Number
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@moduleFilter varchar(20) = ''
    
    IF @sort = '' SET @sort = 'Number'

	IF @parm1 = 'W' SET @moduleFilter = ' Module = ''MD'''
	ELSE SET @moduleFilter = ' Module <> ''MD'''

  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Number [Screen ID],  
			 Name [Screen Description],
			 ScreenType [Screen Type],
			 Module
			 FROM vs_Screen (nolock)
			 where Number like ' + quotename(@parm2,'''') + ' and
				 ' + @moduleFilter + '
			   and ScreenType IN (''s'', ''w'', ''r'')
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') 
				Number, 
				Name,
				ScreenType,
				Module,				  
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_Screen (nolock)
				WHERE Number like ' + quotename(@parm2,'''') + ' and
				 ' + @moduleFilter + '
	              and ScreenType IN (''s'', ''w'', ''r'')
				) 
				SELECT  Number [Screen ID], Name [Screen Description], ScreenType [Screen Type], Module
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

