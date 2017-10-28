 CREATE PROCEDURE
	smSiteGroupDet_Customer_SOAddress
		@parm1 	varchar(10),
		@parm2  varchar(15),
		@parm3  varchar(10)
AS
	SELECT
		*
	FROM
		smSiteGroupDet
		JOIN Customer on smSiteGroupDet.CustID = Customer.CustId
		JOIN SOAddress on smSiteGroupDet.CustID = SOAddress.CustID AND smSiteGroupDet.CustSiteID = SOAddress.ShipToId
		
	WHERE
		smSiteGroupDet.CustSiteGroupID = @parm1
		AND smSiteGroupDet.CustID like @parm2
		AND smSiteGroupDet.CustSiteID like @parm3
	ORDER BY
		smSiteGroupDet.CustSiteGroupID,
		smSiteGroupDet.CustID,
		smSiteGroupDet.CustSiteID

