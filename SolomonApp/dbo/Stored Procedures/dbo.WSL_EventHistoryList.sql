
CREATE PROCEDURE WSL_EventHistoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID  varchar(10)  
 ,@OrdNbr  varchar(15)  
 ,@ShipperID varchar(15)  
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'EventID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT EventType [Event Type], ShipperID [Shipper ID], InvcNbr [Invoice Number], Descr [Description], UserID [User ID], EventDate [Event Date], EventTime [Event Time]
			 FROM SOEvent(nolock)
			  where CpnyID = ' + quotename(@CpnyID,'''') + '
				and OrdNbr like ' + quotename(@OrdNbr,'''') + '  
				and ShipperID like ' + quotename(@ShipperID,'''') + '  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') EventType, ShipperID, InvcNbr, Descr, UserID, EventDate, EventTime 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOEvent(nolock)
					where CpnyID = ' + quotename(@CpnyID,'''') + '
						and OrdNbr like ' + quotename(@OrdNbr,'''') + '  
						and ShipperID like ' + quotename(@ShipperID,'''') + '  
				) 
				SELECT EventType [Event Type], ShipperID [Shipper ID], InvcNbr [Invoice Number], Descr [Description], UserID [User ID], EventDate [Event Date], EventTime [Event Time]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
