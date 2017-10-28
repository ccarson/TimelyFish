





CREATE VIEW [dbo].[CFV_DeviceSyncStatus]
AS
SELECT  U.NAME AS 'UserDevice'
		, t.NAME AS 'TableName'
		, t.DESCRIPTION 'TableDesc'
		, COUNT(SI.INSTANCEIDGUID) AS 'NBRItemsSynced'
		, SI.SYNCDATE AS 'LastSync'
		
FROM            dbo.MF_SYNC_INFO AS SI WITH (NOLOCK) INNER JOIN
                         dbo.MF_USER AS U WITH (NOLOCK) ON SI.DBID = U.REMOTEDBID INNER JOIN
                         dbo.MF_META_OBJECT AS t WITH (Nolock) ON SI.TABLEID = t.ID INNER JOIN
                             (SELECT DBID, TABLEID, MAX(SYNCDATE) AS MaxSync
                               FROM            dbo.MF_SYNC_INFO AS MS WITH (NOLOCK)
                               GROUP BY DBID, TABLEID) AS MS_1 ON SI.DBID = MS_1.DBID AND SI.SYNCDATE = MS_1.MaxSync AND SI.TABLEID = MS_1.TABLEID
GROUP BY U.NAME, t.NAME, t.DESCRIPTION, SI.SYNCDATE





