 CREATE PROCEDURE pb_01620 @RI_ID SMALLINT AS

DECLARE @RI_Where       varchar(1024),
        @StdSelect      varchar(1024),
        @BegPerNbr      VARCHAR(6),
        @EndPerNbr      VARCHAR(6),
        @BegPerYr       VarChar(4),
        @EndPerYr       VarChar(4),
        @BegPerMo       VarChar(2),
        @EndPerMo       VarChar(2),
        @Activity       CHAR(10),
        @Rep       CHAR(10)

SELECT  @RI_Where       = LTRIM(RTRIM(RI_Where)),
        @BegPerNbr      = BegPerNbr,
        @EndPerNbr      = EndPerNbr,
        @BegPerYr       = SubString(BegPerNbr,1,4),
        @EndPerYr       = SubString(EndPerNbr,1,4),
        @BegPerMo       = SubString(BegPerNbr,5,2),
        @EndPerMo       = SubString(EndPerNbr,5,2),
        @Activity       = ShortAnswer00,
        @Rep            = ReportName
FROM RptRunTime
WHERE RI_ID = @RI_ID

-- If the ROI Options tab field 'Print only Accounts with Activity' is checked (@Activity = True)
-- then select off any records with no Period Activity (PTDBAL for period being processed).
-- This indicates there was no activity for the period.
--
-- To create more space for the Sort/Select criteria, an additional check will be processed if the
-- ROI BegPerYr and the EndPerYr are the same then the FiscYr will need to just equal the BegPerYr.  This will
-- eliminate the need for the BETWEEN check.

IF @Activity = 'True'
   IF @BegPerYr = @EndPerYr
      SET @StdSelect = '{vr_01620.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND ({vr_01620.Period_Activity} <> 0.00 OR {vr_01620.GLTran_BatNbr} <>'''') '+ ' AND {vr_01620.FiscYr} = ''' + @BegPerYr + ''' '
   ELSE
      SET @StdSelect = '{vr_01620.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND ({vr_01620.Period_Activity} <> 0.00 OR {vr_01620.GLTran_BatNbr} <>'''') '+ ' AND {vr_01620.FiscYr} IN ''' + @BegPerYr + ''' to ''' + @EndPerYr + ''' '
ELSE
   IF @BegPerYr = @EndPerYr
      SET @StdSelect = '{vr_01620.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND {vr_01620.FiscYr} = ''' + @BegPerYr + ''' '
   ELSE
      SET @StdSelect = '{vr_01620.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND {vr_01620.FiscYr} in ''' + @BegPerYr + ''' to ''' + @EndPerYr + ''' '

-- For Performance, the year entered will be checked.  If they are the same then add the month index
-- to enhance performance of the query.
--
-- To create more space for the Sort/Select criteria, an additional check will be processed if the
-- ROI BegPerNbr and the EndPerNbr are the same then the Month will need to just equal the BegPerYr.  This will
-- eliminate the need for the BETWEEN check.

IF @BegPerYr = @EndPerYr
  IF @BegPerMo = @EndPerMo
     SET @StdSelect = @StdSelect + 'AND {vr_01620.Month} = ''' + @BegPerMo + ''' '
  ELSE
    SET @StdSelect = @StdSelect + 'AND {vr_01620.Month} in ''' + @BegPerMo + ''' to ''' + @EndPerMo + ''' '

-- To create more space for the Sort/Select criteria, the RI_where prefix will be trimmed.  This
-- eliminate unnecessary characters.
IF @Rep = '01620MC'
BEGIN
   SELECT @RI_WHERE = REPLACE(@RI_WHERE,'vr_01620.','vr_01620MC.')
   SELECT @StdSelect = REPLACE(@StdSelect,'vr_01620.','vr_01620MC.')
END

-- Update the RI_Where field of RptRuntime for this report's RI_ID with the updated @RI_Where variable.
-- If the updated @RI_Where exceeds the 255 character field limit then an ?RaiseError? is issued so the
-- user is aware of this limitation.  When this occurs the @RI_Where is set to the standard selection
-- criteria to ensure the report will execute correctly.

UPDATE RptRunTime
SET RI_Where = CASE WHEN DATALENGTH(@RI_Where) = 0 THEN
                         @StdSelect
                    ELSE
                         @StdSelect + ' AND (' + @RI_WHERE + ')'
               END
WHERE (RI_ID = @RI_ID)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_01620] TO [MSDSL]
    AS [dbo];

