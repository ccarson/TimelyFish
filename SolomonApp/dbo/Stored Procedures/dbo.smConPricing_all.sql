 CREATE PROCEDURE smConPricing_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM smConPricing
		left outer join Inventory
			on smConPricing.Invtid = Inventory.Invtid
	WHERE ContractID LIKE @parm1
	   AND smConPricing.Invtid LIKE @parm2
	ORDER BY ContractID,
	   smConPricing.Invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPricing_all] TO [MSDSL]
    AS [dbo];

