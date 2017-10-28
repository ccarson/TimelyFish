

CREATE VIEW [dbo].[cfv_REPORT_FEED_BUDGET_PERCENT_ALL]
AS

SELECT distinct
        a.SiteContactID,
        cftContact.ContactName Sitename,
      a.EstInventory,
      a.PigGroupId,
        a.PigProdPhaseId,
      a.PigSystemID,
        a.PigGenderTypeID,
        a.PGStatusID,
      --b.BarnNbr,
      --b.BinNbr,
      --b.DateDel,
        --b.DateReq,
      --b.InvtIdDel,
      --b.InvtIdOrd,
      --b.OrdType,
      --fo.QtyDel,
      qty.qtydel,
      --fo.QtyOrd,
      qty.qtyord,
      lo.RoomNbr,
        FeedRep = sfr.FeedRepresentativeName,
        SvcMgr = SvcMgrContact.ContactName,
      fo.Status,
      c.CurrentInv,
      --BudgetedLbsHead = ISNULL(d.LbsHead,0),
      e.BarnCapPercentage,

        FeedPlanType = fpd.StdOrIndBudgetFlag, 
        DateSwitchedToIndPlan=(Select IsNull(Min(Convert(varchar(10),Crtd_DateTime,101)),'N/A')
                              FROM [$(SolomonApp)].dbo.cftFeedPlanInd (nolock)
                              WHERE PigGroupID = a.PigGroupID 
                              AND RoomNbr = lo.RoomNbr),
        CalcCurWgt = IsNull(pm.CalcCurWgt,0),
      ActStartWgt = case when v.qty <> 0 then v.Twgt/v.qty else 0 end,
        AvgPriorFeed = case when pr.NumberOfOrders <> 0 then pr.PriorFeed/pr.NumberOfOrders else 0 end,
        StartQty = v.Qty, 

        UseActuals = a.UseActualsFlag,
        PigSystem = ps.Description, 
        LastRationOrd = IsNull((Select TOP 1 InvtIDOrd 
                              FROM [$(SolomonApp)].dbo.cftFeedOrder (nolock)
                              WHERE PigGroupID = a.PigGroupID 
                              AND RoomNbr = lo.RoomNbr     
                              AND Status not in ('X','C')
                              AND Reversal <> '1'
                              ORDER BY StageOrd DESC, DateReq DESC ),'N/A'),
        LastRationDel = fo.InvtIdDel,
        fpd.PriorFeedQty,

      ActualLbsHead = 
            CASE  WHEN (fo.Status = 'C')
            THEN 
                  CASE  WHEN (a.UseActualsFlag = '1' AND ISNULL(c.CurrentInv,0) = 0) OR (a.UseActualsFlag <> '1' AND ISNULL(a.EstInventory,0) = 0)
                  THEN  0
                  ELSE
                        ISNULL(qty.QtyDel,0)
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
                  ISNULL(qty.QtyOrd,0) * 2000
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
            END,
        BudgetedLbPerHead = case when (Select Sum(IsNull(LbsHead,0)) BudgetedLbPerHead
                        FROM [$(SolomonApp)].dbo.cfvFeedPlanDefDet 
                        WHERE PigGroupID = a.piggroupid
                        and RoomNbr = fo.RoomNbr
                        and InvtID = fo.InvtIdDel                       
                        group by PigGroupID, RoomNbr, InvtID) is null
                        then (select sum(isnull(lbshead,0)) BudgetLbPerHead
                        from [$(SolomonApp)].dbo.cftFeedPlanDet
                        where invtid=fo.invtiddel
                        and feedplanid=fo.feedplanid
                        group by invtid) 
                        else (Select Sum(IsNull(LbsHead,0)) BudgetedLbPerHead
                        FROM [$(SolomonApp)].dbo.cfvFeedPlanDefDet 
                        WHERE PigGroupID = a.piggroupid
                        and RoomNbr = fo.RoomNbr
                        and InvtID = fo.InvtIdDel                       
                        group by PigGroupID, RoomNbr, InvtID) end, 
      PctBudgetComplete =     
            CASE  WHEN (fo.Status = 'C')
            THEN 
                  CASE  WHEN (a.UseActualsFlag = '1' AND ISNULL(c.CurrentInv,0) = 0) OR (a.UseActualsFlag <> '1' AND ISNULL(a.EstInventory,0) = 0)
                  THEN  0
                  ELSE
                        ISNULL(qty.QtyDel,0)
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
                  ISNULL(qty.QtyOrd,0) * 2000
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
                        / case when (Select Sum(IsNull(LbsHead,0)) BudgetedLbPerHead
                        FROM [$(SolomonApp)].dbo.cfvFeedPlanDefDet 
                        WHERE PigGroupID = a.piggroupid
                        and RoomNbr = fo.RoomNbr
                        and InvtID = fo.InvtIdDel                       
                        group by PigGroupID, RoomNbr, InvtID) is null
                        then (select sum(isnull(lbshead,0)) BudgetLbPerHead
                        from [$(SolomonApp)].dbo.cftFeedPlanDet
                        where invtid=fo.invtiddel
                        and feedplanid=fo.feedplanid
                        group by invtid) 
                        else (Select Sum(IsNull(LbsHead,0)) BudgetedLbPerHead
                        FROM [$(SolomonApp)].dbo.cfvFeedPlanDefDet 
                        WHERE PigGroupID = a.piggroupid
                        and RoomNbr = fo.RoomNbr
                        and InvtID = fo.InvtIdDel                       
                        group by PigGroupID, RoomNbr, InvtID) end * 100



FROM [$(SolomonApp)].dbo.cftPigGroup a (NOLOCK)
JOIN [$(SolomonApp)].dbo.cfv_GroupStart v 
        ON a.PigGroupID = v.PigGroupID 
left join (Select pg.PigGroupID,pg.TaskID,fo.Roomnbr,Max(fo.OrdNbr) as LastOrdNbr,Max (fo.DateDel) AS LastDelDate
                  From [$(SolomonApp)].dbo.cftPigGroup pg (nolock)
                  Left JOIN [$(SolomonApp)].dbo.cftFeedOrder fo ON pg.PigGroupID=fo.PigGroupID
                  Where fo.status='C'
                  Group by pg.PigGroupID, pg.TaskID, fo.Roomnbr) lo
            on lo.PigGroupID = a.PigGroupID
            --and lo.TaskID = a.TaskID
left join [$(SolomonApp)].dbo.cftFeedOrder fo (nolock) 
      on fo.DateDel = lo.LastDelDate 
      and fo.PigGroupID = a.PigGroupID 
      and lo.LastOrdNbr = fo.OrdNbr
      and lo.roomnbr = fo.roomnbr
left join (select piggroupid,roomnbr,invtiddel,sum(qtydel) qtydel,sum(qtyord) qtyord
	              from [$(SolomonApp)].dbo.cftfeedorder (nolock)
	              where status='C'
	              group by piggroupid,roomnbr,invtiddel) qty
	        on fo.piggroupid=qty.piggroupid
	        and fo.roomnbr=qty.roomnbr
	        and fo.invtiddel=qty.invtiddel
JOIN [$(SolomonApp)].dbo.cftPigSystem ps (nolock) 
        ON ps.PigSystemID = a.PigSystemID 
LEFT JOIN [$(SolomonApp)].dbo.cfvFeedPlanDef fpd (NOLOCK)
        ON fpd.PigGroupID = a.PigGroupID
        and fpd.roomnbr = lo.roomnbr
LEFT JOIN [$(SolomonApp)].dbo.cfvFeedOrderPriorFeed pr 
        ON a.PigGroupID = pr.PigGroupID 
        AND lo.RoomNbr = pr.RoomNbr 
LEFT JOIN [$(SolomonApp)].dbo.cftPigPreMkt pm (nolock) 
        ON a.PigGroupID = pm.PigGroupID
LEFT JOIN [$(SolomonApp)].dbo.cfvCurrentInv c (NOLOCK)
      ON a.TaskId = c.TaskId
--LEFT JOIN [$(SolomonApp)].dbo.cftFeedPlanDet d (NOLOCK)
--      ON (b.InvtIdOrd = d.InvtId
--      AND b.FeedPlanId = d.FeedPlanId)
left join [$(CentralData)].dbo.cfv_SITE_BARN_ROOM_BIN e (NOLOCK)
      ON (fo.RoomNbr = e.RoomNbr
      and fo.barnnbr = e.barnnbr
      AND RTRIM(fo.ContactId) = e.ContactId)
LEFT JOIN [$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
      ON CAST(RTRIM(cftContact.ContactID) AS INT) = CAST(RTRIM(a.SiteContactID) AS INT)

LEFT JOIN dbo.cfv_SITE_FEED_REPRESENTATIVE sfr
      on RTRIM(sfr.SolomonAppSiteContactID) = RTRIM(a.SiteContactID)
LEFT JOIN [$(SolomonApp)].dbo.cfvCurrentSvcMgr cfvCurrentSvcMgr
      ON cfvCurrentSvcMgr.SiteContactID = a.SiteContactID 
JOIN [$(SolomonApp)].dbo.cftContact SvcMgrContact (NOLOCK)
      ON SvcMgrContact.ContactID = cfvCurrentSvcMgr.SvcMgrContactID


WHERE (a.PGStatusId = 'F' or a.PGStatusId = 'A' OR a.PGStatusId = 'T')
--AND b.InvtIdDel NOT LIKE '%075%' 
--AND b.InvtIdOrd NOT LIKE '%075%'
AND IsNull((Select TOP 1 InvtIDOrd 
                              FROM [$(SolomonApp)].dbo.cftFeedOrder (nolock)
                              WHERE PigGroupID = a.PigGroupID 
                              AND RoomNbr = lo.RoomNbr     
                              AND Status not in ('X','C')
                              AND Reversal <> '1'
                              ORDER BY StageOrd DESC, DateReq DESC ),'N/A') NOT LIKE '%075%'
AND fo.InvtIdDel NOT LIKE '%075%'
AND   RTRIM(IsNull((Select TOP 1 InvtIDOrd 
                  FROM [$(SolomonApp)].dbo.cftFeedOrder
                  WHERE PigGroupID = a.PigGroupID 
                  AND RoomNbr = lo.RoomNbr     
                  AND Status not in ('X','C')
                  AND Reversal <> '1'
                  ORDER BY StageOrd DESC, DateReq DESC ),'N/A'))
            <> RTRIM(fo.InvtIdDel)
AND IsNull((Select TOP 1 InvtIDOrd 
                              FROM [$(SolomonApp)].dbo.cftFeedOrder (nolock)
                              WHERE PigGroupID = a.PigGroupID 
                              AND RoomNbr = lo.RoomNbr     
                              AND Status not in ('X','C')
                              AND Reversal <> '1'
                              ORDER BY StageOrd DESC, DateReq DESC ),'N/A') <> 'N/A'
