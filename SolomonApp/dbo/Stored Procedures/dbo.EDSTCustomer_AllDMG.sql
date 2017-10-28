 /****** Object:  Stored Procedure dbo.EDSTCustomer_All    Script Date: 5/28/99 1:17:46 PM ******/
CREATE Proc EDSTCustomer_AllDMG @Parm1 varchar(15), @Parm2 varchar(10) As Select * From EDSTCustomer
Where CustId = @Parm1 And ShipToId Like @Parm2 Order By CustId, ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSTCustomer_AllDMG] TO [MSDSL]
    AS [dbo];

