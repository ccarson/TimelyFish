 Create Proc ED850SDQ_GetDfltDistShipToId @CpnyId varchar(10), @EDIPOID varchar(10), @CustId varchar(15) As
Select DistCenterShipToId From EDSTCustomer Where CustId = @CustId And ShipToId In (Select SolShipToId From ED850SDQ Where
CpnyId = @CpnyId And EDIPOID = @EDIPOID)


