 /****** Object:  Stored Procedure dbo.APHist_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APHist_All @parm1 varchar ( 15), @parm2 varchar ( 4) as
Select * from APHist where VendId like @parm1
and FiscYr like @parm2
order by VendId,FiscYr


