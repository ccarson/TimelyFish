CREATE VIEW vABRA_JobTitle (JobCode, JobTitle)
AS
select code, [desc]  from 
	OPENQUERY(ABRADATA,'Select * from HRTables')
	WHERE [Table] = 'JC'
	AND Code Not In('_ENT_','')
