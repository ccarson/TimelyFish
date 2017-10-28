 Create Procedure EDSOShipline_CpnyShipCntr @CpnyId varchar(10), @ShipperId varchar(15), @ContainerID varchar(10)
As
--Select line information for a single container (w/out container info)
	Select *
	From SOShipLine
	Where 	CpnyID = @CpnyId And
		ShipperId = @ShipperId And
 		LineRef in (Select LineRef From EDContainerDet
             			Where	CpnyID = @CpnyID And
                   			ShipperID = @ShipperID And
                   			ContainerID = @ContainerID
	     			)--end select from edcontainerdet



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipline_CpnyShipCntr] TO [MSDSL]
    AS [dbo];

