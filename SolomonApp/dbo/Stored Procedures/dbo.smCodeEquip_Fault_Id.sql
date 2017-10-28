 CREATE PROCEDURE smCodeEquip_Fault_Id
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smCodeEquip
	left outer join smEqUsage
		on smCodeEquip.UsageID = smEqUsage.UsageID
WHERE Fault_Id = @parm1
	AND smCodeEquip.UsageID LIKE @parm2
ORDER BY smCodeEquip.Fault_Id, smCodeEquip.UsageID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCodeEquip_Fault_Id] TO [MSDSL]
    AS [dbo];

