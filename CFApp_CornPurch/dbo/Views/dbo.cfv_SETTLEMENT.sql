
CREATE view [dbo].[cfv_SETTLEMENT]
as
SELECT	cft_settlement.*
,	delivery_vendor.name 'Delivery_VendorName'
FROM cft_settlement cft_settlement (NOLOCK)
LEFT OUTER JOIN dbo.cft_Vendor Delivery_Vendor (NOLOCK)
	ON	RTRIM(Delivery_Vendor.VendID) = RTRIM(cft_Settlement.Delivery_VendorID)
