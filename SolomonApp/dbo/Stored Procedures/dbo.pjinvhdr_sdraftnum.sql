 Create Procedure pjinvhdr_sdraftnum @parm1 varchar (16), @parm2 varchar (10) as
select pjinvhdr.*, customer.name, pjproj.* from pjinvhdr, customer, pjproj
where pjinvhdr.project_billwith like @parm1
and pjinvhdr.draft_num = @parm2
and pjinvhdr.inv_status in ('PO', 'PR')
and pjinvhdr.customer = customer.custid
and pjinvhdr.project_billwith = pjproj.project
order by draft_num


