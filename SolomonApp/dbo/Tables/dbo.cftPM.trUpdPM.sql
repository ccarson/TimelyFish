




-- =============================================
-- Author:	mdawson
-- Create date: 09/14/2008
-- Description:	track changes made to movementdate or destination site
-- Update: 04/25/2011 ddahle -- added estimated qty and changed date
-- update: 12/12/2011 sripley -- added update to cftpm table, only if the actualqty or actualwgt are changed.
-- =============================================
CREATE TRIGGER [dbo].[trUpdPM] ON [dbo].[cftPM] 
FOR UPDATE
AS
Set nocount on
BEGIN TRAN
 
  update cftpm
  set lupd_datetime = getdate(),
  lupd_prog = CASE When I.lupd_prog <> D.lupd_prog then I.lupd_prog else substring(host_name(),1,8) end,
  lupd_user = CASE When I.lupd_user <> D.lupd_user then I.lupd_user else substring(ORIGINAL_LOGIN(),1,10) end
  from inserted I (nolock)
	inner join deleted D (nolock) on D.id = I.id and D.linenbr = I.linenbr
    inner join cftpm pm (nolock) on pm.id = I.id and pm.linenbr = I.linenbr
  where (I.actualqty <> D.actualqty or I.actualwgt <> D.actualwgt)
   ;


INSERT INTO SolomonApp.dbo.cftPMChanges (PMID, PMLoadID, PrevMovementDate, PrevDestContactID, PrevEstimatedQty, ChangeDate)
SELECT Inserted.PMID, Inserted.PMLoadID, Deleted.MovementDate, Deleted.DestContactID, Deleted.EstimatedQty, GETDATE() 
FROM Inserted Inserted
JOIN Deleted Deleted 
	ON Deleted.PMID = Inserted.PMID
	AND Deleted.PMLoadID = Inserted.PMLoadID
WHERE Inserted.MovementDate <> deleted.MovementDate
OR Inserted.DestContactID <> deleted.DestContactID
OR Inserted.EstimatedQty <> deleted.EstimatedQty

IF UPDATE(actualqty) 
BEGIN

insert into cftDataAudit
([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
select 'cftpm:  Actualqty chg', getdate(),substring(program_name,1,50), substring(original_login_name,1,10), inserted.actualqty,inserted.id
from sys.dm_exec_sessions
cross join deleted deleted
join Inserted Inserted 
	ON Deleted.PMID = Inserted.PMID
	AND Deleted.PMLoadID = Inserted.PMLoadID
where session_id = @@spid

END



COMMIT TRAN
set nocount off




