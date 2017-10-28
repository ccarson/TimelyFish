
Create PROC ws_ProjectNotAvailToAllEmp @ProjectId VarChar(16)
AS
    SELECT Status_19,Project
      FROM PJProj
     WHERE Project = @ProjectId
       AND Status_19 = '1'

