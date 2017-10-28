
CREATE PROCEDURE WSL_OrderTypeList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10) -- 
 ,@SOTypeID varchar(4) -- 
 ,@FunctionID varchar(8) -- 
 ,@FunctionClass varchar(4) -- 
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @CPSON int
    
    IF (select COUNT(*) from INSetup(nolock)) > 0
     Begin
		SET @CPSON = (select CPSOnOff from INSetUp (NoLock))
     End
    Else
     Begin
		SET @CPSON = (select case when count(*) > 0 then 1  else 0 end from SOSetup (nolock))
	 End
        
    IF @sort = '' SET @sort = 'SOType.CpnyID, SOType.SOTypeID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOType.SOTypeID [Order Type], SOType.Descr [Description]'
			IF @CPSON = 1
			 BEGIN
				SET @STMT = @STMT + 
				'FROM SOType, SOStep(nolock)
				where SOType.CpnyID = SOStep.CpnyID AND SOType.SOTypeID = SOStep.SOTypeID AND SOStep.FunctionID = ' + quotename(@FunctionID,'''') + ' AND SOStep.FunctionClass = ' + quotename(@FunctionClass,'''') + ' AND SOType.CpnyID LIKE ' + quotename(@CpnyID,'''') + ' AND SOType.SOTypeID LIKE ' + quotename(@SOTypeID,'''') + ' AND SOType.Active = 1 AND SOType.Behavior <> ''MO'''
			 END
			 ELSE
			 BEGIN
				SET @STMT = @STMT + ', SOType.Active [Active]
				FROM SOType(nolock)
				WHERE CpnyID LIKE ' + quotename(@CpnyID,'''') + ' AND SOTypeID LIKE ' + quotename(@SOTypeID,'''')
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOType.SOTypeID, SOType.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row '
			IF @CPSON = 1
			 BEGIN
				SET @STMT = @STMT + 
				'FROM SOType, SOStep(nolock)
				where SOType.CpnyID = SOStep.CpnyID AND SOType.SOTypeID = SOStep.SOTypeID AND SOStep.FunctionID = ' + quotename(@FunctionID,'''') + ' AND SOStep.FunctionClass = ' + quotename(@FunctionClass,'''') + ' AND SOType.CpnyID LIKE ' + quotename(@CpnyID,'''') + ' AND SOType.SOTypeID LIKE ' + quotename(@SOTypeID,'''') + ' AND SOType.Active = 1 AND SOType.Behavior <> ''MO'''
			 END
			 ELSE
			 BEGIN
				SET @STMT = @STMT + ', SOType.Active
				FROM SOType(nolock)
				WHERE CpnyID LIKE ' + quotename(@CpnyID,'''') + ' AND SOTypeID LIKE ' + quotename(@SOTypeID,'''')
			 END
			 SET @STMT = @STMT + ')
				SELECT SOTypeID [Order Type], Descr [Description]'
			 IF @CPSON = 0
			  BEGIN
				SET @STMT = @STMT + ', Active [Active]'
			  END
			 SET @STMT = @STMT + '
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_OrderTypeList] TO [MSDSL]
    AS [dbo];

