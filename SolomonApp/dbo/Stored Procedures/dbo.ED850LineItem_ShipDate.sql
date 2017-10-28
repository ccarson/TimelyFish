 CREATE Proc ED850LineItem_ShipDate @CpnyId varchar(10), @EDIPOID varchar(10) As
Select LineId From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And
ShipNBDate > ShipNLDate And ShipNLDate <> '01-01-1900'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_ShipDate] TO [MSDSL]
    AS [dbo];

