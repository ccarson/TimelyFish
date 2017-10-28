
CREATE PROCEDURE EDSC_RebuildContainerLotSerNbr @CpnyID    VARCHAR(10),
                                                @ShipperID VARCHAR(15)
AS
  DECLARE @AutoGenContainer SMALLINT
  DECLARE @Active SMALLINT

  -- In order to updated the Container Information, we will need to 
  --		remove the existing containers and then rebuild them.
  SELECT @AutoGenContainer = AutoContainer,
         @Active = Active
  FROM   ANSetup

  IF @AutoGenContainer = 1
     AND @Active = 1
    BEGIN
        DELETE FROM EDContainer
        WHERE  ShipperID = @ShipperID
               AND CpnyID = @CpnyID

        DELETE FROM EDContainerDet
        WHERE  ShipperID = @ShipperID
               AND CpnyID = @CpnyID

        EXEC EDSC_Create
          @CpnyID,
          @ShipperID
    END

