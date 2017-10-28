
create proc Foreign_Currency_Project_Management_Activated
as

Select 
(case when
	(((select MCActivated from CMSetup) = 1) and 
	((select control_data from PJCONTRL where control_type = 'PA' and control_code = 'FOREIGN-CURRENCY-PROJECTS') = 'Y'))
		then 1
		else 0
	end) as Result


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Foreign_Currency_Project_Management_Activated] TO [MSDSL]
    AS [dbo];

