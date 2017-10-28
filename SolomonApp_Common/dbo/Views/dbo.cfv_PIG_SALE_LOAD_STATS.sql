

-- drop view cfv_PIG_SALE_DEADS
CREATE VIEW [dbo].[cfv_PIG_SALE_LOAD_STATS]
AS

SELECT
psr.PMLoadId,
psr.PigGroupID,
psd.PkrContactId,
SUM(CASE WHEN psd.DetailTypeID = 'SS' THEN psd.Qty ELSE 0 END) AS Standards, 
SUM(CASE WHEN psd.DetailTypeID = 'DT' THEN psd.Qty ELSE 0 END) AS DeadOnArrival,
SUM(CASE WHEN psd.DetailTypeID = 'DY' THEN psd.Qty ELSE 0 END) AS DeadInYard,
SUM(CASE WHEN psd.DetailTypeID IN ('CD', 'CP') THEN psd.Qty ELSE 0 END) AS Condemns,
SUM(CASE WHEN psd.DetailTypeID = 'BO' THEN psd.Qty ELSE 0 END) AS Boars,
SUM(CASE WHEN psd.DetailTypeID = 'SB' THEN psd.Qty ELSE 0 END) AS Subjects,
SUM(CASE WHEN psd.DetailTypeID = 'AB' THEN psd.Qty ELSE 0 END) AS Abcess,
SUM(CASE WHEN psd.DetailTypeID = 'BB' THEN psd.Qty ELSE 0 END) AS BellyBust,
SUM(CASE WHEN psd.DetailTypeID = 'RR' THEN psd.Qty ELSE 0 END) AS RearRupture,
SUM(CASE WHEN psd.DetailTypeID = 'HV' THEN psd.Qty ELSE 0 END) AS Heavy,
SUM(CASE WHEN psd.DetailTypeID = 'LT' THEN psd.Qty ELSE 0 END) AS Lites,
SUM(CASE WHEN psd.DetailTypeID = 'IB' THEN psd.Qty ELSE 0 END) AS InsectBite,
SUM(CASE WHEN psd.DetailTypeID = 'TB' THEN psd.Qty ELSE 0 END) AS Tailbite,
SUM(CASE WHEN psd.DetailTypeID = 'LM' THEN psd.Qty ELSE 0 END) AS Lame,
SUM(CASE WHEN psd.DetailTypeID = 'PQ' THEN psd.Qty ELSE 0 END) AS PoorQuality,
SUM(CASE WHEN psd.DetailTypeID = 'OW' THEN psd.Qty ELSE 0 END) AS OpenWound,
SUM(CASE WHEN psd.DetailTypeID = 'MR' THEN psd.Qty ELSE 0 END) AS MiscReSale,
SUM(psd.Qty) AS PigQuantity,
SUM(psd.WgtLive) AS LoadWeight
FROM
dbo.cfvPIGSALEREV AS psr
INNER JOIN dbo.cftPSDetail AS psd WITH (NOLOCK)
ON psd.BatNbr = psr.BatNbr AND psd.RefNbr = psr.RefNbr
GROUP BY
psr.PMLoadId,
psr.PigGroupID,
psd.PkrContactId

