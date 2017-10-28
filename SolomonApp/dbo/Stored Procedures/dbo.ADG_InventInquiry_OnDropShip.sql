 create proc ADG_InventInquiry_OnDropShip
	@CpnyID 	VARCHAR(10),
	@InvtID		VARCHAR(30)
as
    SELECT Purorddet.*
             FROM PurchOrd P, PurOrdDet
             WHERE InvtId = @InvtId AND
                   OpenLine = 1 AND
                   PurOrdDet.QtyOrd <> 0 AND
                   PurOrdDet.PONbr = P.PONbr AND
		   	 P.POType = 'DP' AND
                   P.CpnyID LIKE @CpnyID
            ORDER BY PurOrdDet.InvtId, PurOrdDet.PONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventInquiry_OnDropShip] TO [MSDSL]
    AS [dbo];

