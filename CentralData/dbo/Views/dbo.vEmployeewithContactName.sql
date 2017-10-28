
CREATE VIEW dbo.vEmployeewithContactName
AS
Select e.ContactID,e.EmployeeID, e.UserID, c.ContactName, FirstLastName=c.ContactFirstName + ' ' + c.ContactLastName from
	dbo.Employee e join dbo.Contact c on e.ContactID=c.ContactID

