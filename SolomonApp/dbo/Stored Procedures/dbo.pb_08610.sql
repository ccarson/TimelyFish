﻿ --USETHISSYNTAX

CREATE PROCEDURE pb_08610 @RI_ID SMALLINT

AS

DECLARE @RI_Where varchar(1024), @Search varchar(1024), @Pos SMALLINT,
	@BegPerNbr VARCHAR(6), @EndPerNbr VARCHAR(6), @TabPrefix VARCHAR(30)

SELECT @RI_Where = LTRIM(RTRIM(RI_Where)), @BegPerNbr = BegPerNbr, @EndPerNbr = EndPerNbr,
	--translate the report number into corresponding table/view prefix   
	   @TabPrefix = Case WHEN ReportName='08610s' THEN 'vr_08610sp'
                         ELSE 'vr_'+Replace(ReportName,'M','')--multi-cury use same view as regular so just trim 'M'
                    END
FROM RptRunTime
WHERE RI_ID = @RI_ID

SELECT @Search = '({'+ RTRIM(@TabPrefix) + '.RI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + 
                 ' AND {' + RTRIM(@TabPrefix)+ '.cRI_ID} = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ')'

SELECT @Pos = PATINDEX('%' + @Search + '%', @RI_Where)

UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos <= 0
		THEN @Search + ' AND (' + @RI_WHERE + ')'
END
WHERE RI_ID = @RI_ID


