 Create Proc EDInbound_850875ConvMeth @Parm1 varchar(15) As Select ConvMeth From EDInbound
Where CustId = @Parm1 And Trans In ('850','875') Order By CustId, Trans



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInbound_850875ConvMeth] TO [MSDSL]
    AS [dbo];

