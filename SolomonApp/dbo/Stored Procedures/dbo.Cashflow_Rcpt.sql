 /****** Object:  Stored Procedure dbo.Cashflow_Rcpt    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc Cashflow_Rcpt  as
    Select * from Cashflow where AntRcpt  <> 0
    Order by RcptDisbDate


