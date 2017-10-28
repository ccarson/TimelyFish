 Create Procedure pjinvhdr_spjtdraft @parm1 varchar (16), @parm2 varchar(10)  as
select * from pjinvhdr, pjproj where
pjinvhdr.project_billwith like @parm1
and pjinvhdr.draft_num like @parm2
and pjinvhdr.inv_status in ('PO', 'PR')
and pjinvhdr.project_billwith = pjproj.project
order by doctype, draft_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spjtdraft] TO [MSDSL]
    AS [dbo];

