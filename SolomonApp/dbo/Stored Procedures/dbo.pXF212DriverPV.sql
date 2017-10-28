CREATE   Procedure pXF212DriverPV
	@parm1 As varChar(6)
AS
Select c.*
From cftContact c 
Where c.ContactID Like @parm1 AND StatusTypeID='1'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212DriverPV] TO [MSDSL]
    AS [dbo];

