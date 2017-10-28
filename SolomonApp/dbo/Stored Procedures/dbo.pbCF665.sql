--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
Create Procedure [dbo].[pbCF665] @RI_ID smallint as 

--Declare @RI_ID smallint
--select @RI_ID = '1'
	--use variable to hold the report run date (for determining the active manager)
	Declare @RI_Where VARCHAR(255), @Search VARCHAR(255), @Pos SMALLINT,
		@RptDate smalldatetime
	Select @RI_Where = LTRIM(RTRIM(RI_Where)), @RptDate = ReportDate from RptRunTime Where RI_ID = @RI_ID

	--clear the work table (just in case)
    Delete from wrkLastRation Where RI_ID = @RI_ID

	--get the basis records
    Insert Into wrkLastRation (BinNbr, LastRationDel, LastRationOrd, MillID, PigGroupID, RI_ID, 
	SiteContactId)
 
   SELECT binnbr, '','', millid, piggroupid, @RI_ID, contactid 
    FROM cftFeedOrder (NOLOCK)
    WHERE ContactId NOT IN('000409', '000411', '000488', '001190', '003697', '003700')
	GROUP BY contactid, binnbr, piggroupid, millid

	--get the Last Order Ration
	update wrkLastRation set LastRationOrd = fo.invtidord 
		from cftFeedOrder fo (NOLOCK), cftpiggroup pg (NOLOCK),
	     (Select Max(dateord) as maxdate, contactid, piggroupid, binnbr, millid from cftfeedorder (NOLOCK)
      		group by contactid, binnbr, millid, piggroupid) maxresults
		where fo.piggroupid = pg.piggroupid
		and fo.contactid = maxresults.contactid
                and fo.Contactid = wrkLastRation.sitecontactid 
		and fo.piggroupid = maxresults.piggroupid
		and fo.piggroupid = wrkLastRation.piggroupid
		and fo.binnbr = maxresults.binnbr
		and fo.binnbr = wrkLastRation.binnbr
                and fo.millid = maxresults.millid
		and fo.millid = wrkLastRation.millid
		and fo.dateord = maxresults.maxdate
	        and wrkLastRation.RI_ID = @RI_ID
		and pg.pgstatusid not in ('I','P')

	--get the Last Delivered Ration
	update wrkLastRation set LastRationDel = fo.invtiddel 
		from cftFeedOrder fo (NOLOCK), cftpiggroup pg (NOLOCK),
	     (Select Max(datedel) as maxdate, contactid, piggroupid, binnbr, millid from cftfeedorder (NOLOCK)
      		group by contactid, binnbr, millid, piggroupid) maxresults
		where fo.piggroupid = pg.piggroupid
		and fo.contactid = maxresults.contactid
                and fo.Contactid = wrkLastRation.sitecontactid 
		and fo.piggroupid = maxresults.piggroupid
		and fo.piggroupid = wrkLastRation.piggroupid
		and fo.binnbr = maxresults.binnbr
		and fo.binnbr = wrkLastRation.binnbr
                and fo.millid = maxresults.millid
		and fo.millid = wrkLastRation.millid
		and fo.datedel = maxresults.maxdate
		and fo.datedel <> ''
	        and wrkLastRation.RI_ID = @RI_ID
		and pg.pgstatusid not in ('I','P')

	--add ri_id as a filter in the report where clause
	SELECT @Search = '({wrkLastRation.RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ')'
	
	SELECT @Pos = PATINDEX('%' + @Search + '%', @RI_Where)
	
	UPDATE RptRunTime SET RI_Where = CASE
		WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
			THEN @Search
		WHEN @Pos <= 0
			THEN @Search + ' AND ' + @RI_WHERE + ''
	END
	WHERE RI_ID = @RI_ID


 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pbCF665] TO [MSDSL]
    AS [dbo];

