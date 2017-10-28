 create procedure PJPROJ_spurge as
SELECT * from PJPROJ
WHERE status_pa = 'D'
ORDER BY project

