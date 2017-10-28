 Create Proc ED850MarkFor_GetDfltDistShipToId @CpnyId varchar(10), @EDIPOID varchar(10), @CustId varchar(15) As
Select DistCenterShipToId From EDSTCustomer Where CustId = @CustId And ShipToId In (Select ShipToId From ED850MarkFor Where
CpnyId = @CpnyId And EDIPOID = @EDIPOID)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850MarkFor_GetDfltDistShipToId] TO [MSDSL]
    AS [dbo];

