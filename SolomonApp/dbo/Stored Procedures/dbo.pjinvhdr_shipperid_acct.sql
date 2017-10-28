
Create Procedure pjinvhdr_shipperid_acct @parm1 varchar (16) , @parm2 varchar (15) as
select * from pjinvhdr where
project_billwith = @parm1 AND
shipperid Like @parm2 AND
invoice_type <> 'REVR' AND Invoice_type <> 'REVD'
order by invoice_num desc
