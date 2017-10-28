


CREATE VIEW [QQ_SmServHistory]
AS
SELECT     h.ServiceCallID, s.CustomerId, CASE WHEN CHARINDEX('~' , s.CustName) > 0 THEN 
		      CONVERT (CHAR(60) , LTRIM(SUBSTRING(s.CustName, 1 , CHARINDEX('~' , s.CustName) - 1)) + ', ' + 
		      LTRIM(RTRIM(SUBSTRING(s.CustName, CHARINDEX('~' , s.CustName) + 1 , 60)))) ELSE s.CustName END As [Customer Name], 
		      s.ShiptoId As [Site ID], CASE WHEN CHARINDEX('~' , a.Name) > 0 THEN 
		      CONVERT (CHAR(60) , LTRIM(SUBSTRING(a.Name, 1 , CHARINDEX('~' , a.Name) - 1)) + ', ' + 
		      LTRIM(RTRIM(SUBSTRING(a.Name, CHARINDEX('~' , a.Name) + 1 , 60)))) ELSE a.Name END As [Site Customer Name], 
                      h.CallStatus, convert(date,h.ChangedDate) As [Date Changed], CONVERT(TIME,h.ChangedTime) As [Time Changed], h.UserID As [Changed By], 
		      s.cpnyid AS [Company ID], convert(date,h.Crtd_DateTime) As [Create Date], 
                      h.Crtd_Prog As [Create Program], h.Crtd_User AS [Create User], convert(date,h.Lupd_DateTime) As [Last Update Date], 
		      h.Lupd_Prog As [Last Update Program], h.Lupd_User As [Last Update User], h.NoteId,
                      h.User1, h.User2, h.User3, h.User4, h.User5, h.User6, 
                      convert(date,h.User7) AS [User7], convert(date,h.User8) AS [User8]
FROM		      smServHistory h with (nolock)
		      INNER JOIN smServCall s with (nolock) ON s.ServiceCallID = h.ServiceCallID
                      INNER JOIN SOAddress a with (nolock) ON a.ShipToId = s.ShiptoId and a.Custid = s.CustomerId
                      
