﻿ Create Procedure pjbillch_spk3f2 @parm1 varchar (1) , @parm2 varchar (10) , @parm3 varchar (24) , @parm4beg varchar (16) , @parm4end varchar (16) , @parm5 varchar (10) ,
  @parm6 varchar(100)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select COUNT(*) from pjbillch, pjbill, pjproj
where    pjbillch.project          =    pjbill.project
and      pjbillch.project          =    pjproj.project
and      pjbillch.status           =    @parm1
and      pjbill.biller             like @parm2
and      pjproj.gl_subacct         like @parm3
and      pjbillch.project       between @parm4beg and @parm4end
and		 pjbillch.cpnyID			like	@parm5
and		pjbillch.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm6))

