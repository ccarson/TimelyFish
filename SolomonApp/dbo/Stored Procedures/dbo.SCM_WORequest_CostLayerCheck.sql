 CREATE Proc SCM_WORequest_CostLayerCheck  
 @InvtID  varchar( 30 ),  
 @SiteID  varchar( 10 ),  
 @OrdNbr  varchar( 15 ),  
 @LineRef varchar( 5 )  
   
AS  
SELECT		I.*
	FROM    WOBuildTo  W(NOLOCK) JOIN ItemCost I(NOLOCK) 
        ON  I.SpecificCostID =  W.SpecificCostId  AND
            I.SiteId = W.SiteId
    WHERE	W.OrdNbr = @OrdNbr and
            W.BuildtoLineRef = @LineRef And
            W.Status = 'P' and	
            I.InvtID = @InvtID and
			I.SiteID = @SiteId and
			I.LayerType = 'W' -- Special Work Order Layer


