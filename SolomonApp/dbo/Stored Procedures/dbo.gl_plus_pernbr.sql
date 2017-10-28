 CREATE PROCEDURE gl_plus_pernbr @per CHAR(6), @outper CHAR(6) output
AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
**    Proc Name: gl_plus_pernbr
**++* Narrative: Given  year and period (per) outputs the next period (outper) taking
*++*            into account the number periods used at this site.
**
*       Inputs: per      CHAR(6)   period passed in the form of YYYYPP
*               outper   CHAR(6)   Output Period in the form of YYYYPP
**   Called by: pp_01400
*
*/
DECLARE @year CHAR(4)
DECLARE @month CHAR(2)

SELECT @year=SUBSTRING(@per,1,4)
select @month=CONVERT(CHAR(2),CONVERT(INT,SUBSTRING(@per,5,2))+1)
IF CONVERT(INT,@month) > (SELECT nbrper FROM glsetup (NOLOCK))
BEGIN
  SELECT @month='01'
  SELECT @year=CONVERT(CHAR(4),CONVERT(INT,@year)+1)
END
ELSE
BEGIN
  IF CONVERT(INT,@month) <= 9
     SELECT @month='0'+@month
END
SELECT @outper=@year+@month


