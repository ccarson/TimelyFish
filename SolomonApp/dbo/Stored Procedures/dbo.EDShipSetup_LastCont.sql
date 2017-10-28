 Create Procedure EDShipSetup_LastCont As Select LastSerContainer From EDShipSetup Order BY SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipSetup_LastCont] TO [MSDSL]
    AS [dbo];

