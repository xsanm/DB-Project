USE [u_kurowski]
GO
/****** Object:  View [dbo].[vAllMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAllMenu]
AS
SELECT        TOP (100) PERCENT dbo.Restaurants.RestaurantName, dbo.MenuItem.Name, dbo.MenuItem.Cost, dbo.Category.CategoryName, dbo.Menu.DateBegin, dbo.Menu.DateEnd
FROM            dbo.Menu INNER JOIN
                         dbo.MenuItem ON dbo.Menu.ItemID = dbo.MenuItem.ItemID INNER JOIN
                         dbo.Restaurants ON dbo.Menu.ResturantID = dbo.Restaurants.RestaurantID INNER JOIN
                         dbo.Category ON dbo.MenuItem.CategoryID = dbo.Category.CategoryID
WHERE        (dbo.Menu.DateEnd IS NULL)
ORDER BY dbo.Restaurants.RestaurantName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[17] 2[11] 3) )"
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
         Top = 0
         Left = -334
      End
      Begin Tables = 
         Begin Table = "Menu"
            Begin Extent = 
               Top = 6
               Left = 372
               Bottom = 136
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MenuItem"
            Begin Extent = 
               Top = 6
               Left = 580
               Bottom = 136
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Restaurants"
            Begin Extent = 
               Top = 168
               Left = 592
               Bottom = 281
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Category"
            Begin Extent = 
               Top = 31
               Left = 766
               Bottom = 127
               Right = 936
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1755
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1290
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1875
         Or = 1350
         Or = 1350
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAllMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAllMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAllMenu'
GO
