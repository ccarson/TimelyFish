CREATE Proc dbo.cftPigInvTranType_p2
		

as
	Select * from dbo.cftPigInvTranType
	Order by PigInvTranTypeID
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftPigInvTranType_p2] TO [MSDSL]
    AS [dbo];

