 CREATE PROC SetRIWhere_sp @ri_id smallint, @tablename varchar(30) = ""
AS
	DECLARE	@ri_where	varchar(1024),
		@column		varchar(255)

	/*
	**  Modify the where clause in RptRunTime to restrict
	**  by the RI_ID
	*/
	SELECT	@ri_where = ""
	SELECT	@ri_where = ltrim(rtrim(RI_WHERE))
	FROM	RptRunTime
	WHERE	ri_id = @ri_id
	/*
	**  Append a period to the table name, if supplied.
	*/
	IF @tablename <> ""
		SELECT	@column = " {"+ltrim(rtrim(@tablename)) + ".RI_ID} = "
	ELSE
		SELECT	@column = " {RI_ID} = "

	/*
	**  Parse and modify the where
	*/
	IF ltrim(rtrim(@ri_where)) <> ""
		SELECT	@ri_where = @ri_where + " AND "

	SELECT	@ri_where = @ri_where + @column +ltrim(rtrim(str(@ri_id)))

	/*
	**  Update the table
	*/
	UPDATE	RptRunTime
	SET	RI_WHERE = @ri_where
	WHERE	ri_id = @ri_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SetRIWhere_sp] TO [MSDSL]
    AS [dbo];

