 Create Proc  RptCompany_Cleanup @parm1 smallint as
DELETE FROM RptCompany WHERE RI_ID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptCompany_Cleanup] TO [MSDSL]
    AS [dbo];

