
/****** Object:  Stored Procedure dbo.se001_cftContact_ContactID    Script Date: 1/30/2006 12:03:19 PM ******/
CREATE  procedure se001_cftContact_ContactID @parm1 varchar(6) as Select * from cftContact 
where ContactID like @parm1 and ContactTypeID = '03' AND StatusTypeID=1 order by ContactID 

