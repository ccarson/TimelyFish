 --This proc provides the possible-value list of inventory sites for a particular
--shopper.
CREATE Procedure wcpv_ShipToID
	@CustID 	VARCHAR(15) = '%',
	@ShipToID 	VARCHAR(10) = '%'
As
		SELECT
		RTRIM(CustID) AS CustID,
		RTRIM(ShipToID) As ShipToID,
		RTRIM(Descr) As Descr
	FROM
		SOAddress (NOLOCK)
	WHERE
		CustID LIKE @CustID
		AND
		ShipTOID LIKE @ShipToID
	ORDER BY
		CustID,
		ShipToID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wcpv_ShipToID] TO [MSDSL]
    AS [dbo];

