
--*************************************************************
--	Purpose: Packer Eligibility Codes
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Certification			 
--	Parms: Code
--*************************************************************

CREATE   PROC pXF210Elig
	(@parm1 as varchar(3))
AS
Select * from cftEligCode 
where EligCode Like @parm1 




