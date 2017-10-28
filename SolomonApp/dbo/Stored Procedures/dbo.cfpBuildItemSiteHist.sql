CREATE PROCEDURE cfpBuildItemSiteHist
	AS
	-- Created By: TJONES
	-- Created Date: 7/18/05
	-- Purpose: Is used to build point in time ItemSite records that can be
	-- used to calculate inventory turns.
	-- Procedure is run via SQL Agent (schedule job in Enterprise Manager)
	
	-- Create a variable to hold current date (without time)
	-- Note: Don't want time as this is a daily process, and date is part of 
	-- the tables unique key
	DECLARE @CreateDate as smalldatetime
	-- Set the date via SQL's built in function, format off the time portion
	SELECT @CreateDate = convert(char(10),getdate(),101)

	-- Turn SQL's count returning off, don't need, saves some time.
	SET NOCOUNT ON

	-- Delete out any records that could have already been created for this date
	-- Allows for running the procedure as many times in a day as necessary without
	-- have duplicate errors
	DELETE FROM ish
	FROM cftItemSiteHist ish
	JOIN ItemSite i ON ish.SiteID = i.SiteID and ish.InvtID = i.InvtID
	WHERE ish.Crtd_DateTime = @CreateDate
	
	-- Insert all ItemSite records, plus add current date (without time)
	INSERT INTO cftItemSiteHist (AvgCost,CpnyID,Crtd_DateTime,InvtID,LastCost,QtyOnHand,SiteID,TotCost)
	SELECT AvgCost,CpnyID,@CreateDate,InvtID,LastCost,QtyOnHand,SiteID,TotCost
	FROM ItemSite
	
	-- Turn counting back on for any other procs, not probably necessary, but
	-- normal to do.
	SET NOCOUNT OFF

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpBuildItemSiteHist] TO [MSDSL]
    AS [dbo];

