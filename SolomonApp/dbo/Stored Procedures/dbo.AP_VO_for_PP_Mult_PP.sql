
 CREATE PROCEDURE [dbo].[AP_VO_for_PP_Mult_PP]
	@VendId varchar(15),
	@CuryId varchar(4),
	@VOBatNbrForPP VarChar(10),
	@RefNbr VarChar(10)

AS

SELECT * FROM APDoc WHERE Status='A' AND VendID LIKE @VendID AND CuryId LIKE @CuryId AND BatNbr = @VOBatNbrForPP AND Rlsed=0 and DocType in ('VO','AC')  AND DocBal>0 AND RefNbr LIKE @RefNbr ORDER BY RefNbr

