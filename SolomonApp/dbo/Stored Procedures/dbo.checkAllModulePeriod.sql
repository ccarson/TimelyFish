
CREATE PROC checkAllModulePeriod
AS
	DECLARE @return_value INT, @temp_period INT, @temp_count INT

	SELECT @return_value = 0
	EXEC @temp_period = getModulePeriod 'GL', 0
	EXEC @temp_count = checkModulePeriod 'GL', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'AP', 0
	EXEC @temp_count = checkModulePeriod 'AP', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'AR', 0
	EXEC @temp_count = checkModulePeriod 'AR', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'IN', 0
	EXEC @temp_count = checkModulePeriod 'IN', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'PO', 0
	EXEC @temp_count = checkModulePeriod 'PO', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'PR', 0
	EXEC @temp_count = checkModulePeriod 'PR', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'CA', 0
	EXEC @temp_count = checkModulePeriod 'CA', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1

	EXEC @temp_period = getModulePeriod 'BR', 0
	EXEC @temp_count = checkModulePeriod 'BR', @temp_period, 0
	IF @temp_count > 0
		SELECT @return_value = 1
	
	SELECT @return_value

GO
GRANT CONTROL
    ON OBJECT::[dbo].[checkAllModulePeriod] TO [MSDSL]
    AS [dbo];

