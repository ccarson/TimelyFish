
CREATE PROC [dbo].[PJALLAUD_orphan] (
                @fiscalno VARCHAR (6),
                @system_cd VARCHAR (2),
                @batch_id VARCHAR (10),
                @detail_num int,
                @cpnyid VARCHAR (10),
                @alloc_method_cd VARCHAR (4) = '%',
                @project VARCHAR(16) = '%') AS

select PJALLAUD.*
from PJPROJ with (nolock)
inner join PJALLAUD with (nolock)
    on PJALLAUD.fiscalno = @fiscalno
      and PJALLAUD.system_cd = @system_cd
      and PJALLAUD.batch_id = @batch_id
      and PJALLAUD.detail_num = @detail_num
      and PJALLAUD.recalc_flag <> 'Y'
      and SUBSTRING(PJALLAUD.data2, 1, 16) = PJPROJ.project
-- apply any project criteria and the allocation method criteria
where PJPROJ.cpnyid = @cpnyid
  and PJPROJ.project like CASE @project WHEN '%' THEN '%' WHEN space(0) THEN '%' ELSE @project END
  and (PJPROJ.alloc_method_cd like @alloc_method_cd or pjproj.alloc_method2_cd like @alloc_method_cd)
  and not exists (select distinct PJALLSRT.project from PJALLSRT with (nolock) where PJALLSRT.project = PJPROJ.project)
  and not exists (select distinct PJALLGL.project from PJALLGL with (nolock) where PJALLGL.project = PJPROJ.project)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLAUD_orphan] TO [MSDSL]
    AS [dbo];

