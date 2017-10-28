CREATE   Procedure pXF214DriverPV
	@parm1 As Char(6)
AS
Select c.*
From cftContact c 
Where c.ContactID LIke @parm1
