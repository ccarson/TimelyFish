 Create Procedure pjinvhdr_spk3rinv @parm1 varchar (10) , @parm2 varchar (10) , @parm3 varchar (24) , @parm4 varchar (10)  , @parm5 varchar (10)  as
select * from pjinvhdr, pjbill, pjproj
where    pjinvhdr.project_billwith =    pjbill.project
and      pjinvhdr.project_billwith =    pjproj.project
and      pjinvhdr.doctype = 'IN'
and      pjinvhdr.invoice_num      <>   @parm1
and      pjbill.biller             like @parm2
and      pjproj.gl_subacct         like @parm3
and      pjinvhdr.cpnyid           like @parm4
and      pjinvhdr.invoice_num      like @parm5
order by pjinvhdr.invoice_num DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk3rinv] TO [MSDSL]
    AS [dbo];

