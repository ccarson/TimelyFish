 Create Procedure pjinvhdr_sall @parm1 varchar (10)  as
select * from pjinvhdr where draft_num like @parm1
order by draft_num


