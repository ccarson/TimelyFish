
CREATE PROC checkAllModuleYear
AS
	DECLARE @return_value INT, @temp_year INT, @temp_count INT

	SELECT @return_value = 0
	EXEC @temp_year = getModulePeriod 'GL', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'GL', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'AP', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'AP', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'AR', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'AR', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'IN', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'IN', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'PO', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'PO', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'PR', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_year = checkModuleYear 'PR', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'CA', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'CA', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_year = getModulePeriod 'BR', 0
	SELECT @temp_year = @temp_year/100
	EXEC @temp_count = checkModuleYear 'BR', @temp_year, 0
	IF @temp_count > 0
		SELECT @return_value = 1
	
	SELECT @return_value

GO
GRANT CONTROL
    ON OBJECT::[dbo].[checkAllModuleYear] TO [MSDSL]
    AS [dbo];

