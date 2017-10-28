 /****** Object:  Stored Procedure dbo.PO_Cpny_VendId_Status    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure PO_Cpny_VendId_Status @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar(1) As
        Select * from PurchOrd where
	CpnyID Like @parm1 And
	VendID = @parm2  And
	Status = @parm3

        Order by VendId, PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PO_Cpny_VendId_Status] TO [MSDSL]
    AS [dbo];

