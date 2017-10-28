
CREATE PROCEDURE XDDACHHeadTrail_Import_Format
   	@FormatID		varchar(15),
	@Crtd_Prog		varchar(8),
	@Crtd_User		varchar(10),
	@CpnyName		varchar(30)

AS
	DECLARE @CurrDate	smalldatetime
	DECLARE @CurrTime	smalldatetime

	-- Date only and Time only vars
	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
	SELECT  @CurrTime = cast(convert(varchar(10), getdate(), 108) as smalldatetime)

/*	Data Types
LITERAL;User Entered,
BD-YYMMDD;Business Date (yymmdd),
ED-YYMMDD;Effective Date (yymmdd),
ED-MMDDYYY;Effective Date (mmddyyyy),
ED-YYYMMDD;Effective Date (yyyymmdd),
ED-Y;Effective Date (Y of yyyY),
TIME-HHMM;Transmission Time (hhmm),
FILESEQ-N;File Sequence #,
FILESEQ-L;File Sequence Ltr,
RECCNT;Record Count w/o HT,
RECCNT-NHT;Record Count w/o H-not incl this,
RECCNT-HT;Record Count w/ HT,
RECCNT-CHK;Record Count - Checks,
RECCNT-VOD;Record Count - Voids,
CHKNBRHASH;Check Number Hash total,
CHKSUMAMT;Check Amt Summation,
CHKSUMAMNV;Check Amt Summation - no voids,
CHKSUMAMVO;Check Amt Summation - only voids,
BANKACCT;Bank Account
BANKACCTRJ;Bank Account (RJLZF)
BATCH-TYPE;Batch Type - Check/Void
*/

	-- First remove any Trailer records
	DELETE
	FROM		XDDACHHeadTrail
	WHERE		FileType = 'P'
			and FormatID = @FormatID
			and HeadTrailID = 'A'
			and Header_Trailer IN ('T','U','V','X')

	if @FormatID = 'ALLFIRST'
	BEGIN

		-- Formats courtesy of: SSI/Jeff Vonasek

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-1	1	"T" - total record indicator
		-- Pos 2-12	11	Total count w/o Header/Trailer
		-- Pos 13-24	12	Total dollar amount (voids are positive)
		-- Pos 25-80	56	Spaces

		-- Literal - T
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-T', 'LITERAL', '01', '01', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Number of Checks/Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Count', 'RECCNT', '02', '12', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Amount', 'CHKSUMAMT', '13', '24', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '25', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'ALLFIRST-4DY'
	BEGIN

		-- Formats courtesy of: Intellitec/Dave Spangler

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1 -1	1	"T" - total record indicator
		-- Pos 2 -11	10	Spaces
		-- Pos 12-20	9	Total count w/o Header/Trailer
		-- Pos 21-32	12	Total dollar amount (voids are positive)
		-- Pos 33-80	48	Spaces

		-- Literal - T
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-T', 'LITERAL', '01', '01', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '02', '11', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Number of Checks/Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total # Record', 'RECCNT', '12', '20', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Amount', 'CHKSUMAMT', '21', '32', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '33', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'BANKNORTH'
	BEGIN

		-- First remove first Header records
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer = 'H'

		-- Formats courtesy of: Sentinel Management

		-- -----------------------------------------------
		-- Header Record
		-- -----------------------------------------------
		-- Pos 1-12	12	Bank Number "860110000000"
		-- Pos 13-22	10	Account # (RJLZF)
		-- Pos 23-24	2	Tran Code "BH"
		-- Pos 25-31	7	Filler - zeros
		-- Pos 32-77	46	Filler - spaces
		-- Pos 78-80	3	ID - Header Record ID - Bank supplied

		-- Bank Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Bank Number', 'LITERAL', '01', '12', '860110000000',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Account #
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Account #', 'BANKACCTRJ', '13', '22', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Tran Code
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Tran Code', 'LITERAL', '23', '24', 'BH',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Filler', 'LITERAL', '25', '31', '0000000',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Filler', 'LITERAL', '32', '77', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- ID - Header Record ID
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-ID', 'LITERAL', '78', '80', 'XXX',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'BANKOFAMERICA'
	BEGIN

		-- First remove first Header records
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer = 'H'

		-- Formats courtesy of: Rolando Suarez, SSYH

		-- -----------------------------------------------
		-- Header Record
		-- -----------------------------------------------
		-- Pos 1-30	30	"4HDR" + Space(11) + "-001" + Space(11)
		-- Pos 31-38	8	mmddyyyy
		-- Pos 39-39	1	"1"
		-- Pos 40-40	1	space(1)
		-- Pos 41-50	10	Bank Account
		-- Pos 51-58	8	mmddyyyy
		-- Pos 59-80	22	N + space(11) + CARD + space(6)

		-- "4HDR" Header
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-4HDR', 'LITERAL', '01', '30', '4HDR           -001           ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- mmddyyyy - effective date
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Effective Date', 'ED-MMDDYYY', '31', '38', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- 1 + space
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-1', 'LITERAL', '39', '40', '1 ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Account
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Bank Account', 'BANKACCT', '41', '50', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- mmddyyyy - effective date
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Effective Date', 'ED-MMDDYYY', '51', '58', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- N + space(11) + CARD + space(6)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-CARD', 'LITERAL', '59', '80', 'N           CARD      ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-4	4	1EOF
		-- Pos 5-5	1	Space
		-- Pos 6-10	5	Count of Checks & Voids (RJ-LZF)
		-- Pos 11-30	20	Spaces
		-- Pos 31-40	10	Hash total of Check Numbers (RJ-LZF)
		-- Pos 41-50	10	Sum of Checks/Voids (voids included as Positive)
		-- Pos 51-80    30	Spaces
		-- "1EOF "
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-1EOF', 'LITERAL', '01', '05', '1EOF ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Count of Checks & Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-Checks/Voids Count', 'RECCNT', '06', '10', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-Filler', 'LITERAL', '11', '30', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Hash Total of Check Numbers
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-Check Number Hash', 'CHKNBRHASH', '31', '40', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Sum of Checks and Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-Sum of Checks/Voids', 'CHKSUMAMT', '41', '50', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'EOF-Filler', 'LITERAL', '51', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'BANKOFAMERICACA'
	BEGIN

		-- Formats courtesy of: NexTec

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-10	10	Account Number
		-- Pos 11-11	1	Total Record - Literal "T"
		-- Pos 12-13	2	Spaces
		-- Pos 14-23	10	Item Count Total (w/o Trailer, w/o voids)
		-- Pos 24-35	12	Dollar Amount Total (w/o voids)
		-- Pos 36-56	21	Filler - Zero filled
		-- Pos 57-80	24	Filler - Spaces
		-- Modified 11/20/06 - to not include voids (Lending Tree)
		
		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Account Number', 'BANKACCT', '1', '10', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Literal - T
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-T', 'LITERAL', '11', '11', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces 
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Spaces', 'LITERAL', '12', '13', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Item Count Total - Includes Checks only
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Item Count Total', 'RECCNT-CHK', '14', '23', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Dollar Amount Total Amount (w/o voids)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Dollar Amount Total', 'CHKSUMAMNV', '24', '35', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler - Zero Filled
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Filler', 'LITERAL', '36', '56', '000000000000000000000',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler - Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Trailer-Spaces', 'LITERAL', '57', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'JPMCHASE'
	BEGIN

		-- Formats courtesy of: Harpreet Chawla, Hotels.com
		-- First Trailer Record
		-- Pos 1:     T
		-- Pos 2-25:  Blank
		-- Pos 26-37: Total Amt of Issues(not void) ie Dollar Amount
		-- Pos 38-80: Blank

		-- "T"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-T', 'LITERAL', '01', '25', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount of Issues - Not Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Total of Issues', 'CHKSUMAMNV', '26', '37', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Blanks
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Filler', 'LITERAL', '38', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Second Trailer Record
		-- Pos 1-3: ***
		-- Pos 4-6: EOF
		-- Pos 7-9: ***
		-- Pos 10:  Blank
		-- Pos 11-20: Record Count-number of records plus one for 'Total Record Line'(right justified, unsigned with leading zeros)
		-- Pos 21-80: Blank
		-- "***EOF***"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'EOF-EOF', 'LITERAL', '01', '10', '***EOF***',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Record Count - Not Header and all trailers (not this one)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'EOF-Record Count', 'RECCNT-NHT', '11', '20', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Blanks
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'EOF-Filler', 'LITERAL', '21', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END	-- JPMChase

	if @FormatID = 'FIFTH_THIRD'
	BEGIN

		-- Formats courtesy of: Ronda Elsea, Wallich Companies
		-- First Trailer Record
		-- Pos 1-2	2	"30" - File Total Indicator
		-- Pos 3-5	31	Bank Number "038"
		-- Pos 6-15	10	Filler "9999999999"
		-- Pos 16-25	10	Number of Checks & Voids for this file
		-- Pos 26-33	8	File Date (yyyymmdd)
		-- Pos 34-44	11	Amount of checks for this file (Voids as positive numbers)
		-- Pos 45-80    36	Filler - Spaces

		-- "30"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-30', 'LITERAL', '01', '02', '30',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Number - '038'
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-Bank Number', 'LITERAL', '03', '05', '038',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-Filler', 'LITERAL', '06', '15', '9999999999',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Number of Checks for this file
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-Number of Checks', 'RECCNT', '16', '25', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- File Date
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-File Date', 'ED-YYYMMDD', '26', '33', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Amount of Checks for this file (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-Amount of Checks', 'CHKSUMAMT', '34', '44', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'File Total-Filler', 'LITERAL', '45', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END	-- Fifth Third

	if @FormatID = 'FLEET-CT'
	BEGIN

		-- Formats courtesy of: ePartners
		-- CDRFMTB3 Format
		
		-- First remove first Header record
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer = 'H'

		-- -----------------------------------------------
		-- Header Record (Control Record)
		-- -----------------------------------------------
		-- Pos 1-13	13	Control Identification "01021226C3648"
		-- Pos 14-16	3	Bank Number "091"
		-- Pos 17-80	64	Filler (spaces)

		-- Control Identification
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Control-Identification', 'LITERAL', '01', '13', '01021226C3648',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Control-Bank Number', 'LITERAL', '14', '16', '091',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Control-Filler', 'LITERAL', '17', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-1	1	"T" - total record indicator
		-- Pos 2-11	10	Filler (spaces)
		-- Pos 12-25	14	Account Number - RJLZF
		--			Be sure Account Number has LZF in Company Paying Accounts
		-- Pos 26-35	10	Total Amt of Issues(not void) ie Dollar Amount - RJLZF
		-- Pos 36-80	45	Filler (spaces)

		-- We assume each Company Account is in one file
		-- "T"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-T', 'LITERAL', '01', '01', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Filler', 'LITERAL', '02', '11', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Account Number', 'BANKACCT', '12', '25', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount of Issues - Not Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Total of Issues', 'CHKSUMAMNV', '26', '35', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler (spaces)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total-Filler', 'LITERAL', '36', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')
	END


	if @FormatID = 'FLEETMAINE'
	BEGIN

		-- Formats courtesy of: SVA Consulting

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-10	10	Account Number 00AAAAAAAA
		-- Pos 11-20	10	Spaces
		-- Pos 21-32	12	Total Amount
		-- Pos 33-40	8	Date	MMDDYYYYY
		-- Pos 41-41	1	Total record indicator "T"
		-- Pos 42-47	6	Total number of checks NNNNNN (includes voids)
		-- Pos 48-80    33	Spaces

		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Account Number', 'BANKACCT', '01', '10', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '11', '20', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Amount', 'CHKSUMAMT', '21', '32', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Date (mmddyyyy)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Date', 'ED-MMDDYYY', '33', '40', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Record Indicator
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Indicator', 'LITERAL', '41', '41', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Number of Checks - includes voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Check/Void Count', 'RECCNT', '42', '47', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '48', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'LASALLE'
	BEGIN

		-- Formats courtesy of: RedPrarie
		-- Issue File Format
		
		-- First remove first Header record
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer = 'H'

		-- -----------------------------------------------
		-- Header Record 
		-- -----------------------------------------------
		-- Pos 1-1      1	Record Type "H"
		-- Pos 2-31	30	Company Name (user entered)
		-- Pos 32-39	8	Date (YYYYMMDD)
		-- Pos 40-80	41	Blank

		-- Record TYpe
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Record Type', 'LITERAL', '01', '01', 'H',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Company Name
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Company Name', 'LITERAL', '02', '31', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Date Field
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Date Field', 'ED-YYYMMDD', '32', '39', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Blank
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Blank', 'LITERAL', '40', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-1	1	Record Type - "T"
		-- Pos 2-4	3	Bank Number (user entered), 965 for LNA, 280 for SFB
		-- Pos 5-14	10	Account Number - RJLZF
		-- Pos 15-22	8	Not Used Blank
		-- Pos 23-32	10	Check Issued Record Count (not void) - RJLZF
		-- Pos 33-42	10	Total Dollar Amount (not void) ie Dollar Amount - RJLZF
		-- Pos 43-80	38	Blank

		-- We assume each Company Account is in one file
		-- Record Type "T"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Record Type', 'LITERAL', '01', '01', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Bank Number', 'LITERAL', '02', '04', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Account Number', 'BANKACCTRJ', '05', '14', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Not Used Blank
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Not Used Blank', 'LITERAL', '15', '22', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Check Issued Record Count - Issues Only
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Check Issued Record Count', 'RECCNT-CHK', '23', '32', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Dollar Amount - Issues Only
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total Dollar Amount', 'CHKSUMAMNV', '33', '42', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Blank
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Blank', 'LITERAL', '43', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')
	END


	if @FormatID = 'MELLON'
	BEGIN

		-- Formats courtesy of: PEW Charitable Trust

		-- First remove first Header records
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer IN ('H', 'I', 'J')

		-- -----------------------------------------------
		-- Header Record (1st Header record)
		-- -----------------------------------------------
		-- Pos 1-1      1	Record Type "1"
		-- Pos 2-3	2	Priority Code Spaces
		-- Pos 4-13	10	"MELLONBANK"
		-- Pos 14-23	10	Company Name/Title
		-- Pos 24-31	8	Transmission Date (CCYYMMDD)
		-- Pos 32-35	4	Transmission Time (HHMM)
		-- Pos 36-80    45	Spaces

		-- Record Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Record Type', 'LITERAL', '01', '01', '1',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Priority', 'LITERAL', '02', '03', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Destination/Identification of Receiving Location
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Destination', 'LITERAL', '04', '13', 'MELLONBANK',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Company Name/Title
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Company', 'LITERAL', '14', '23', SubString(@CpnyName,1,10),
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Transmission Date
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Transmission Date', 'ED-YYYMMDD', '24', '31', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Transmission Time
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Transmission Time', 'TIME-HHMM', '32', '35', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Filler', 'LITERAL', '36', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Service Record (2nd Header record)
		-- -----------------------------------------------
		-- Pos 1-1      1	Record Type "2"
		-- Pos 2-31	30	Ultimate network address (zeros)
		-- Pos 32-34	3	Service Type "100"
		-- Pos 35-37	3	Record Size "080"
		-- Pos 38-41	4	Blocking Factor: 20 "1600"
		-- Pos 42-42	1	Format Code "1"
		-- Pos 43-80    38	Spaces

		-- Record Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Record Type', 'LITERAL', '01', '01', '2',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Ultimate Network Address
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Network Address', 'LITERAL', '02', '31', '000000000000000000000000000000',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Service Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Service Type', 'LITERAL', '32', '34', '100',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Record Size
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Record Size', 'LITERAL', '35', '37', '080',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Blocking Factor
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Blocking Factor', 'LITERAL', '38', '41', '1600',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Format Code
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Format Code', 'LITERAL', '42', '42', '1',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Spaces
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'I',
		'Service-Filler', 'LITERAL', '43', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Detail Header Record (3rd Header record)
		-- -----------------------------------------------
		-- Pos 1-1      1	Record Type "5"
		-- Pos 2-11	10	Company Name
		-- Pos 12-21	10	Bank - "MELLONEAST"
		-- Pos 22-31	10	Checking Account Number
		-- Pos 32-80    49	Filler - Spaces

		-- Record Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'J',
		'Detail Header-Record Type', 'LITERAL', '01', '01', '5',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Company Name
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'J',
		'Detail Header-Company', 'LITERAL', '02', '11', SubString(@CpnyName,1,10),
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Destination
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'J',
		'Detail Header-Destination', 'LITERAL', '12', '21', 'MELLONEAST',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Account
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'J',
		'Detail Header-Checking Account', 'BANKACCT', '22', '31', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'J',
		'Detail Header-Filler', 'LITERAL', '32', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Service Total Record (1st Trailer Record)
		-- -----------------------------------------------
		-- Pos 1-1	1	Record Type "8"
		-- Pos 2-11	10	Number of Add Issue Items
		-- Pos 12-23	12	Dollar Total of Add Issue Items
		-- Pos 24-33	10	Number of Void Issue Items
		-- Pos 34-45	12	Dollar Total of Void Issue Items
		-- Pos 46-80	35	Filler (zeros)

		-- Record Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Record Type', 'LITERAL', '01', '01', '8',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Number of Add Issue Items
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Add Issues', 'RECCNT-CHK', '02', '11', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Dollar Total of Add Issue Items
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Dollar Add Issue', 'CHKSUMAMNV', '12', '23', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Number of Void Items
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Voids', 'RECCNT-VOD', '24', '33', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Dollar Total of Void Items
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Dollar Voids', 'CHKSUMAMVO', '34', '45', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Svc Total-Filler', 'LITERAL', '46', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- -----------------------------------------------
		-- Trailer Record (2nd Trailer Record)
		-- -----------------------------------------------
		-- Pos 1-1	1	Record Type "9"
		-- Pos 2-7	6	Total Number of Records (includes all Header/Trailer)
		-- Pos 8-80	73	Filler (zeros)

		-- Record Type
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'Trailer-Record Type', 'LITERAL', '01', '01', '9',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Number of Records
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'Trailer-Total Records', 'RECCNT-HT', '02', '07', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'U',
		'Trailer-Filler', 'LITERAL', '08', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'HARRIS'
	BEGIN

		-- Formats courtesy of: OmniVue

		-- Different trailer record for issue and void batches
		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-2	2	"00"
		-- Pos 3-9	7	Checking Account Number	RJLZF
		-- Pos 10-19	10	"9999999999"
		-- Pos 20-21	2	"40"-Issue, "43"-Voids
		-- Pos 22-31	10	Total Issue/Void amounts
		-- Pos 32-37	6	Total Issue/Void count
		-- Pos 38-40    3	"000"

		-- Literal - 00
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-00', 'LITERAL', '01', '02', '00',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank Account
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Checking Account Nbr', 'BANKACCT', '03', '09', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Literal - 9999999999
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-9999999999', 'LITERAL', '10', '19', '9999999999',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Batch Type - Check/Void
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Batch Type-Check', 'BATCH-TYPE', '20', '21', '4043',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Amount', 'CHKSUMAMT', '22', '31', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Number of Checks/Voids
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Count', 'RECCNT', '32', '37', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Literal - 000
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-000', 'LITERAL', '38', '40', '000',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'M&T'
	BEGIN

		-- Formats courtesy of: IAM Nationl Pension Fund

		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-1	1	"T" Total Indicator
		-- Pos 2-11	8	Filler
		-- Pos 12-20	9	Total Detail Records RJLZF (includes voids)
		-- Pos 21-32	12	Total Amount RJLZF (voids are positive)
		-- Pos 33-80    48	Filler

		-- Literal - "T"
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total Indicator', 'LITERAL', '01', '01', 'T',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler - blanks
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total Record-Filler', 'LITERAL', '02', '11', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Detail Records (includes voids)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total rec count', 'RECCNT', '12', '20', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total Amount', 'CHKSUMAMT', '21', '32', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler - blanks
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Total Record-Filler', 'LITERAL', '33', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END


	if @FormatID = 'USBANK'
	BEGIN

		-- Formats courtesy of: RBG

		-- Different trailer record for issue and void batches
		-- -----------------------------------------------
		-- Trailer Record
		-- -----------------------------------------------
		-- Pos 1-2	2	"02" Record Code
		-- Pos 3-14	12	Account Number	RJLZF
		-- Pos 15-24	10	Total Detail Records RJLZF
		-- Pos 25-36	12	Total Amount RJLZF
		-- Pos 37-80    44	Filler

		-- Literal - 02
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-00', 'LITERAL', '01', '02', '02',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Account Number', 'BANKACCT', '03', '14', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Detail Records (includes voids)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Detail Records', 'RECCNT', '15', '24', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Total Amount (includes voids as positives)
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Total Amount', 'CHKSUMAMT', '25', '36', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler - blanks
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'T',
		'Tot Record-Filler', 'LITERAL', '37', '80', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

	END

	if @FormatID = 'WELLSFARGO'
	BEGIN

		-- Formats courtesy of: Systematic Solutions
		-- Modified 6/9/04 - removed trailer record here, now in Crystal report
		
		-- First remove first Header record
		DELETE
		FROM		XDDACHHeadTrail
		WHERE		FileType = 'P'
				and FormatID = @FormatID
				and HeadTrailID = 'A'
				and Header_Trailer = 'H'

		-- -----------------------------------------------
		-- Header Record (*03 Header Record)
		-- -----------------------------------------------
		-- Pos 1-3	3	*03
		-- Pos 4-8	5	Bank ID RJ-LZF (specific to each bank)
		-- Pos 9-23	15	Account Number RJ-LZF
		-- Pos 24	1	File Status (0)
		-- Pos 25-80	56	Filler (spaces)

		-- *03 Record
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-*03', 'LITERAL', '01', '03', '*03',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Bank ID
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Bank ID', 'LITERAL', '04', '08', 'Enter 5 digit Bank ID here - RJ-LZF',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Account Number
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Account Number', 'BANKACCTRJ', '09', '23', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- File Status
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-File Status', 'LITERAL', '24', '24', '0',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')

		-- Filler
		INSERT INTO	XDDACHHeadTrail
		(FileType, FormatID, HeadTrailID, Header_Trailer,
		Descr, EntryType, StartPos, EndPos, Value,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		VALUES
		('P', @FormatID, 'A', 'H',
		'Header-Filler', 'LITERAL', '25', '80', ' ',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'','','',0,0,'','','01/01/1900','01/01/1900','')
		
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDACHHeadTrail_Import_Format] TO [MSDSL]
    AS [dbo];

