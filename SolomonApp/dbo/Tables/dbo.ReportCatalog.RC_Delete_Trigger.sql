CREATE TRIGGER RC_Delete_Trigger
ON ReportCatalog
FOR DELETE
AS 
   DELETE RC_ReportUsage FROM deleted del WHERE RC_ReportUsage.REPORT_ID = del.DEX_ROW_ID
   DELETE RC_ReportCenterAssignments FROM deleted del WHERE RC_ReportCenterAssignments.REPORT_ID = del.DEX_ROW_ID
   DELETE RC_ReportRoleAssignments FROM deleted del WHERE RC_ReportRoleAssignments.REPORT_ID = del.DEX_ROW_ID