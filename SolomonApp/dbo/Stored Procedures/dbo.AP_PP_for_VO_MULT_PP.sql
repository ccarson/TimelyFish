
 CREATE PROCEDURE [dbo].[AP_PP_for_VO_MULT_PP]
	@CuryID VarChar(10),
	@RefNbr varchar(10),
	@PPRefNbr VarChar(10)
AS
SELECT  APAdjust.*
FROM APAdjust  join AP_PPApplic on AP_PPApplic.PrePay_RefNbr = Apadjust.AdjdRefNbr
WHERE AP_PPApplic.AdjdRefNbr = @CuryID and APAdjust.CuryAdjdCuryId = @RefNbr and AP_PPApplic.PrePay_RefNbr LIKE @PPRefNbr 
ORDER BY APAdjust.AdjdRefNbr

