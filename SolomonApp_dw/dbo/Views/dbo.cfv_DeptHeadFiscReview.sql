
CREATE VIEW [dbo].[cfv_DeptHeadFiscReview]
AS
/* Updated by BMD on 4/12/2012
   Changed hardcoded years from 2011 to 2012
*/
/*---------------------------------------------------------------------------ACTUAL DETAIL*/ 
   SELECT CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) 
                      + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END AS 'Sub', 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', GLTran.PerPost AS 'WherePeriod', 
                      GLTran.PerPost AS 'GroupPeriod', Account.Descr, GLTran.TranDesc, Sum(GLTran.DrAmt - GLTran.CrAmt) AS 'Amt'
FROM         [$(SolomonApp)].dbo.GLTran GLTran(nolock) LEFT JOIN
                      [$(SolomonApp)].dbo.Account Account(nolock) ON GLTran.Acct = Account.Acct LEFT JOIN
                      [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON GLTran.Sub = SubAcct.Sub LEFT JOIN
                      [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(rtrim(GLTran.Sub), 4) = seg.ID AND seg.SegNumber = 3
WHERE     GLTran.Rlsed = 1 AND GLTran.PerPost >= 201001 AND Account.AcctType IN ('3I', '3E')
GROUP BY CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END, 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END, GLTran.PerPost, Account.Descr, 
                      GLTran.TranDesc
UNION
/*---------------------------------------------------------------------ACTUAL SUMMARY--*/ 
   SELECT CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) 
                      + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END AS 'Sub', 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', GLTran.PerPost AS 'WherePeriod', 
                      'Actual' AS 'GroupPeriod', Account.Descr, '' TranDesc, Sum(GLTran.DrAmt - GLTran.CrAmt) AS 'Amt'
FROM         [$(SolomonApp)].dbo.GLTran GLTran(nolock) LEFT JOIN
                      [$(SolomonApp)].dbo.Account Account(nolock) ON GLTran.Acct = Account.Acct LEFT JOIN
                      [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON GLTran.Sub = SubAcct.Sub LEFT JOIN
                      [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(rtrim(GLTran.Sub), 4) = seg.ID AND seg.SegNumber = 3
WHERE     GLTran.Rlsed = 1 AND GLTran.PerPost >= 201001 AND Account.AcctType IN ('3I', '3E')
GROUP BY CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END, 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END, GLTran.PerPost, Account.Descr
UNION
/*---------------------------------------------------------------------ACTUAL 2012 SUMMARY--*/ 
   SELECT CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 
                      2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END AS 'Sub', 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', GLTran.PerPost AS 'WherePeriod', 
                      'Actual 2012' AS 'GroupPeriod', Account.Descr, '' TranDesc, Sum(GLTran.DrAmt - GLTran.CrAmt) AS 'Amt'
FROM         [$(SolomonApp)].dbo.GLTran GLTran(nolock) LEFT JOIN
                      [$(SolomonApp)].dbo.Account Account(nolock) ON GLTran.Acct = Account.Acct LEFT JOIN
                      [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON GLTran.Sub = SubAcct.Sub LEFT JOIN
                      [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(rtrim(GLTran.Sub), 4) = seg.ID AND seg.SegNumber = 3
WHERE     GLTran.Rlsed = 1 AND GLTran.PerPost >= 201201 AND GLTran.PerPost <= 201212 AND Account.AcctType IN ('3I', '3E')
GROUP BY CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) ELSE GlTran.Sub END, 
                      CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END, GLTran.PerPost, Account.Descr
UNION
/*----------------------------------------------------------------------BUDGET--*/ 
   SELECT CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) 
                      LIKE '4[012]' THEN RIGHT(Rtrim(Division), 2) + 'FA' + RIGHT(RTrim(Location), 4) ELSE RIGHT(Rtrim(Division), 2) + '' + RIGHT(RTrim(Department), 2) 
                      + '' + RIGHT(RTrim(Location), 4) END AS 'Sub', CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) 
                      LIKE '4[012]' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', '2012' + RIGHT(RTrim(Time), 2) AS 'WherePeriod', 
                      'Budget' AS 'GroupPeriod', Account.Descr, '' AS 'TranDesc', sum(cftFicalBudget.Total) AS 'Amt'
FROM          dbo.cftFicalBudget cftFicalBudget(nolock) LEFT JOIN
                      [$(SolomonApp)].dbo.Account Account(nolock) ON RIGHT(cftFicalBudget.Account, 5) = Account.Acct LEFT JOIN
                      [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON RIGHT(cftFicalBudget.Division, 2) = LEFT(SubAcct.Sub, 2) AND RIGHT(cftFicalBudget.Department, 2) 
                      = Substring(SubAcct.Sub, 3, 2) AND RIGHT(cftFicalBudget.Location, 4) = RIGHT(Rtrim(SubAcct.Sub), 4) LEFT JOIN
                      [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(RTrim(cftFicalBudget.Location), 4) = seg.ID AND seg.SegNumber = 3
GROUP BY CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) LIKE '4[012]' THEN RIGHT(Rtrim(Division), 2) 
                      + 'FA' + RIGHT(RTrim(Location), 4) ELSE RIGHT(Rtrim(Division), 2) + '' + RIGHT(RTrim(Department), 2) + '' + RIGHT(RTrim(Location), 4) END, 
                      CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) LIKE '4[012]' THEN seg.Description ELSE SubAcct.Descr END, 
                      '2012' + RIGHT(RTrim(Time), 2), Account.Descr
/*-------------------------------------------------------------------------------VARIANCE--*/ 
   UNION
/*----------------------*/ SELECT sub, location, whereperiod, 'Variance' AS GroupPeriod, descr, trandesc, sum(CASE WHEN groupperiod IN ('budget') THEN (amt * - 1) 
                      ELSE amt END) AS amt
FROM         (/*-----Budget------*/ SELECT CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) 
                                              LIKE '4[012]' THEN RIGHT(Rtrim(Division), 2) + 'FA' + RIGHT(RTrim(Location), 4) ELSE RIGHT(Rtrim(Division), 2) 
                                              + '' + RIGHT(RTrim(Department), 2) + '' + RIGHT(RTrim(Location), 4) END AS 'Sub', CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND 
                                              RIGHT(Rtrim(Department), 2) LIKE '4[012]' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', '2012' + RIGHT(RTrim(Time), 2) 
                                              AS 'WherePeriod', 'Budget' AS 'GroupPeriod', Account.Descr, '' AS 'TranDesc', sum(cftFicalBudget.Total) AS 'Amt'
                       FROM           dbo.cftFicalBudget cftFicalBudget(nolock) LEFT JOIN
                                              [$(SolomonApp)].dbo.Account Account(nolock) ON RIGHT(cftFicalBudget.Account, 5) = Account.Acct LEFT JOIN
                                              [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON RIGHT(cftFicalBudget.Division, 2) = LEFT(SubAcct.Sub, 2) AND 
                                              RIGHT(cftFicalBudget.Department, 2) = Substring(SubAcct.Sub, 3, 2) AND RIGHT(cftFicalBudget.Location, 4) = RIGHT(Rtrim(SubAcct.Sub), 4) 
                                              LEFT JOIN
                                              [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(RTrim(cftFicalBudget.Location), 4) = seg.ID AND seg.SegNumber = 3
                       GROUP BY CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) LIKE '4[012]' THEN RIGHT(Rtrim(Division), 2) 
                                              + 'FA' + RIGHT(RTrim(Location), 4) ELSE RIGHT(Rtrim(Division), 2) + '' + RIGHT(RTrim(Department), 2) + '' + RIGHT(RTrim(Location), 4) END, 
                                              CASE WHEN RIGHT(Rtrim(Division), 2) LIKE '[12]0' AND RIGHT(Rtrim(Department), 2) 
                                              LIKE '4[012]' THEN seg.Description ELSE SubAcct.Descr END, '2012' + RIGHT(RTrim(Time), 2), Account.Descr
                       /*-----Budget------*/ UNION
                       /*-----Actual------*/ SELECT CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) 
                                             ELSE GlTran.Sub END AS 'Sub', 
                                             CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END AS 'Location', 
                                             GLTran.PerPost AS 'WherePeriod', 'Actual' AS 'GroupPeriod', Account.Descr, '' TranDesc, Sum(GLTran.DrAmt - GLTran.CrAmt) AS 'Amt'
                       FROM         [$(SolomonApp)].dbo.GLTran GLTran(nolock) LEFT JOIN
                                             [$(SolomonApp)].dbo.Account Account(nolock) ON GLTran.Acct = Account.Acct LEFT JOIN
                                             [$(SolomonApp)].dbo.SubAcct SubAcct(nolock) ON GLTran.Sub = SubAcct.Sub LEFT JOIN
                                             [$(SolomonApp)].dbo.SegDef seg(nolock) ON RIGHT(rtrim(GLTran.Sub), 4) = seg.ID AND seg.SegNumber = 3
                       WHERE     GLTran.Rlsed = 1 AND GLTran.PerPost >= 201201 AND GLTran.PerPost <= 201212 AND Account.AcctType IN ('3I', '3E')
                       GROUP BY CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN LEFT(rtrim(GLTran.Sub), 2) + 'FA' + RIGHT(rtrim(GLTran.Sub), 4) 
                                             ELSE GlTran.Sub END, CASE WHEN GlTran.Sub LIKE '[12]04[012]____' THEN seg.Description ELSE SubAcct.Descr END, GLTran.PerPost, 
                                             Account.Descr/*-----Actual------*/ ) AS DATA
GROUP BY sub, location, whereperiod, descr, trandesc


GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_DeptHeadFiscReview] TO [SE\ANALYSTS]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'cfv_DeptHeadFiscReview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'cfv_DeptHeadFiscReview';

