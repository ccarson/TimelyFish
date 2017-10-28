
CREATE PROCEDURE XDDBatch_PerPost_AP_PV
  	@PerPost	varchar( 6 ),
  	@VendID		varchar( 15 ),
  	@BatNbr		varchar( 10 )
AS

	declare @Query 	varchar( 255 )  
  
	select @Query = 'Select * from XDD_vs_CEM_PV Where PerPost >= ''' + @PerPost + ''' and VendID = ''' + @VendID + ''' and BatNbr LIKE ''' + @BatNbr + ''' order by BatNbr DESC'
-- print @Query
	execute(@Query)  

