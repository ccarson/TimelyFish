CREATE VIEW [dbo].[cfv_SINGLE_STOCK_PIGGROUP_CLOSE_WEEK]
AS


SELECT     PigGroupDates.Description, PigGroupDates.PigGroupID, PigGroupDates.AvgPigTransferDate, PigGroupDates.CloseDate, 
                      cfvDayDefinition_WithWeekInfo.PICYear_Week, CASE WHEN (PigGroupDates.UseActualsFlag) = 1 THEN 'Yes' ELSE 'No' END AS UseActualsFlag, 
                      PigGroupDates.PigGenderTypeID, PigGroupDates.MaxCap, CAST(DATEDIFF(d, PigGroupDates.AvgPigTransferDate, PigGroupDates.CloseDate) 
                      * 0.8834 + 5.9936 AS Numeric(6, 2)) AS AvgCloseWgt
FROM         (SELECT     cftPigGroup.Description, cftPigGroup.PigGroupID, cftPigGroup.UseActualsFlag, cftPigGroup.PigGenderTypeID, CAST(CONVERT(varchar, 
                                              CAST(SUM(TransferDates.Qty * TransferDates.DateConvert) / SUM(TransferDates.Qty) AS datetime), 101) AS datetime) 
                                              AS 'AvgPigTransferDate', CASE WHEN (datepart(weekday, dateadd(d, 49, CAST(CONVERT(varchar, 
                                              CAST((SUM(TransferDates.Qty * TransferDates.DateConvert) / SUM(TransferDates.Qty)) AS datetime), 101) AS datetime))) >= 4) 
                                              THEN dateadd(d, 7 - datepart(weekday, dateadd(d, 49, CAST(CONVERT(varchar, CAST((SUM(TransferDates.Qty * TransferDates.DateConvert) 
                                              / SUM(TransferDates.Qty)) AS datetime), 101) AS datetime))), dateadd(d, 49, CAST(CONVERT(varchar, 
                                              CAST((SUM(TransferDates.Qty * TransferDates.DateConvert) / SUM(TransferDates.Qty)) AS datetime), 101) AS datetime))) ELSE dateadd(d, 
                                              - datepart(weekday, dateadd(d, 49, CAST(CONVERT(varchar, CAST((SUM(TransferDates.Qty * TransferDates.DateConvert) 
                                              / SUM(TransferDates.Qty)) AS datetime), 101) AS datetime))), dateadd(d, 49, CAST(CONVERT(varchar, 
                                              CAST((SUM(TransferDates.Qty * TransferDates.DateConvert) / SUM(TransferDates.Qty)) AS datetime), 101) AS datetime))) END AS CloseDate, 
                                              cftBarn.MaxCap
                       FROM          dbo.cftPigGroup AS cftPigGroup LEFT OUTER JOIN
                                              dbo.cftBarn AS cftBarn ON cftBarn.ContactID = cftPigGroup.SiteContactID AND cftBarn.BarnNbr = cftPigGroup.BarnNbr LEFT OUTER JOIN
                                                  (SELECT     cftPigGroup.PigGroupID, cftPGInvTran.Qty, CAST(cftPGInvTran.TranDate AS float) AS 'DateConvert'
                                                    FROM          dbo.cftPigGroup AS cftPigGroup WITH (NOLOCK) LEFT OUTER JOIN
                                                                           dbo.cftPGInvTran AS cftPGInvTran WITH (NOLOCK) ON cftPGInvTran.PigGroupID = cftPigGroup.PigGroupID LEFT OUTER JOIN
                                                                           dbo.vCFPigGroupStart AS vCFPigGroupStart ON vCFPigGroupStart.PigGroupID = cftPigGroup.PigGroupID
                                                    WHERE      (cftPGInvTran.Reversal <> 1) AND (cftPGInvTran.acct = 'PIG TRANSFER IN' OR
                                                                           cftPGInvTran.acct = 'PIG PURCHASE') OR
                                                                           (cftPGInvTran.Reversal <> 1) AND (cftPGInvTran.acct = 'PIG MOVE IN') AND (cftPGInvTran.TranDate <= DATEADD(d, 7, 
                                                                           vCFPigGroupStart.TranDate))) AS TransferDates ON cftPigGroup.PigGroupID = TransferDates.PigGroupID
                       WHERE      (cftPigGroup.SingleStock <> 0) AND (cftPigGroup.PigProdPhaseID IN ('NUR', 'WTF')) AND (cftPigGroup.PGStatusID NOT IN ('I', 'X'))
                       GROUP BY cftPigGroup.Description, cftPigGroup.PigGroupID, cftPigGroup.UseActualsFlag, cftPigGroup.PigGenderTypeID, cftBarn.MaxCap) 
                      AS PigGroupDates LEFT OUTER JOIN
                      dbo.cfvDayDefinition_WithWeekInfo AS cfvDayDefinition_WithWeekInfo ON 
                      cfvDayDefinition_WithWeekInfo.DayDate = PigGroupDates.CloseDate
WHERE     (PigGroupDates.AvgPigTransferDate IS NOT NULL)

