 Create Proc ShipViaIdAR_Descr @parm1 varchar ( 15) as
    Select Descr from ShipVia where ShipviaID = @parm1 order by ShipviaID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ShipViaIdAR_Descr] TO [MSDSL]
    AS [dbo];

