 CREATE PROCEDURE
	smContract_LimitInfo
		@parm1	varchar(10)
AS
	SELECT
	        ContractID, ContractType, StartDate, ExpireDate, TotalAmt, BranchId,
	        Salesperson, PrimaryTech, SecondTech, Priority
	FROM
		smContract (NOLOCK)
	WHERE
		ContractID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_LimitInfo] TO [MSDSL]
    AS [dbo];

