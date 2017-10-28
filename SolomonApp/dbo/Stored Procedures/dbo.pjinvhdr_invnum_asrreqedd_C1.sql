 Create Procedure pjinvhdr_invnum_asrreqedd_C1 @parm1 varchar(10) as
select pjinvhdr.* from pjinvhdr
join vs_asrreqedd on pjinvhdr.invoice_num = vs_asrreqedd.InvNbr and vs_asrreqedd.DocType = 'C1'
where invoice_num like @parm1 and invoice_num <> ''	
order by invoice_num


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_invnum_asrreqedd_C1] TO [MSDSL]
    AS [dbo];

