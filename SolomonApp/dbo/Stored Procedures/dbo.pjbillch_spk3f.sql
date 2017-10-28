 create Procedure pjbillch_spk3f @parm1 varchar (1) , @parm2 varchar (10) , @parm3 varchar (24) , @parm4 varchar (10), @parm5 varchar(100), @parm6 varchar (16)
  
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
  
select * from pjbillch, pjbill, pjproj
where pjbillch.project =    pjbill.project
and pjbillch.project   =    pjproj.project
and pjbillch.status    =    @parm1
and pjbill.biller      like @parm2
and pjproj.gl_subacct  like @parm3
and pjbillch.cpnyID	   like @parm4
and pjbillch.project   like @parm6
and		pjbillch.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm5))
order by
pjbillch.project,
pjbillch.appnbr


