 /****** Object:  Stored Procedure dbo.Account_COUNT_SummPostY    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Account_COUNT_SummPostY as
       Select count(Acct) from Account
           where SummPost = 'Y'


