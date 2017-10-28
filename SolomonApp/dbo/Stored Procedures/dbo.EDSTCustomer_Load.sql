 CREATE Proc EDSTCustomer_Load @CustId varchar(15), @Prog varchar(8), @User varchar(10) As
Declare @RowsInsertEd int
Insert Into EDSTCustomer (AddressType, Crtd_DateTime, Crtd_Prog, Crtd_User, CustId, DistCenterShipToId,
EdiDistCenterRef,EdiShipToRef, FSFlag, Lupd_DateTime, LUpd_prog, Lupd_user, MaxBillZone, RegionId,
S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShipToId, TerritoryId, User1, User10,
User2, User3, User4, User5, User6, User7, User8, User9) Select ' ',GetDate(),@Prog, @User,CustId,
' ',' ',' ',0,GetDate(),@Prog,@User,' ',' ',' ',' ',0,0,0,0,'01-01-1900','01-01-1900',0,0,
' ',' ',ShipToId,' ',' ','01-01-1900',' ',' ',' ',0,0,' ',' ','01-01-1900'
From SOAddress Where CustId = @CustId And ShipToId Not In (Select
ShipToId From EDSTCustomer Where CustId = @CustId)
Set @RowsInserted = @@RowCount
Select @RowsInserted



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSTCustomer_Load] TO [MSDSL]
    AS [dbo];

