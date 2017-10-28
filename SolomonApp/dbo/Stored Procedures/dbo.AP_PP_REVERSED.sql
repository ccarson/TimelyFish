 CREATE PROCEDURE AP_PP_REVERSED
	@RefNbr varchar(10),
	@Acct   varchar(10),
	@Sub    varchar(24)
AS

DECLARE @count1 AS integer
DECLARE @count2 AS integer
Declare @Ref as varchar(10)

set @count1 = 0
set @count2 = 0

select @ref = AdjdRefNbr from APAdjust where AdjgRefNbr = @RefNbr and AdjgAcct = @Acct and AdjgSub = @Sub and AdjdDocType = 'PP'


SELECT 	@count1 = count(*)
FROM	AP_PPApplicDet
WHERE	PPRefNbr = @Ref
AND	OperType = 'A'

SELECT 	@count2 = count(*)
FROM	AP_PPApplicDet
WHERE	PPRefNbr = @Ref
AND	OperType = 'R'

if @count1 > @count2
Select	RecordCount = 1
else if @count2 > @count1
Select RecordCount = 2


