
Create Procedure ARDoc_RefNbr_ASRReqEDD @parm1 varchar ( 10) as
    Select ARDoc.* from ARDoc 
    join vs_asrreqedd on ardoc.refnbr = vs_asrreqedd.invnbr and vs_asrreqedd.doctype = 'A1'
    where RefNbr like @parm1 and RefNbr <> ''
    order by RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_RefNbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

