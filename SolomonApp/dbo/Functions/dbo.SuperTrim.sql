
CREATE FUNCTION SuperTrim (@fieldtotest char(255))
Returns varchar(255)
as
Begin
	declare @ReturnString varchar(255)
	select @ReturnString=rtrim(substring (@fieldtotest,patindex('%[^ 0]%',@fieldtotest),
	                 len(@fieldtotest)-patindex('%[^ 0]%',@fieldtotest)+1))
	Return (@ReturnString)
End
