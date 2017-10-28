 CREATE Proc EDDecimalPlaces As
Declare @DecPlPrcCst smallint
Declare @DecPlQty smallint
Select @DecPlPrcCst = DecPlPrcCst From EDSetup
Select @DecPlQty = DecPlQty From INSetup
Select @DecPlPrcCst, @DecPlQty


