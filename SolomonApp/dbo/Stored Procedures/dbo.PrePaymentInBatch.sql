
create proc PrePaymentInBatch
@parm1 varchar(10)


AS
Select ap.* from AP_PPApplic ap 
inner join APDoc d on ap.AdjdRefNbr = d.RefNbr 
where d.BatNbr = @parm1 and
ap.Crtd_Prog = '03070'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PrePaymentInBatch] TO [MSDSL]
    AS [dbo];

