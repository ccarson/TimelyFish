 
/*
	Return the decimal places for base currency, base BMI currency, inventory setup cost and quantity
*/
Create View vp_DecPl
AS

SELECT	
	BaseDecPl = BaseCury.DecPl,
	BMIDecPl = ISNULL(BMICury.DecPl,BaseCury.DecPl),
	INSetup.DecPlPrcCst, 
	INSetup.DecPlQty
  FROM  INSetup (NOLOCK) CROSS JOIN GLSetup (NOLOCK)
                      JOIN Currncy BaseCury (NOLOCK) 
                        ON GLSetup.BaseCuryID = BaseCury.Curyid
                 LEFT JOIN Currncy BMICury (NOLOCK)
                        ON INSetup.BMICuryID   = BMICury.Curyid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


 
