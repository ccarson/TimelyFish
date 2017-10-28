 /****** Object:  Stored Procedure dbo.Close_Cust_Doc_StmtCycle3    Script Date: 4/7/98 12:30:33 PM ******/
Create proc Close_Cust_Doc_StmtCycle3 @parm1 smalldatetime, @parm2 varchar(10), @parm3 varchar(6) As
        UPDATE ARDoc SET ARDoc.StmtDate = @parm1,
  		ARDoc.StmtBal = ARDoc.DocBal,
        ARDoc.CuryStmtBal = ARDoc.CuryDocBal
        WHERE ARDoc.CustId = @parm2
        AND ARDoc.Rlsed = 1
        AND ARDoc.StmtDate = ''
        AND ARDoc.PerPost <= @parm3


