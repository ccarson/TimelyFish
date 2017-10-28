
CREATE PROC getModulePeriod @Module VARCHAR(2), @show_select int
AS
		DECLARE @from_table	VARCHAR(7), @return_value INT
	IF @Module <> 'PA'	
	BEGIN
		SELECT @from_table = 
			CASE @Module
				WHEN 'AP' THEN 'APsetup'
				WHEN 'AR' THEN 'ARsetup'
				WHEN 'GL' THEN 'GLsetup'
				WHEN 'IN' THEN 'INsetup'
				WHEN 'PO' THEN 'APsetup'
				WHEN 'PR' THEN 'PRsetup'
				WHEN 'CA' THEN 'CAsetup'
				WHEN 'BR' THEN 'BRsetup'
				WHEN 'VP' THEN 'PRsetup'
				WHEN 'BM' THEN 'INsetup'
				WHEN 'CM' THEN 'GLsetup'
				WHEN 'MC' THEN 'GLsetup'
				WHEN 'OM' THEN 'ARsetup'
				WHEN 'SC' THEN 'ARsetup'
				WHEN 'SD' THEN 'ARsetup'
				WHEN 'WO' THEN 'INsetup'
				
				
			END
		EXEC('DECLARE c1 CURSOR FOR SELECT PerNbr FROM '+ @from_table) 
		OPEN c1
		FETCH c1 INTO @return_value
		CLOSE c1
		DEALLOCATE c1
	END
	ELSE
	BEGIN
		SELECT @return_value = control_data 
		FROM PJCONTRL 
		WHERE control_type = @Module 
			AND control_code = 'CURRENT-PERIOD'
	END
	IF @show_select = 1
		SELECT @return_value
	RETURN @return_value

GO
GRANT CONTROL
    ON OBJECT::[dbo].[getModulePeriod] TO [MSDSL]
    AS [dbo];

