create procedure CF020p_cftUserDefaults_All 
	as
	select * from cftUserDefaults
	order by UserID
