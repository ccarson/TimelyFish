CREATE Procedure pXF211VehicleExport
AS

----------------------------------------------------------------------------------------
--	Purpose: Select Site Data for WEM Database 
--	Author: Sue Matter
--	Date: 8/11/2006
--	Program Usage: 
--	Parms: 
----------------------------------------------------------------------------------------

Select '"' + RTrim(tr.TruckID) + '",'
+ '"' + ''+ '",' 
+ '"' + ''+ '",' 
+ '"' + RTrim(CAST(0 AS CHAR)) + '",' 
+ '"' + RTrim(CAST(0 AS CHAR)) + '",' 
+ '"' + RTrim(CAST(0 AS CHAR)) + '",' 
+ '"' + ' ' + '",' 
+  '"' + ' ' + '",'
+  '"' + ' ' + '",'
+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'
+ '"'  + RTrim(tr.MaxLoad) + '",'
+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'
+ '"' + '' + '",'
+ '"' + '' + '",'
+ '"' + '' + '",'
+ '"' + '' + '",'
+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'
+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'
+ '"' + '' + '",'
+ '"' + '' + '",'
+  '"' + RTrim(8) + '",'
+  '"' + RTrim(tr.Comment) + '",'
+'"' + RTrim(tr.Comp1No) + '",'+'"' + RTrim(tr.Comp1Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp2No) + '",'+'"' + RTrim(tr.Comp2Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp3No) + '",'+'"' + RTrim(tr.Comp3Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp4No) + '",'+'"' + RTrim(tr.Comp4Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp5No) + '",'+'"' + RTrim(tr.Comp5Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp6No) + '",'+'"' + RTrim(tr.Comp6Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp7No) + '",'+'"' + RTrim(tr.Comp7Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
+',"' + RTrim(tr.Comp8No) + '",'+'"' + RTrim(tr.Comp8Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
--+',"' + RTrim(tr.Comp9No) + '",'+'"' + RTrim(tr.Comp9Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
--+',"' + RTrim(tr.Comp10No) + '",'+'"' + RTrim(tr.Comp10Cap) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"'  + RTrim(CAST(0 AS CHAR)) + '",'+ '"' + '' + '",'+ '"' + '' + '"'
From cftFeedTruck tr
Where Active=1


