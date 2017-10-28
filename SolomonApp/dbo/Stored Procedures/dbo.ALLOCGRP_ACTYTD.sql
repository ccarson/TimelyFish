 /****** Object:  Stored Procedure dbo.ALLOCGRP_ACTYTD    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc ALLOCGRP_ACTYTD @Company varchar ( 10),@AllocGroup varchar ( 6) as
       Select * from AllocGrp
           where CpnyId like @Company
             and GrpId like @AllocGroup
             and allocmthd = 'AY'
           order by CpnyId, GrpId


