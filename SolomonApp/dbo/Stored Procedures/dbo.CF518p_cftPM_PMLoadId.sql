
--5/25/07 Dkillion Mantis ticket 310
--Added this additional filter to prevent 'red' highlighted rows from appearing in this stored procedure

CREATE Procedure CF518p_cftPM_PMLoadId @parm1 varchar (6) as 
    Select * from cftPM Join cftContact on cftPM.sourcecontactID=cftContact.ContactID 
 and PMID Like @parm1
and cftpm.highlight not in ('255')
	Order by PMID
