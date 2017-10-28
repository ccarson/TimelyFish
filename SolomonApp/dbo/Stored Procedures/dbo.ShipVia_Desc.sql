 /****** Object:  Stored Procedure dbo.ShipVia_Desc                                             ******/
Create Proc ShipVia_Desc @Parm1 VarChar(30) as
	Select Descr from ShipVia Where ShipViaID = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ShipVia_Desc] TO [MSDSL]
    AS [dbo];

