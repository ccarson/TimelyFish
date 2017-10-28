--Returns a list of companies that the user has access to for a given screen.
CREATE PROCEDURE UserCompanyScreenAccess @screenNum char(7), @userId varchar(47)
AS
select adr.CompanyID
from vs_accessdetrights adr
left join vs_usergrp ug on adr.UserId = ug.GroupId and adr.RecType = 'G'
where adr.ScreenNumber = @screenNum and
( (adr.UserId = @userId and adr.RecType = 'U') or ug.UserId = @userId)
--Return [ALL] in the first row, if it exists, to make processing easier/faster
order by case when adr.CompanyID = '[ALL]' then 0 else 1 end


GO
GRANT CONTROL
    ON OBJECT::[dbo].[UserCompanyScreenAccess] TO [MSDSL]
    AS [dbo];

