
CREATE PROCEDURE pXFBinCertOrders

 AS 
 SELECT bn.*
	FROM cftBinCert bn
	JOIN cftFeedOrder f ON f.OrdNbr=bn.FeedOrdNbr 
	Where f.Status='C' AND bn.WithdrawalDate='1900-01-01' AND bn.VerfContactID<>''


