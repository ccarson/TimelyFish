 -- **********************************************************************************************
--
--  WARNING:	 THE FOLLOWING CODE SHOULD NOT BE MODIFIED! CHANGING THIS CODE MAY
--		 RESULT IN CORRUPTED DATA AND INSTABILITY IN APPLICATIONS.
--
--  Copyright:  1999-2002 Solomon Software, Inc.
--              200 E Hardin Street
--              Findlay, OH  45840
--              800-4-SOLOMON
--              www.solomon.com
--
--  Name:       SameTaxIDGroupIDCheck
--  Inputs:     @ID0    Tax ID 1
--              @ID1    Tax ID 2
--              @ID2    Tax ID 3
--              @ID3    Tax ID 4
--  Output:
--  Called by:  0801000 And 082600 Screens
--  Calling:    None
--  Purpose:    Verify duplicate entry of same tax ID in any single line
--  Version:    4.21.0001
--  Author:     Solomon Software, Inc. - Financial Management Group
--  Comment:    When printing, for best output print in Landscape mode with margin settings of 0.5 inch.
--              Any count value greater than zero means a repetetive TaxIDs on the same line
--
--  History:    Lists History of source asset:
--              2000/02/29 - Original source asset created.
--  *********************************************************************************************
--
CREATE PROCEDURE SameTaxIDGroupIDCheck @ID0 CHAR(10), @ID1 CHAR(10), @ID2 CHAR(10), @ID3 CHAR(10) AS

SELECT
--
-- TaxIDs within a group also are included individually
--
(  SELECT  COUNT(*)
     FROM  SlsTaxGrp (NOLOCK)
    WHERE (GroupID=@ID0 OR GroupID=@ID1 OR GroupID=@ID2 OR GroupID=@ID3) AND
          (TaxID=@ID0 OR TaxID=@ID1 OR TaxID=@ID2 OR TaxID=@ID3)
) +
--
-- Two different groups contain same TaxIDs
--
(  SELECT  COUNT(*)
     FROM  SlsTaxGrp g1 (NOLOCK)
             INNER JOIN SlsTaxGrp g2 (NOLOCK) ON g1.TaxID=g2.TaxID AND g1.GroupID<>g2.GroupID
    WHERE (g1.GroupID=@ID0 OR g1.GroupID=@ID1 OR g1.GroupID=@ID2 OR g1.GroupID=@ID3) AND
          (g2.GroupID=@ID0 OR g2.GroupID=@ID1 OR g2.GroupID=@ID2 OR g2.GroupID=@ID3)
) +
--
-- Two Individual tax IDs are the same
--
(  SELECT CASE
          WHEN (@ID0=@ID1 OR @ID0=@ID2 OR @ID0=@ID3) AND @ID0<>'' OR
               (@ID1=@ID2 OR @ID1=@ID3)              AND @ID1<>'' OR
               @ID2=@ID3 AND @ID2<>''
         THEN 1
         ELSE 0
END
)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SameTaxIDGroupIDCheck] TO [MSDSL]
    AS [dbo];

