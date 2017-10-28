
CREATE PROCEDURE [dbo].[ALLOCGRP_ACTPTD] @Company VARCHAR(10), @AllocGroup VARCHAR(6) AS
select *
from AllocGrp
where CpnyId like @Company
 and GrpId like @AllocGroup
 and allocmthd = 'AP'
order by CpnyId, GrpId

