 Create Proc ShipToIdAR_Descr @parm1 varchar (10), @parm2 varchar (15) as
    Select Descr from SOAddress where ShipToID = @parm1 and custid = @parm2 order by ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ShipToIdAR_Descr] TO [MSDSL]
    AS [dbo];

