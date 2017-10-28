 /****** Object:  Stored Procedure dbo.Get_Outgoing_Mail    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Get_Outgoing_Mail as
Select * from ECEmail where MailType = 'X' OR MailType = 'S'
order by EDate DESC


