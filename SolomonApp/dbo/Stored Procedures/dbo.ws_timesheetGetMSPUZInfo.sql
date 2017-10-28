
Create proc ws_timesheetGetMSPUZInfo @DocNbr VARCHAR(10)

AS

SELECT project, pjt_entity, employee, SubTask_Name, acct, fiscalno, system_cd, batch_id, detail_num, amount, units, trans_date
  FROM PJTRAN WITH(NOLOCK)
 WHERE system_cd = 'TM' 
   AND Project <> ''
   AND employee <> '' AND employee <> 'NONE'  
   AND batch_type = 'LABR'
   AND batch_id = @DocNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ws_timesheetGetMSPUZInfo] TO [MSDSL]
    AS [dbo];

