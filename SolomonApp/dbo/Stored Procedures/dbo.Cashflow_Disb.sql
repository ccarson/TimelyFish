 /****** Object:  Stored Procedure dbo.Cashflow_Disb    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc Cashflow_Disb  as
    Select * from Cashflow where AntDisb  <> 0
    Order by RcptDisbDate


