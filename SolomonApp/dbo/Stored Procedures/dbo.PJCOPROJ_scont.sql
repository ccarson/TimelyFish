 create procedure PJCOPROJ_scont @parm1 varchar (16)   as
	select	pjproj.contract, pjproj.project, pjcoproj.status1,
pjcoproj.amt_funded, pjcoproj.amt_pending
	from 	pjproj, pjcoproj
	where	pjproj.contract =  @parm1 and
	                pjproj.project = pjcoproj.project and
(pjcoproj.status1 = 'A' or pjcoproj.status1 = 'P')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_scont] TO [MSDSL]
    AS [dbo];

