 CREATE PROCEDURE pp_CleanWrkRelease  @UserAddress VARCHAR(21), @Module VARCHAR(2)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/* Delete all batches for my user */
DELETE WrkRelease WHERE UserAddress = @UserAddress And Module = @Module

/* Delete AP, AR, and GL batches if we cannot find an access record for the correct
   InternetAddress(Useraddress) and ScrnNbr(Module). Since the access table in the system
   dastabase can point to multiple app databases, also make check the database name to make
   sure were only deleting records for the app db we are currently in.)
   Also do not delete AR/AP debug addresses as they are run from query analyzer and won't be
   in the access table */
DELETE w
  FROM Wrkrelease w WITH(NOLOCK)
 WHERE MODULE in ('AP','AR','GL')
   AND w.UserAddress NOT IN ('APDebug','ARDebug')
   AND NOT EXISTS (SELECT 'Web Service No Longer Running' 
                     FROM vs_webserviceaccess ws 
                    WHERE w.Useraddress = SUBSTRING(CAST(ws.ID AS VARCHAR(36)),16,21) )   
   AND NOT EXISTS
     (SELECT 'No longer running'
        FROM vs_Access va
       WHERE w.useraddress = va.InterNetAddress
         AND w.module = CASE va.ScrnNbr   -- convert access screen numbers to modules
                           WHEN '01400' THEN 'GL'
                           WHEN '0140000' THEN 'GL'
                           WHEN '03400' THEN 'AP'
                           WHEN '0340000' THEN 'AP'
                           WHEN '08400' THEN 'AR'
                           WHEN '0840000' THEN 'AR'
                         END
         AND va.DatabaseName = DB_NAME()
     ) -- END NOT Exists


