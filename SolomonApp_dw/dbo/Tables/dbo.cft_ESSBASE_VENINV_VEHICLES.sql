CREATE TABLE [dbo].[cft_ESSBASE_VENINV_VEHICLES] (
    [VehicleRollup] CHAR (24) NOT NULL,
    [Location]      CHAR (16) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_VEHICLES] TO [SE\ssis_datareader]
    AS [dbo];

