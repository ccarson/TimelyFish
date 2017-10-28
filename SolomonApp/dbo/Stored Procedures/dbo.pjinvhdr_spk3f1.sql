 Create Procedure pjinvhdr_spk3f1 @parm1 varchar (2) , @parm2 varchar (10) , @parm3 varchar (24), @parm4 varchar (10)  , @parm5beg varchar (10) , @parm5end varchar (10),
  @parm6 char(100)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from pjinvhdr, pjbill, pjproj
where    pjinvhdr.project_billwith =    pjbill.project
and      pjinvhdr.project_billwith =    pjproj.project
and	   pjinvhdr.doctype = 'IN'
and      pjinvhdr.inv_status       =    @parm1
and      pjbill.biller             like @parm2
and      pjproj.gl_subacct         like @parm3
and      pjinvhdr.cpnyid           like    @parm4
and      pjinvhdr.draft_num     between @parm5beg and @parm5end
and pjinvhdr.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm6))

order by pjinvhdr.draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk3f1] TO [MSDSL]
    AS [dbo];

