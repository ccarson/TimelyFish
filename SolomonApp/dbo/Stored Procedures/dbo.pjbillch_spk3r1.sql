 Create Procedure pjbillch_spk3r1 @parm1 varchar (10) , @parm2 varchar (10) , @parm3 varchar (24) , @parm4beg varchar (16) , @parm4end varchar (16) , @parm5 varchar (6), @parm6 varchar (10),
  @parm7 char(100)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from pjbillch, pjbill, pjproj
where    pjbillch.project          =    pjbill.project
and      pjbillch.project          =    pjproj.project
and      pjbillch.invoice_num      <>   @parm1
and      pjbill.biller             like @parm2
and      pjproj.gl_subacct         like @parm3
and      pjbillch.project       between @parm4beg and @parm4end
and      pjbillch.appnbr           =    @parm5
and		 pjbillch.cpnyID		   like	@parm6
and pjbillch.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm7))order by
pjbillch.project,
pjbillch.appnbr


