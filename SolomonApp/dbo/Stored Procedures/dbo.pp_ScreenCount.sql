 CREATE PROC pp_ScreenCount @InternetAddress VARCHAR(21), @ScrnNbr VARCHAR(7), @DBName VARCHAR(30), @CompanyID VARCHAR(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************************************************************
*             Copyright Solomon Software, Inc. 2000-2004  All Rights Reserved
**    Proc Name        : pp_ScreenCount
**++* Narrative        : Counts the number of instances of a screen running
*                       a) either in the same machine, and/or
*                       b) in the current database, and/or
*                       c) for the same company.
*    Inputs           : @InternetAddress  VARCHAR(21) Workstation id of caller or
*                                                     '%' for checking system-wide occurences
**                       @ScrnNbr          VARCHAR( 7) Calling Screen Number. The screen number is
*                                                     only 5 chars in the Access table. We are
*                                                     passing 7 chars due to possible future  enhancements.
*
*                       @DbName           VarChar(30) Application database name
*                                                     This can be '%' to check across all application databases.
**                       @CpnyID           VarChar(10) Company ID
*                                                     This can be '%' to check across all companies.
**    Output           : ComputerName and Count of instances of the parameter screen
**    Assumptions      : First five charecters of the screen ID will be passed at this time.
*
**    Note             : If the calling app is checking for its another instance
*                       -- since this proc is  called after ScreenInit --
*                       the result set will contain atleast '1'.
*                       The ComputerName will be useful when the calling application is
*                        passing "%" for @InternetAddress.
*
*   Called by          : 08400 A/R Release or any other screen's form_load event
*
********************************************************************************************************************************/

 SELECT  InternetAddress, CNT = COUNT(*)
   FROM  VS_ACCESS
   WHERE InternetAddress  LIKE @InternetAddress And
         ScrnNbr          =    @ScrnNbr         And
         DataBaseName     LIKE @DBName          And
         CompanyID        LIKE @CompanyID
GROUP BY InternetAddress



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_ScreenCount] TO [MSDSL]
    AS [dbo];

