

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

CREATE	Proc pCF511_FeedPaylean
	@parm1 varchar(10)

as
	Select f.*
	From cftFeedOrder as f
	LEFT JOIN cftPigGroup g on f.PigGroupID=g.PigGroupID
	WHERE f.PigGroupId=@parm1 AND Left(f.InvtIdDel,2)='07' AND QtyDel>0
	Order by f.OrdNbr Desc 


 
