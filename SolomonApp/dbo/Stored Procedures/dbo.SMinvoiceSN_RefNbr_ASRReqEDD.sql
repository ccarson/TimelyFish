 Create Procedure SMinvoiceSN_RefNbr_ASRReqEDD @parm1 varchar(10) as
select smInvoice.* from smInvoice
join vs_asrreqedd on smInvoice.Refnbr = vs_asrreqedd.InvNbr and vs_asrreqedd.DocType = 'T1'
where Refnbr like @parm1 and refnbr <> '' 
order by smInvoice.Refnbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMinvoiceSN_RefNbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

