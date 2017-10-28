CREATE PROCEDURE Customer_CustID_ASRReqEdd
	@parm1 varchar(2),
	@parm2 varchar(15)
	
AS

SELECT * from Customer
JOIN vs_asrreqedd ON Customer.CustID = vs_asrreqedd.CustID
WHERE vs_asrreqedd.DocType = @parm1 AND Customer.CustID like @parm2
ORDER BY Customer.CustID

