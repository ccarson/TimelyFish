CREATE TRIGGER trInsRelatedContact ON [dbo].[RelatedContact] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftRelatedContact
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
RelatedContactID,
SummaryOfDetail
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
RelatedContactID=replicate('0',6-len(rtrim(convert(char(6),RelatedID))))
	 + rtrim(convert(char(6),RelatedID)),
isnull(SummaryOfDetail,'')
	FROM Inserted

GO
CREATE TRIGGER trDelRelatedContact ON [dbo].[RelatedContact] 
FOR DELETE
AS
Delete a
FROM [$(SolomonApp)].dbo.cftRelatedContact a
JOIN Deleted d on 
a.RelatedContactID=replicate('0',6-len(rtrim(convert(char(6),d.RelatedID))))
	 + rtrim(convert(char(6),d.RelatedID)) 
and 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 

GO
CREATE TRIGGER trUpdRelatedContact ON [dbo].[RelatedContact] 
FOR UPDATE
AS
BEGIN TRAN
Delete a
FROM [$(SolomonApp)].dbo.cftRelatedContact a
JOIN Deleted d on 
a.RelatedContactID=replicate('0',6-len(rtrim(convert(char(6),d.RelatedID))))
	 + rtrim(convert(char(6),d.RelatedID)) 
and 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 

Insert into [$(SolomonApp)].dbo.cftRelatedContact
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
RelatedContactID,
SummaryOfDetail
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
RelatedContactID=replicate('0',6-len(rtrim(convert(char(6),RelatedID))))
	 + rtrim(convert(char(6),RelatedID)),
isnull(SummaryOfDetail,'')
	FROM Inserted
COMMIT TRAN
