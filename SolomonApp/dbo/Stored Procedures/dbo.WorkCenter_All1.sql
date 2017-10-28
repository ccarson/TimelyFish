 Create Proc WorkCenter_All1 @parm1 varchar ( 10) as
       SELECT *
         FROM WorkCenter
        WHERE WorkCenterId like @parm1
          AND (PFLbrOvhRate <> 0 OR PFMachOvhRate <> 0 OR PLbrOvhRate <> 0
               OR PMachOvhRate <> 0 OR PVLbrOvhRate <> 0 OR PVMachOvhRate <> 0)
        ORDER BY WorkCenterId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkCenter_All1] TO [MSDSL]
    AS [dbo];

