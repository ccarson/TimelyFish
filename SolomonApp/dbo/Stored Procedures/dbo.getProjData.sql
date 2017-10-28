
CREATE PROCEDURE getProjData @dataType   VARCHAR(20),
                             @lookupData VARCHAR(20)
AS
    DECLARE @execState AS VARCHAR(256)

    SET @execState = CASE @dataType
                       WHEN 'BusinessManager' THEN 'SELECT project FROM PJPROJ WHERE manager2 = ''' + @lookupData + ''''
                       WHEN 'ProjectManager' THEN 'SELECT project FROM PJPROJ WHERE manager1 = ''' + @lookupData + ''''
                       WHEN 'Contract' THEN 'SELECT project FROM PJPROJ WHERE contract = ''' + @lookupData + ''''
                       WHEN 'Customer' THEN 'SELECT project FROM PJPROJ WHERE customer = ''' + @lookupData + ''''
                       WHEN 'Subaccount' THEN 'SELECT project FROM PJPROJ WHERE gl_subacct = ''' + @lookupData + ''''
                     END

	EXEC (@execState)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getProjData] TO [MSDSL]
    AS [dbo];

