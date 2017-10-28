 /****** Object:  Stored Procedure dbo.Get_Incoming_Mail    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Get_Incoming_Mail as
Select * from ECEmail where MailType <> 'X' AND  MailType <> 'S'
order by EDate DESC


