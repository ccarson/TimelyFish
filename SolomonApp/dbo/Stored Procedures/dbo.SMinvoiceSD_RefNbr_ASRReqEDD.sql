 Create Procedure SMinvoiceSD_RefNbr_ASRReqEDD @parm1 varchar(10) as
select sminvoice.* from smInvoice
join vs_asrreqedd on smInvoice.refnbr = vs_asrreqedd.InvNbr and vs_asrreqedd.DocType = 'S1'
where Refnbr like @parm1 and (smInvoice.DocType = 'S' and smInvoice. BillingType <> 'M') and refnbr <> ''
order by smInvoice.Refnbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMinvoiceSD_RefNbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

