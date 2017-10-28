

CREATE    Procedure pXF190MaxRation
 	 @parm1 varchar(10),@parm2 varchar(10)
As
Select InvtId 
from cfvFeedPlanDefDet 
WHERE PigGroupID =@parm1 AND RoomNbr=@parm2
AND Stage = (Select Max(Stage) from cfvFeedPlanDefDet Where PigGroupID=@parm1 ANd RoomNbr=@parm2)





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF190MaxRation] TO [MSDSL]
    AS [dbo];

