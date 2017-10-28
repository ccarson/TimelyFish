
CREATE PROCEDURE dbo.cfpGetDTSConnectionSetting
@ConnectionName varchar(50)
,@SettingValue VARCHAR(150) OUTPUT
AS

SELECT 	@SettingValue = DTSConnectionValue
FROM 	dbo.cftDTSConnectionSetting (NOLOCK)
WHERE	DTSConnectionName = @ConnectionName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpGetDTSConnectionSetting] TO [MSDSL]
    AS [dbo];

