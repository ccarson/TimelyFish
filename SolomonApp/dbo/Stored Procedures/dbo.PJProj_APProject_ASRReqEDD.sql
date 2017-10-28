 /****** Object:  Stored Procedure dbo.PJProj_APProject_ASRReqEDD    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure PJProj_APProject_ASRReqEDD @parm1 varchar ( 15) as
SELECT * 
FROM pjproj join vs_asrreqedd on pjproj.project = vs_asrreqedd.APProject And vs_asrreqedd.Doctype = 'U1' 
WHERE pjproj.project like @parm1 and PJProj.Project <> ''
ORDER BY PJProj.Project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJProj_APProject_ASRReqEDD] TO [MSDSL]
    AS [dbo];

