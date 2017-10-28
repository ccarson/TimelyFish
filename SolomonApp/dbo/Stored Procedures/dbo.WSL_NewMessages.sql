
CREATE PROCEDURE [dbo].[WSL_NewMessages]
 @page int
,@size int
,@sort nvarchar(200)
,@parm1 varchar(10) -- Employee ID
AS
	SET NOCOUNT ON
	DECLARE 
		@STMT nvarchar(max), 
		@lbound int,
		@ubound int,
		@SLUserID nvarchar(50)

	select @SLUserID = user_id from PJEMPLOY where employee = @parm1

	IF @sort = '' SET @sort = 'Status'

	IF @page = 0 -- No Paging
	BEGIN
		SET @STMT = '
			SELECT Subject, Message [Message Text], Caption1, Type1, Caption2, Type2, Caption3, Type3, MessageKey [Key], MessageType [Type],
			MessageSuffix [Suffix], Status
			FROM QQ_ComMessagesRetyped
			WHERE (destination = ' + QUOTENAME(@parm1, '''') + ' or destination = ' + QUOTENAME(@SLUserID, '''') + ')
			ORDER BY ' + @sort
	END
	ELSE -- Paging
	BEGIN
		IF @page < 1 SET @page = 1
		IF @size < 1 SET @size = 1
		SET @lbound = (@page-1) * @size
		SET @ubound = @page * @size + 1
		SET @STMT = '
			WITH PagingCTE AS
			(
			SELECT TOP(' + CONVERT(varchar(9), @ubound - 1) + ') 
			Subject, Message, Caption1, Type1, Caption2, Type2, Caption3, Type3, MessageKey [Key], MessageType [Type],
			MessageSuffix [Suffix], Status,
			ROW_NUMBER() OVER (ORDER BY ' + @sort + ') AS row
			FROM QQ_ComMessagesRetyped
			WHERE (destination = ' + QUOTENAME(@parm1, '''') + ' or destination = ' + QUOTENAME(@SLUserID, '''') + ')
			)
			SELECT Subject [Subject], Message [Message Text], [Caption1], [Type1],
			[Caption2], [Type2], [Caption3], [Type3], [Key], [Suffix], [Type], [Status]
			FROM PagingCTE
			WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
				   row <  ' + CONVERT(varchar(9), @ubound) + '
			ORDER BY row'
	END

	EXEC (@STMT)

