

CREATE VIEW [dbo].[vPM_AdjServiceToFarrowBaseDetail]
AS

SELECT     sme.FarmID, wd.WeekOfDate, sme.SowID, sme.SowGenetics, sme.SowParity
FROM         dbo.WeekDefinition AS wd WITH (NOLOCK) LEFT OUTER JOIN
-- 20130626 smr changed 115 to 119 for pigchamp impl
                      dbo.SowMatingEvent AS sme WITH (NOLOCK) ON sme.EventDate BETWEEN wd.WeekOfDate - 119 AND wd.WeekOfDate - 109 LEFT OUTER JOIN
                          (SELECT     FarmID, SowID, EventDate, WeekOfDate, RemovalType, PrimaryReason, SecondaryReason, SowParity, SowGenetics, SortCode
                            FROM          dbo.SowRemoveEvent WITH (Nolock)
                            WHERE      (PrimaryReason IN ('DEPOP', 'DEPOPULATION')) AND (EventDate >= '10/4/2009') AND (EventDate <= '12/12/2009')) AS re ON 
                      sme.FarmID = re.FarmID AND sme.SowID = re.SowID AND sme.SowParity = re.SowParity
WHERE     (sme.MatingNbr = 1) AND (sme.SowID NOT IN
                          (SELECT DISTINCT SowID
                            FROM          dbo.SowFarrowEvent WITH (NOLOCK)
                            WHERE      (FarmID = sme.FarmID) AND (SowID = sme.SowID) AND (EventDate BETWEEN wd.WeekOfDate - 7 AND wd.WeekOfDate - 1 OR
                                                   EventDate BETWEEN wd.WeekOfDate + 7 AND wd.WeekOfDate + 13))) AND (re.PrimaryReason IS NULL)
UNION
SELECT     FarmID, WeekOfDate, SowID, SowGenetics, SowParity
FROM         dbo.SowFarrowEvent AS sfe WITH (NOLOCK)




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Configuration = "(H (4[30] 2[40] 3) )"
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
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
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
      Begin ColumnWidths = 5
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPM_AdjServiceToFarrowBaseDetail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPM_AdjServiceToFarrowBaseDetail';

