
CREATE PROCEDURE [dbo].[PJPROJ_IndirectGrp] @parm1 CHAR(1), @parm2 VARCHAR(4), @parm3 VARCHAR(6) AS
-- Get a unique list of projects that use a project allocation method that's linked to this gl allocation group id (indirect group)
select distinct PJPROJ.project
from PJPROJ with (nolock)
inner join PJALLOC with (nolock)
    on (PJALLOC.alloc_method_cd = PJPROJ.alloc_method_cd
        or PJALLOC.alloc_method_cd = PJPROJ.alloc_method2_cd)
inner join PJINDSRC with (nolock)
    on PJINDSRC.fsyear_num = @parm2
      and PJINDSRC.project = PJPROJ.project
left join PJvPJACCT_IndirectGrps with (nolock)
    on PJvPJACCT_IndirectGrps.acct = dbo.PJfMask_acct(PJALLOC.post_acct, PJINDSRC.src_acct)
      and CASE WHEN @parm1 = 'Y' THEN PJvPJACCT_IndirectGrps.ytd_indirectgrp ELSE PJvPJACCT_IndirectGrps.ptd_indirectgrp END = @parm3
where CASE WHEN @parm1 = 'Y' THEN PJALLOC.ytd_indirectgrp ELSE PJALLOC.ptd_indirectgrp END = @parm3
    or isnull(CASE WHEN @parm1 = 'Y' THEN PJvPJACCT_IndirectGrps.ytd_indirectgrp ELSE PJvPJACCT_IndirectGrps.ptd_indirectgrp END, space(0)) = @parm3


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_IndirectGrp] TO [MSDSL]
    AS [dbo];

