 CREATE PROCEDURE RptCompany_DeadCleanup AS
	delete from RptCompany where ri_id NOT IN (select ri_id from rptruntime)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptCompany_DeadCleanup] TO [MSDSL]
    AS [dbo];

