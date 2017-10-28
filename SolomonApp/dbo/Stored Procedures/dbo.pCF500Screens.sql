CREATE  Proc [dbo].[pCF500Screens]
	@parm1 varchar ( 7) 
		
		-- Added Execute As to handle SL Integrated Security method -- TJones 3/13/2012
		WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

		AS
       	Select * from cfvScreens sv
        where sv.ScreenType = 'S' and (sv.Module = 'CF' or sv.Module like 'X%')
	AND sv.Number LIKE @parm1
        order by sv.Number


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF500Screens] TO [MSDSL]
    AS [dbo];

