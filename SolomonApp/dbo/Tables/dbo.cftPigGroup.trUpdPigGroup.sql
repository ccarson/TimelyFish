CREATE  TRIGGER trUpdPigGroup ON dbo.cftPigGroup 
FOR UPDATE
AS
SET NOCOUNT ON
BEGIN TRAN
IF UPDATE(PigGenderTypeID) 
BEGIN
Insert into cftPigGroupAudit
(AttributeName, Lupd_DateTime, Lupd_Prog, Lupd_User, OldValue, NewValue, 
PGStatusID, PigGroupID)

Select 'Gender', i.Lupd_DateTime, i.Lupd_Prog, i.Lupd_User, d.PigGenderTypeID,
i.PigGenderTypeID, pg.PGStatusID, pg.PigGroupID
from Inserted i 
JOIN cftPigGroup pg on i.PigGroupID=pg.PigGroupID
JOIN Deleted d on i.PigGroupID=d.PigGroupID
where i.PGStatusID='F'
END

IF UPDATE(PigProdPhaseID) 
BEGIN
Insert into cftPigGroupAudit
(AttributeName, Lupd_DateTime, Lupd_Prog, Lupd_User, OldValue, NewValue, 
PGStatusID, PigGroupID)

Select 'Phase', i.Lupd_DateTime, i.Lupd_Prog, i.Lupd_User, d.PigProdPhaseID,
i.PigProdPhaseID, pg.PGStatusID, pg.PigGroupID
from Inserted i 
JOIN cftPigGroup pg on i.PigGroupID=pg.PigGroupID
JOIN Deleted d on i.PigGroupID=d.PigGroupID
where i.PGStatusID='F'
END

IF UPDATE(EstStartWeight) 
BEGIN
Insert into cftPigGroupAudit
(AttributeName, Lupd_DateTime, Lupd_Prog, Lupd_User, OldValue, NewValue, 
PGStatusID, PigGroupID)

Select 'Est Start Wgt', i.Lupd_DateTime, i.Lupd_Prog, i.Lupd_User, d.EstStartWeight,
i.EstStartWeight, pg.PGStatusID, pg.PigGroupID
from Inserted i 
JOIN cftPigGroup pg on i.PigGroupID=pg.PigGroupID
JOIN Deleted d on i.PigGroupID=d.PigGroupID
where i.PGStatusID='F'
END

IF UPDATE(EstStartDate) 
BEGIN
Insert into cftPigGroupAudit
(AttributeName, Lupd_DateTime, Lupd_Prog, Lupd_User, OldValue, NewValue, 
PGStatusID, PigGroupID)

Select 'Est Start Date', i.Lupd_DateTime, i.Lupd_Prog, i.Lupd_User, 
convert(varchar(10),d.EstStartDate,101),
convert(varchar(10),i.EstStartDate,101), pg.PGStatusID, pg.PigGroupID
from Inserted i 
JOIN cftPigGroup pg on i.PigGroupID=pg.PigGroupID
JOIN Deleted d on i.PigGroupID=d.PigGroupID
where i.PGStatusID='F'
END

IF UPDATE(EstInventory) 
BEGIN
Insert into cftPigGroupAudit
(AttributeName, Lupd_DateTime, Lupd_Prog, Lupd_User, OldValue, NewValue, 
PGStatusID, PigGroupID)

Select 'Est Inventory', i.Lupd_DateTime, i.Lupd_Prog, i.Lupd_User, d.EstInventory,
i.EstInventory, pg.PGStatusID, pg.PigGroupID
from Inserted i 
JOIN cftPigGroup pg on i.PigGroupID=pg.PigGroupID
JOIN Deleted d on i.PigGroupID=d.PigGroupID
where i.PGStatusID='F'
END

COMMIT TRAN
SET NOCOUNT OFF
