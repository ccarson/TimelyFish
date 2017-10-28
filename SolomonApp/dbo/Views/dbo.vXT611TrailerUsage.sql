--*************************************************************
--	Purpose:Determines NbrLoads scheduled for each trailer
--		
--	Author: Brian Doyle	
--	Date: 7/29/2005
--	Usage: Transportation Module	 
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vXT611TrailerUsage

AS
select Distinct PigTrailerID, MovementDate, PMLoadID from cftPM
