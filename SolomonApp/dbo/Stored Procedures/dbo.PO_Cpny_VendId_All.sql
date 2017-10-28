 /****** Object:  Stored Procedure dbo.PO_Cpny_VendId_All    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure PO_Cpny_VendId_All @parm1 varchar ( 10), @parm2 varchar ( 15) As
        Select * from PurchOrd where
	CpnyID Like @parm1 And
	VendID = @parm2

        Order by VendId, PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PO_Cpny_VendId_All] TO [MSDSL]
    AS [dbo];

