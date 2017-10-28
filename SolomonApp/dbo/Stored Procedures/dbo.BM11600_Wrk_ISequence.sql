 Create Proc BM11600_Wrk_ISequence @parm1 integer  as
            Select * from BM11600_Wrk where ISequence = @parm1
           Order by ISequence


