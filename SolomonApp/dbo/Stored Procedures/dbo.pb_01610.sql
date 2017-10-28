 CREATE PROCEDURE pb_01610 @RI_ID SMALLINT AS

DECLARE @RI_Where       varchar(1024),
        @StdSelect      varchar(1024),
        @BegPerNbr      VARCHAR(6),
        @EndPerNbr      VARCHAR(6),
        @BegPerYr       VarChar(4),
        @EndPerYr       VarChar(4),
        @BegPerMo       VarChar(2),
        @EndPerMo       VarChar(2),
        @Activity1      CHAR(10),
        @Activity2      CHAR(10),
        @Rep       CHAR(10)

SELECT  @RI_Where       = LTRIM(RTRIM(RI_Where)),
        @BegPerNbr      = BegPerNbr,
        @EndPerNbr      = EndPerNbr,
        @BegPerYr       = SubString(BegPerNbr,1,4),
        @EndPerYr       = SubString(EndPerNbr,1,4),
        @BegPerMo       = SubString(BegPerNbr,5,2),
        @EndPerMo       = SubString(EndPerNbr,5,2),
        @Activity1      = ShortAnswer00,
        @Activity2      = ShortAnswer01,
        @Rep            = ReportName


FROM RptRunTime
WHERE RI_ID = @RI_ID

-- To create more space for the Sort/Select criteria, an additional check will be processed if the
-- ROI BegPerYr and the EndPerYr are the same.  If true, then the FiscYr will need to just equal the BegPerYr.  This will
-- eliminate the need for the BETWEEN check.


IF @Activity2 = 'True'
   IF @BegPerYr = @EndPerYr
      SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND {vr_01610a.Ending_Balance} <> 0.00 '+ ' AND {vr_01610a.FiscYr} = ''' + @BegPerYr + ''' '
   ELSE
      SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                       ' AND {vr_01610a.Ending_Balance} <> 0.00 '+ ' AND {vr_01610a.FiscYr} >= ''' + @BegPerYr + ''' AND {vr_01610a.FiscYr} <= ''' + @EndPerYr + ''' '
ELSE
   IF @Activity2 = 'False' and @Activity1 = 'True'
      IF @BegPerYr = @EndPerYr
         SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                          ' AND (({vr_01610a.DrAmtTot} <> 0.00 OR {vr_01610a.CrAmtTot} <> 0.00) '+ ' OR {vr_01610a.Ending_Balance} <> 0.00) '+ ' AND {vr_01610a.FiscYr} = ''' + @BegPerYr + ''' '
     ELSE
       SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                      ' AND (({vr_01610a.DrAmtTot} <> 0.00 OR {vr_01610a.CrAmtTot} <> 0.00) '+ ' OR {vr_01610a.Ending_Balance} <> 0.00) '+ ' AND {vr_01610a.FiscYr} >= ''' + @BegPerYr + ''' AND {vr_01610a.FiscYr} <= ''' + @EndPerYr + ''' '
    ELSE
      IF @BegPerYr = @EndPerYr
         SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                          ' AND {vr_01610a.FiscYr} = ''' + @BegPerYr + ''' '
      ELSE
         SET @StdSelect = '{vr_01610a.RPT_Company_RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) +
                          ' AND {vr_01610a.FiscYr} >= ''' + @BegPerYr + ''' AND {vr_01610a.FiscYr} <= ''' + @EndPerYr + ''' '

-- To create more space for the Sort/Select criteria, the RI_where prefix will be trimmed.  This
-- eliminate unnecessary characters.
IF @Rep = '01611A' or @Rep = '01611B'
BEGIN
    -- REmove the curly brackets as this Where cluase is going to SSRS
    SELECT @RI_WHERE = REPLACE(@RI_WHERE,'{','')
    SELECT @RI_WHERE = REPLACE(@RI_WHERE,'}','')
    SELECT @StdSelect = REPLACE(@StdSelect,'{','')
    SELECT @StdSelect = REPLACE(@StdSelect,'}','')
END

IF @Rep = '01610B' or @Rep = '01611B'
BEGIN
    -- If its a different format, change the table name.
    SELECT @RI_WHERE = REPLACE(@RI_WHERE,'vr_01610A.','vr_01610B.')
    SELECT @StdSelect = REPLACE(@StdSelect,'vr_01610A.','vr_01610B.')
END

-- Update the RI_Where field of RptRuntime for this report's RI_ID with the updated @RI_Where variable.
-- If the updated @RI_Where exceeds the 254 character field limit then an ?RaiseError? is issued so the
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
    ON OBJECT::[dbo].[pb_01610] TO [MSDSL]
    AS [dbo];

