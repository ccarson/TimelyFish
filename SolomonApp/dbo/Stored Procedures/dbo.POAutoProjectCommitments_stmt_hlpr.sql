 CREATE PROCEDURE POAutoProjectCommitments_stmt_hlpr
   @table			VARCHAR(60) -- either PJCOMSUM or PJCOMROL
 , @stmttype		CHAR(1) -- 'I' for INSERT, 'U' for UPDATE
 , @period			CHAR (6)
 , @amount			FLOAT
 , @precision		INT
 , @units			FLOAT
 , @prog			CHAR(5)
 , @user			VARCHAR(10)
 , @project			VARCHAR(16)
 , @task			VARCHAR(32)
 , @acct			VARCHAR(16)
 , @ProjCuryAmount	FLOAT
 , @ProjCuryPrec	INT
 , @sql				VARCHAR(2000) OUTPUT -- check for the right size later
  AS
-- =======================================================================================================
-- POAutoProjectCommitments_stmt_hlpr.crp
-- Helper for POAutoProjectCommitments.crp. Builds an INSERT or UPDATE sql command string.
 -- Parameters:
-- @table      - table to use in the statment; PJCOMSUM or PJCOMROL
-- @stmttype   - type of statment to build; 'I' for INSERT, 'U' for UPDATE
-- @period     - current to use in building the year and period parameters
-- @amount     - data to use in the statement
-- @precision  - base decimal places for rounding (only used for UPDATE)
-- @units      - data to use in the statement
-- @prog       - data to use in the statement
-- @user       - data to use in the statement
-- @project    - data to use in the statement
-- @task       - data to use in the statement
-- @acct       - data to use in the statement
-- @sql        - holds the statemtn being built
-- =======================================================================================================

-- First off bail out if we don't get some expected values. Of course if any values
-- used to build the query are NULL, the result will be NULL too.
IF (@table IS NULL)
    OR (@stmttype IS NULL)
    OR (@table <> 'PJCOMSUM' AND @table <> 'PJCOMROL')
    OR (@stmttype <> 'I' AND @stmttype <> 'U')
    GOTO ABORT

DECLARE @QT AS CHAR(1)	-- to insert quotes into the statement
SET @QT = CHAR(39) -- use single quote

IF @stmttype = 'U' -- Build an UPDATE statement
    SET @sql = SPACE(1) +
        'UPDATE ' + @table + SPACE(1) +
        'SET amount_' + RIGHT(@period, 2) + ' = ROUND(amount_' + RIGHT(@period, 2) + ' + ' + LTRIM(STR(@amount, 26, @precision)) + ', ' + LTRIM(STR(@precision, 11, 0)) + ')' +
          ', units_' + RIGHT(@period, 2) + ' = units_' + RIGHT(@period, 2) + ' + ' + LTRIM(STR(@units, 26, 15)) +
          ', lupd_datetime = GETDATE()' +
          ', lupd_prog = ' + @QT + @prog + @QT + SPACE(1) +
          ', lupd_user = ' + @QT + @user + @QT + SPACE(1) +
		  ', ProjCury_amount_' + RIGHT(@period, 2) + ' = ROUND(ProjCury_amount_' + RIGHT(@period, 2) + ' + ' + LTRIM(STR(@ProjCuryamount, 26, @ProjCuryPrec)) + ', ' + LTRIM(STR(@ProjCuryPrec, 11, 0)) + ')' +
        'WHERE project = ' + @QT + @project + @QT + SPACE(1) +
        CASE WHEN @table = 'PJCOMSUM' THEN
                  'AND pjt_entity = ' + @QT + @task + @QT + SPACE(1)
             ELSE ''
        END +
         'AND acct = ' + @QT + @acct + @QT + SPACE(1) +
         'AND fsyear_num = ' + @QT + LEFT(@period, 4) + @QT + SPACE(1)
ELSE -- Build an INSERT statment
    SET @sql = SPACE(1) +
        'INSERT INTO ' + @table + SPACE(1) +
        '( acct' +
        ', amount_01' +
        ', amount_02' +
        ', amount_03' +
        ', amount_04' +
        ', amount_05' +
        ', amount_06' +
        ', amount_07' +
        ', amount_08' +
        ', amount_09' +
        ', amount_10' +
        ', amount_11' +
        ', amount_12' +
        ', amount_13' +
        ', amount_14' +
        ', amount_15' +
        ', amount_bf' +
        ', crtd_datetime' +
        ', crtd_prog' +
        ', crtd_user' +
        ', data1' +
        ', fsyear_num' +
        ', lupd_datetime' +
        ', lupd_prog' +
        ', lupd_user' +
        CASE WHEN @table = 'PJCOMSUM' THEN
                  ', pjt_entity'
             ELSE ''
        END +
		', ProjCury_amount_01' +
		', ProjCury_amount_02' +
		', ProjCury_amount_03' +
		', ProjCury_amount_04' +
		', ProjCury_amount_05' +
		', ProjCury_amount_06' +
		', ProjCury_amount_07' +
		', ProjCury_amount_08' +
		', ProjCury_amount_09' +
		', ProjCury_amount_10' +
		', ProjCury_amount_11' +
		', ProjCury_amount_12' +
		', ProjCury_amount_13' +
		', ProjCury_amount_14' +
		', ProjCury_amount_15' +
		', ProjCury_amount_bf' +
        ', project' +
        ', units_01' +
        ', units_02' +
        ', units_03' +
        ', units_04' +
        ', units_05' +
        ', units_06' +
        ', units_07' +
        ', units_08' +
        ', units_09' +
        ', units_10' +
        ', units_11' +
        ', units_12' +
        ', units_13' +
        ', units_14' +
        ', units_15' +
        ', units_bf' +
        ') ' +
        'VALUES ' +
        '( ' + @QT + @acct + @QT +
        CASE RIGHT(@period, 2)
            WHEN '01' THEN
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '02' THEN
                ', 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '03' THEN
                ', 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '04' THEN
                ', 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '05' THEN
                ', 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '06' THEN
                ', 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '07' THEN
                ', 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '08' THEN
                ', 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0, 0'
            WHEN '09' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0, 0'
            WHEN '10' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0, 0'
            WHEN '11' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0, 0'
            WHEN '12' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0, 0'
            WHEN '13' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0, 0'
            WHEN '14' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision)) +
                ', 0'
            WHEN '15' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@amount, 26, @precision))
            ELSE
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
        END +
        ', 0' +
        ', GETDATE()' +
        ', ' + @QT + @prog + @QT +
        ', ' + @QT + @user + @QT +
        ', ' + @QT + @QT +
        ', ' + @QT + LEFT(@period, 4) + @QT +
        ', GETDATE()' +
        ', ' + @QT + @prog + @QT +
        ', ' + @QT + @user + @QT +
        CASE WHEN @table = 'PJCOMSUM' THEN
                  ', ' + @QT + @task + @QT
             ELSE ''
        END + 
		--', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' + -- ProjCury Amount Fields
		        CASE RIGHT(@period, 2)
            WHEN '01' THEN
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '02' THEN
                ', 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '03' THEN
                ', 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '04' THEN
                ', 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '05' THEN
                ', 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '06' THEN
                ', 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '07' THEN
                ', 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '08' THEN
                ', 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0, 0'
            WHEN '09' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0, 0'
            WHEN '10' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0, 0'
            WHEN '11' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0, 0'
            WHEN '12' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0, 0'
            WHEN '13' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0, 0'
            WHEN '14' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec)) +
                ', 0'
            WHEN '15' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@ProjCuryAmount, 26, @ProjCuryPrec))
            ELSE
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
        END +
        ', 0' +
		', ' + @QT + @project + @QT +
        CASE RIGHT(@period, 2)
            WHEN '01' THEN
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '02' THEN
                ', 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '03' THEN
                ', 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '04' THEN
                ', 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
          WHEN '05' THEN
                ', 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '06' THEN
                ', 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '07' THEN
                ', 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0, 0'
            WHEN '08' THEN
                ', 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0, 0'
            WHEN '09' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0, 0'
            WHEN '10' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0, 0'
            WHEN '11' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0, 0'
            WHEN '12' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0, 0'
            WHEN '13' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0, 0'
            WHEN '14' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15)) +
                ', 0'
            WHEN '15' THEN
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0' +
                ', ' + LTRIM(STR(@units, 26, 15))
            ELSE
                ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
        END +
        ', 0' +
        ') '

ABORT:


