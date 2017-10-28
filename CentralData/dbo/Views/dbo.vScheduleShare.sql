Create View dbo.vScheduleShare
AS 
SELECT     rc.RelatedID
FROM          dbo.RelatedContact rc INNER JOIN
                       dbo.RelatedContactDetail rcd ON rc.RelatedContactID = rcd.RelatedContactID
WHERE     (rcd.RelatedContactRelationshipTypeID = 22)
