 Create Proc EDShipperConfirm @CpnyId varchar(10), @ShipperId varchar(15) As
Declare @ManifestUpdated smallint
EXEC EDContainer_UpdateManifest @CpnyId, @ShipperId, @ManifestUpdated output
Select @ManifestUpdated



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipperConfirm] TO [MSDSL]
    AS [dbo];

