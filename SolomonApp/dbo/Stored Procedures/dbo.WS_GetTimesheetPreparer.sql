
CREATE proc WS_GetTimesheetPreparer 
@parm1 VarChar(10)
as  
  SELECT PJTIMHDR.preparer_id 
    FROM PJTIMHDR 
   WHERE PJTIMHDR.docnbr = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetTimesheetPreparer] TO [MSDSL]
    AS [dbo];

