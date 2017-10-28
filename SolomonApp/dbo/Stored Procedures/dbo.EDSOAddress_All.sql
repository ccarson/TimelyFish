 Create Proc EDSOAddress_All @Parm1 varchar(15), @Parm2 varchar(10) As Select * From SOAddress Where
CustId = @Parm1 And ShipToId Like @Parm2 Order By CustId, ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOAddress_All] TO [MSDSL]
    AS [dbo];

