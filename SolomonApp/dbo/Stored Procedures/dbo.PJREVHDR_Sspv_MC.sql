 create procedure PJREVHDR_Sspv_MC @parm1 varchar(16), @parm2 varchar(100), @parm3 varchar(4)
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
SELECT  PJREVHDR.*
 FROM PJREVHDR
     INNER JOIN PJPROJ
        ON PJPROJ.project = PJREVHDR.Project
 WHERE PJREVHDR.project LIKE @parm1
   AND pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2))
   AND PJREVHDR.revid LIKE @parm3
 ORDER BY PJREVHDR.project, PJREVHDR.revid
 
