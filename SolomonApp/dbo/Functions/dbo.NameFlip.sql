
CREATE FUNCTION [dbo].[NameFlip] 
(
	@Full Varchar(50)
)
RETURNS Varchar(50)
AS
BEGIN
DECLARE @Fixed Varchar(50)
SELECT @Fixed = CASE WHEN Ltrim(Rtrim(@Full)) LIKE '%~%' THEN substring(Ltrim(Rtrim(@Full)) , charindex('~' , Ltrim(Rtrim(@Full))) + 1 , LEN(Ltrim(Rtrim(@Full))) - charindex('~' , Ltrim(Rtrim(@Full)))) + ' ' + substring(Ltrim(Rtrim(@Full)) , 1 , charindex('~' , Ltrim(Rtrim(@Full))) - 1) ELSE Ltrim(Rtrim(@Full)) END
	RETURN (@Fixed)
END

