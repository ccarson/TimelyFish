 create procedure PJPROJEM_sik1 @parm1 varchar (10)  as
select pjprojem.*, pjproj.project_desc, pjproj.MSPInterface, pjproj.mspproj_id from pjprojem, pjproj
where  pjprojem.project = pjproj.project and
       pjprojem.employee like @parm1
order by pjprojem.project, pjprojem.employee


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sik1] TO [MSDSL]
    AS [dbo];

