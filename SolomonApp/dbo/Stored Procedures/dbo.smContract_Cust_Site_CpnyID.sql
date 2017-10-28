 CREATE PROCEDURE smContract_Cust_Site_CpnyID
	@parm1 varchar(15)
	,@parm2 varchar(10)
	,@parm3 varchar(10)
	,@parm4 varchar(10)
AS
SELECT *
FROM smContract
	left outer join soAddress
		on SoAddress.ShipToId = smContract.SiteId
		and SoAddress.CustId = smContract.CustId
WHERE smContract.CustId = @parm1
	AND smContract.SiteId = @parm2
	AND smContract.CpnyID = @parm3
	AND smContract.ContractID LIKE @parm4
	AND smContract.Status = 'A'
ORDER BY smContract.CustId
	,smContract.SiteId
	,smContract.ContractID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Cust_Site_CpnyID] TO [MSDSL]
    AS [dbo];

