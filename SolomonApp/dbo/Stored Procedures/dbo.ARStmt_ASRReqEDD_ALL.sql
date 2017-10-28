 /****** Object:  Stored Procedure dbo.ARStmt_ASRREQEDD_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARStmt_ASRReqEDD_ALL @parm1 varchar ( 2) as
    SELECT ARStmt.* 
    FROM ARStmt join vs_asrreqedd on ARStmt.stmtcycleid = vs_asrreqedd.stmtcycleid 
    WHERE ARStmt.StmtCycleId like @parm1 and vs_asrreqedd.doctype = 'A2'
    ORDER BY ARStmt.StmtCycleId

