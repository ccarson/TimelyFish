
/****** Object:  Stored Procedure dbo.pCF511Trans    Script Date: 9/6/2005 8:29:25 AM ******/
/****** Object:  Stored Procedure dbo.pCF511Trans    Script Date: 9/1/2005 3:56:16 PM ******/

CREATE         Procedure [dbo].[pCF511Trans]
	@parm1 varchar(10)

as
	Select pm.DestPigGroupID, d.ContactName, pm.EstimatedQty, pm.MovementDate, pm.PigTypeID, pm.PMID,  pm.SourcePigGroupID, s.ContactName, t.ContactName
	From cftPm pm WITH (NOLOCK)
	JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
	JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
	JOIN cftContact t WITH (NOLOCK) on pm.TruckerContactID=t.ContactID
	WHERE SourcePigGroupID=@parm1 OR DestPigGroupID=@parm1 
	and (pm.Highlight <> 255 and pm.Highlight <> -65536)
	Order by pm.MovementDate
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511Trans] TO [MSDSL]
    AS [dbo];

