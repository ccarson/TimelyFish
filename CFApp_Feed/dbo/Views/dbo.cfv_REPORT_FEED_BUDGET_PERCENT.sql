


CREATE VIEW [dbo].[cfv_REPORT_FEED_BUDGET_PERCENT]
AS
SELECT 
	  a.SiteContactID,
	  cftContact.ContactName Sitename,
      a.EstInventory,
      a.UseActualsFlag,
      a.PigGroupId,
      a.PigSystemID,      
      b.BarnNbr,
      b.BinNbr,
      b.DateDel,
	  b.DateReq,
      b.InvtIdDel,
      b.InvtIdOrd,
      b.OrdType,
      b.QtyDel,
      b.QtyOrd,
      b.RoomNbr,
      b.Status,
      c.CurrentInv,
      BudgetedLbsHead = ISNULL(d.LbsHead,0),
      e.BarnCapPercentage,

      ActualLbsHead = 
            CASE  WHEN (b.Status = 'C')
            THEN 
                  CASE  WHEN (a.UseActualsFlag = '1' AND ISNULL(c.CurrentInv,0) = 0) OR (a.UseActualsFlag <> '1' AND ISNULL(a.EstInventory,0) = 0)
                  THEN  0
                  ELSE
                        ISNULL(b.QtyDel,0)
                        /
                        CASE  WHEN (a.UseActualsFlag = '1')
                                          THEN
                                                CASE  WHEN (e.BarnCapPercentage is null)
                                                THEN  ISNULL(c.CurrentInv,0)
                                                ELSE  (ISNULL(c.CurrentInv,0)*e.barncappercentage)
                                                END
                        ELSE  
                                                CASE  WHEN (e.barncappercentage is null)
                                                THEN  ISNULL(a.EstInventory,0)
                                                ELSE  (ISNULL(a.EstInventory,0)*e.barncappercentage)
                                                END
                        END
                  END
            ELSE
                  ISNULL(b.QtyOrd,0) * 2000
                  /
                  CASE  WHEN (a.UseActualsFlag = '1' AND ISNULL(c.CurrentInv,0) = 0) OR (a.UseActualsFlag <> '1' AND ISNULL(a.EstInventory,0) = 0)
                  THEN  0
                  ELSE
                        CASE  WHEN (a.UseActualsFlag = '1')
                        THEN  
                                          CASE  WHEN (e.Barncappercentage is null)
                                          THEN ISNULL(c.CurrentInv,0)
                                          ELSE (ISNULL(c.CurrentInv,0)*e.barncappercentage)
                                          END
                                    ELSE  
                                          CASE  WHEN (e.Barncappercentage is null)
                                          THEN ISNULL(a.EstInventory,0)
                                          ELSE (ISNULL(a.EstInventory,0)*e.barncappercentage)
                                          END
                        END
                  END
            END


FROM [$(SolomonApp)].dbo.cftPigGroup a (NOLOCK)
JOIN [$(SolomonApp)].dbo.cftFeedOrder b (NOLOCK)
      ON a.PigGroupId = b.PigGroupId
LEFT JOIN [$(SolomonApp)].dbo.cfvCurrentInv c (NOLOCK)
      ON a.TaskId = c.TaskId
LEFT JOIN [$(SolomonApp)].dbo.cftFeedPlanDet d (NOLOCK)
      ON (b.InvtIdOrd = d.InvtId
      AND b.FeedPlanId = d.FeedPlanId)
left join [$(CentralData)].dbo.Room e (NOLOCK)
      ON (b.RoomNbr = e.RoomNbr
      AND RTRIM(b.ContactId) = e.ContactId)
LEFT JOIN [$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON CAST(RTRIM(cftContact.ContactID) AS INT) = CAST(RTRIM(a.SiteContactID) AS INT)
WHERE (a.PGStatusId = 'F' or a.PGStatusId = 'A')
AND   a.PigProdPhaseId in ('NUR','WTF')
GROUP BY
	  a.SiteContactID,
	  cftContact.ContactName,
      a.EstInventory,
      a.UseActualsFlag,
      a.PigGroupId,
      a.PigSystemID,      
      b.BarnNbr,
      b.BinNbr,
      b.DateDel,
	  b.DateReq,
      b.InvtIdDel,
      b.InvtIdOrd,
      b.OrdType,
      b.QtyDel,
      b.QtyOrd,
      b.RoomNbr,
      b.Status,
      c.CurrentInv,
      d.LbsHead,
      e.BarnCapPercentage



