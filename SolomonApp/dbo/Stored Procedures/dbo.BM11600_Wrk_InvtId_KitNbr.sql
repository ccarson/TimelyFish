 Create Proc BM11600_Wrk_InvtId_KitNbr @parm1 varchar ( 30), @parm2  integer  as
            Select * from BM11600_Wrk where InvtId = @parm1 And KitNbr = @parm2
           Order by InvtId, KitNbr


