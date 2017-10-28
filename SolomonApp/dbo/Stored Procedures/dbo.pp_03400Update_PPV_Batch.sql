 CREATE PROCEDURE pp_03400Update_PPV_Batch
                 @UserAddress        VARCHAR(21) AS

/***** File Name: 0384pp_03400Update_PPV_Batch.Sql         *****/
/***** Last Modified by Mike Putnam on 12/07/98 at 4:13 pm *****/

    Update W
           Set W.PPVCount = Case When V.PPVCount > 0 Then 1 Else 0 End
           From WrkRelease_PO W, vp_03400_PPV_Batch_Needed V
           Where W.BatNbr = V.BatNbr
             And W.Module = V.JrnlType
             And W.UserAddress = @UserAddress




