
Create Procedure WSL_ComMessagesList
@page int,
@size int,
@sort nvarchar(200),
@parm1 varchar(10) -- Destination (empID)
AS
	SET NOCOUNT ON
	DECLARE 
		@STMT nvarchar(max), 
		@lbound int,
		@ubound int,
		@SLUserID nvarchar(50)

	select @SLUserID = user_id from PJEMPLOY where employee = @parm1
	IF @sort = '' SET @sort = 'Status'

	IF @page = 0  -- Don't do paging
	BEGIN
		SET @page = 1
		SET @size = 32768
		SET @lbound = 0
		SET @ubound = 32769
	END		 
	ELSE
	BEGIN
		IF @page < 1 SET @page = 1
		IF @size < 1 SET @size = 1
		SET @lbound = (@page-1) * @size
		SET @ubound = @page * @size + 1
	END

	SET @STMT = '
		With PagingCTE AS
		(
		SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Status, Sender, Subject, Message, MessageKey, MessageSuffix, crtd_datetime,
		source_function, lupd_user, lupd_datetime, MessageType, Caption1, Type1, Caption2, Type2, Caption3, Type3,
		ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row
		FROM QQ_ComMessagesRetyped
		WHERE (destination = ' + QUOTENAME(@parm1, '''') + ' or destination = ' + QUOTENAME(@SLUserID, '''') + ')
		)
		SELECT [Status], [Sender], [Subject], [Message], [MessageKey], [MessageSuffix], [crtd_datetime], [source_function],	[lupd_user], [lupd_datetime],
		[MessageType], [Caption1], [Type1], [Caption2], [Type2], [Caption3], [Type3]
		FROM PagingCTE
		WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
				row <  ' + CONVERT(varchar(9), @ubound) + '
		ORDER BY row'
	EXEC(@STMT)
