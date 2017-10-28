 CREATE PROCEDURE IRNextShipperStep @NextFunctionID varchar(8), @NextClassID varchar(4), @CpnyID varchar(10), @ShipperID varchar(15) AS
Select * from soshipheader
where NextFunctionID = @NextFunctionID and NextFunctionClass = @NextClassID and CpnyID like @CpnyID and ShipperId like @ShipperID
order by CpnyID,ShipperID


