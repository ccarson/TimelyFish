 /****** Object:  Stored Procedure dbo.Customer_Custid_ASRReqEDD_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_CustID_ASRReqEDD_All @parm1 varchar ( 15) as
   SELECT * from Customer JOIN vs_asrreqedd ON Customer.CustId = vs_asrreqedd.CustID 
   WHERE Customer.CustId like @parm1 ORDER BY Customer.CustId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_CustID_ASRReqEDD_All] TO [MSDSL]
    AS [dbo];

