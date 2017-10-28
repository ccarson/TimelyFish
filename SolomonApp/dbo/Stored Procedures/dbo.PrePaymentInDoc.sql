
create proc PrePaymentInDoc
@parm1 varchar(10)


AS
Select ap.* from AP_PPApplic ap 
where ap.AdjdRefNbr = @parm1
and ap.Crtd_Prog = '03070'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PrePaymentInDoc] TO [MSDSL]
    AS [dbo];

