 Create Proc SoShipHeader_Intran_InBatNbr
	@ShipperID Varchar(15)
As
     SELECT Count(S.InBatNbr)
	FROM SOShipHeader S JOIN INtran I ON I.BatNbr = S.INBatNbr
     WHERE s.Shipperid = @ShipperID And S.InBatNbr <> ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SoShipHeader_Intran_InBatNbr] TO [MSDSL]
    AS [dbo];

