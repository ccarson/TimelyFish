
CREATE  VIEW cfvFeedOrderDelChg
	AS 
	SELECT *, DelChg = CASE  
			WHEN LoadPct > 1 THEN Round((BaseMileageRate * OneWayMiles)+(BaseDelChg),2)
			ELSE Round((BaseMileageRate * OneWayMiles * LoadPct)+(BaseDelChg*LoadPct),2)
			END
	FROM cfvFeedOrderDelChgBase

