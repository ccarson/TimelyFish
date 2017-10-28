 CREATE PROCEDURE pp_CleanWrkPost @UserAddress char(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/* Delete all batches for my user */
DELETE WrkPost where UserAddress = @UserAddress

/* Delete batches if we cannot find an access record for the correct
   InternetAddress(Useraddress).  Since the access table in the system
   Database can point to multiple app databases, also make check the database
   name to make sure were only deleting records for the app db we are currently in.) */

DELETE w
  FROM Wrkpost w
 WHERE NOT EXISTS
     (SELECT 'Orphaned WrkPost Records'
        FROM vs_Access va
       WHERE w.useraddress = va.InterNetAddress AND
             va.ScrnNbr IN('01520','0152000') AND
             va.DatabaseName = DB_NAME())
   AND NOT EXISTS (SELECT 'Web Service No Longer Running' 
                     FROM vs_webserviceaccess ws 
                    WHERE w.Useraddress = SUBSTRING(CAST(ws.ID AS VARCHAR(36)),16,21) ) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_CleanWrkPost] TO [MSDSL]
    AS [dbo];

