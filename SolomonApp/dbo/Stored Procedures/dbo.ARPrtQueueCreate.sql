 create proc ARPrtQueueCreate
	@ri_id		smallint,
	@cpnyid		varchar(10),
	@WhereStr	varchar(1024)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	declare @SelectStr1	varchar(2000)
	declare @FromStr1	varchar(2000)
	declare @WhereStr1	varchar(2000)
	declare @BlankRestrict	varchar(5)

	-- Clear the print queue of any pre-existing records.
	delete from ARPrintQueue where ri_id = @ri_id


	-- Select all eligible records (not accounting for the
	-- output characteristics) into a temporary table.
	select @SelectStr1 =
	'insert into ARPrintQueue (CpnyID, INNbr, Reprint, ReqCntr, ReqNbr,
		RI_ID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09,
		S4Future10,S4Future11, S4Future12)
	select 	distinct
		ardoc.cpnyid, 
		ARDoc.Refnbr,
		0,
		'''',
		ARDoc.Batnbr,
		' + Convert(varchar(10), @ri_id) + ',
		S4Future01 = '''',
		S4Future02 = '''',
		S4Future03 = 0,
		S4Future04 = 0,
		S4Future05 = 0,
		S4Future06 = 0,
		S4Future07 = '''',
		S4Future08 = '''',
		S4Future09 = 0,
		S4Future10 = 0,
		S4Future11 = '''',
		S4Future12 = '''' '

	select @FromStr1 =
	'from	ARDoc (READPAST)
	  left join
		ARPrintQueue q on ARDoc.RefNbr = q.InNbr '

	-- The following joins are used to accomodate any Selection Criteria from any table
	-- passed in from the ROI.
	if @WhereStr <> '' and @WhereStr is not NULL
	begin

		select @FromStr1 = @FromStr1 +
	     	  '  LEFT JOIN Customer Customer ON
		        ARDoc.CustID = Customer.CustID
		     LEFT JOIN ARTran ARTran ON
		        ARDoc.RefNbr = ARTran.Refnbr and ARDoc.BatNbr = ARTran.Batnbr
		     LEFT JOIN Terms Terms ON
		        ARDoc.Terms = Terms.TermsID
		     LEFT JOIN VS_company VS_company ON
		        ARDoc.cpnyid = vs_company.cpnyid
		     LEFT JOIN Snote Snote ON
		        ARDoc.NoteID = Snote.nID'
	end
	
	select @WhereStr1 =
	' where	ARDoc.Rlsed = 1 and ARDoc.DocType in (''CM'', ''DM'', ''IN'', ''CS'') '
		exec (@SelectStr1 +  @FromStr1 + @WhereStr1 + @WhereStr)


