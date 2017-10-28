
CREATE PROCEDURE [dbo].[PJINDSRC_projects] @parm1 varchar(4), @parm2 varchar(10) AS
select distinct PJINDSRC.project
 from PJINDSRC with (nolock)
  inner join PJPROJ with (nolock)
   on PJPROJ.Project = PJINDSRC.project and PJPROJ.CpnyId = @parm2
 where PJINDSRC.fsyear_num = @parm1
 order by PJINDSRC.project

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJINDSRC_projects] TO [MSDSL]
    AS [dbo];

