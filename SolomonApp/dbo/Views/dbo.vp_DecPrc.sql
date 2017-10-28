 

Create View vp_DecPrc
AS
	Select	COALESCE((Select DecPl From Currncy Where CuryID = GLSetup.BaseCuryID), INSetup.DecPlPrcCst) As DecPlPrcCst,
		INSetup.DecPlQty
		From	INSetup, GLSetup

 
