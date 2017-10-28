

CREATE TRIGGER [dbo].[trInsPM] ON [dbo].[cftPM] 
FOR INSERT
AS
Set nocount on
BEGIN TRAN


Update cftPM
set PMID=replicate('0',6-len(rtrim(convert(char(6),d.ID))))
	 + rtrim(convert(char(6),d.ID)),
PMLoadID=replicate('0',6-len(rtrim(convert(char(6),d.ID))))
	 + rtrim(convert(char(6),d.ID))
FROM cftPM a
JOIN Inserted d on 
a.ID=d.ID

--COMMIT TRAN  2011-11-4  sripley commented out line.  Failing during solomon testing of 2000 to 2008 upgrade

INSERT INTO SolomonApp.dbo.cftPMChanges (PMID, PMLoadID,PrevMovementDate, ChangeDate)
SELECT a.PMID, a.PMLoadID, a.MovementDate,GETDATE() 
FROM cftPM a (nolock) JOIN Inserted d on 
a.ID=d.ID

COMMIT TRAN 

set nocount off


