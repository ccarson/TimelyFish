
CREATE PROCEDURE [dbo].[GetViews] AS
 	exec sp_tables null,'dbo',null,'''VIEW'''
