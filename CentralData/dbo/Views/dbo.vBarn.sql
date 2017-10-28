CREATE VIEW dbo.vBarn
AS
SELECT     dbo.Barn.BarnID, dbo.Barn.ContactID, dbo.Barn.BarnNbr, dbo.Barn.FacilityTypeID,StatusTypeID,dbo.Barn.StdCap,  dbo.Barn.MaxCap
FROM         dbo.Barn INNER JOIN
                      dbo.Site ON dbo.Barn.ContactID = dbo.Site.ContactID
		where Barn.StatusTypeID=1 
UNION 
SELECT dbo.Room.RoomID, dbo.Room.ContactID , dbo.Room.RoomNbr, dbo.Room.FacilityTypeID, dbo.Room.StatusTypeID, dbo.Barn.StdCap*BarnCapPercentage as StdCap, dbo.Barn.MaxCap*BarnCapPercentage as MaxCap
FROM dbo.Room 
Inner Join dbo.Site on dbo.Room.ContactID=dbo.Site.ContactID
JOIN dbo.Barn on dbo.Room.BarnID=dbo.Barn.BarnID
where Barn.StatusTypeID=1 and Room.StatusTypeID=1
