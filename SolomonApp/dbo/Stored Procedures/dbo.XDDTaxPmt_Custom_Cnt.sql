
CREATE PROCEDURE XDDTaxPmt_Custom_Cnt

AS
   SELECT 	Count(*)
   FROM 	XDDTaXPmt (nolock)
   WHERE 	Selected = 'Y'
		and RecFormat = 'C'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTaxPmt_Custom_Cnt] TO [MSDSL]
    AS [dbo];

