
CREATE proc WS_GetTimesheetPreparerByDetail 
@parm1 VarChar(10),  --Project
@parm2 VarChar(32),  --Task
@parm3 VarChar(10),  --Employee
@parm4 VarChar(8) -- Date coming as String value

as  
  SELECT PJTIMHDR.preparer_id 
    FROM PJTIMHDR JOIN PJTIMDET 
                    ON PJTIMHDR.docnbr = PJTIMDET.docnbr
   WHERE PJTIMDET.project = @parm1
     AND PJTIMDET.pjt_entity = @parm2
     AND PJTIMDET.employee = @parm3
     AND PJTIMDET.tl_date = CAST(@parm4 AS Datetime)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetTimesheetPreparerByDetail] TO [MSDSL]
    AS [dbo];

