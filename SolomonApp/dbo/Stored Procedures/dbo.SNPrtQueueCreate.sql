 create proc SNPrtQueueCreate
	@ri_id		smallint,
	@WhereStr	varchar(1024)
as
	declare @SelectStr1	varchar(2000)
	declare @FromStr1	varchar(2000)
	declare @WhereStr1	varchar(2000)
	declare @BlankRestrict	varchar(5)

	-- Clear the print queue of any pre-existing records.
	delete from SNPrintQueue where ri_id = @ri_id


	-- Select all eligible records (not accounting for the
	-- output characteristics) into a temporary table.
	select @SelectStr1 =
	'insert into SNPrintQueue (CpnyID, INNbr, Reprint, ReqCntr, ReqNbr,
		RI_ID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09,
		S4Future10,S4Future11, S4Future12)
	select 	distinct
		SMInvoice.cpnyid,
		SMInvoice.Refnbr,
		0,
		'''',
		SMInvoice.Refnbr,
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
	'from	SMInvoice (READPAST)
	  left join
		SNPrintQueue q on SMInvoice.RefNbr = q.InNbr '

	-- The following joins are used to accomodate any Selection Criteria from any table
	-- passed in from the ROI.
	if @WhereStr <> '' and @WhereStr is not NULL
	begin

		select @FromStr1 = @FromStr1 +
	     	  ' LEFT JOIN Customer Customer ON
		        SMinvoice.CustID = Customer.CustID
 		    LEFT JOIN SMContract SMContract ON
		        SMinvoice.DocumentID = SMContract.contractID
		    LEFT JOIN Terms Terms ON
		        SMinvoice.TermID = Terms.TermsID
		    LEFT JOIN Snote Snote ON
		        SMinvoice.NoteID = Snote.nID '
	end
	select @WhereStr1 =
	' where	(SMinvoice.DocType = ''C'' or SMinvoice.DocType = ''M'') '
		exec (@SelectStr1 +  @FromStr1 + @WhereStr1 + @WhereStr)


