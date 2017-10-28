CREATE TABLE [dbo].[SowSite] (
    [ContactID] INT      NOT NULL,
    [WeanDay1]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay1] DEFAULT (0) NOT NULL,
    [WeanDay2]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay2] DEFAULT (0) NOT NULL,
    [WeanDay3]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay3] DEFAULT (0) NOT NULL,
    [WeanDay4]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay4] DEFAULT (0) NOT NULL,
    [WeanDay5]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay5] DEFAULT (0) NOT NULL,
    [WeanDay6]  SMALLINT CONSTRAINT [DF_SowSite_WeanDay6] DEFAULT (0) NOT NULL,
    [WeanRows]  SMALLINT NULL,
    CONSTRAINT [PK_SowSite] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsSowSite ON [dbo].[SowSite] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSowSite
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DfltWeanQty,DfltSystem,
Lupd_DateTime,Lupd_Prog,Lupd_User,
NoteID,
WeanDay1,WeanDay2,WeanDay3,WeanDay4,WeanDay5,WeanDay6,WeanRows)

Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
0,'00',
getdate(),'','SYSADMIN',0,
isnull(WeanDay1,0),isnull(WeanDay2,0),isnull(WeanDay3,0),
isnull(WeanDay4,0),isnull(WeanDay5,0),isnull(WeanDay6,0),
isnull(WeanRows,0)
	FROM Inserted

GO
CREATE TRIGGER trDelSowSite ON [dbo].[SowSite] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftSowSite
FROM [$(SolomonApp)].dbo.cftSowSite a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

GO
CREATE TRIGGER trUpdSowSite ON [dbo].[SowSite] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftSowSite
FROM [$(SolomonApp)].dbo.cftSowSite a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

Insert into [$(SolomonApp)].dbo.cftSowSite
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DfltWeanQty,DfltSystem,
Lupd_DateTime,Lupd_Prog,Lupd_User,
NoteID,
WeanDay1,WeanDay2,WeanDay3,WeanDay4,WeanDay5,WeanDay6,WeanRows)

Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
0,'00',
getdate(),'','SYSADMIN',0,
isnull(WeanDay1,0),isnull(WeanDay2,0),isnull(WeanDay3,0),
isnull(WeanDay4,0),isnull(WeanDay5,0),isnull(WeanDay6,0),
isnull(WeanRows,0)
	FROM Inserted


COMMIT TRAN


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Monday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tuesday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Wednesday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Thursday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Friday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Saturday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SowSite', @level2type = N'COLUMN', @level2name = N'WeanDay6';

