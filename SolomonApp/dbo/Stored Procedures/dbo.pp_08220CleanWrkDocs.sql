
CREATE PROCEDURE pp_08220CleanWrkDocs  @UserAddress VARCHAR(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/* Delete all work records for my user */
DELETE FROM Wrk08220ARDoc WHERE UserAddress = @UserAddress
DELETE FROM Wrk08220ARTran WHERE UserAddress = @UserAddress
DELETE FROM Wrk08220SalesTax WHERE UserAddress = @UserAddress


/* Delete other work records if we cannot find an access record for the correct
   InternetAddress(Useraddress). Since the access table in the system
   dastabase can point to multiple app databases, also need to check the 
   database name to make sure were only deleting records for the app db we are currently in.)
   Also do not delete ARDebug address as they are run from query analyzer and won't be
   in the access table */
DELETE w
  FROM Wrk08220ARDoc w WITH(NOLOCK)
 WHERE w.UserAddress <> 'ARDebug'
   AND NOT EXISTS
     (SELECT 'Still Running'
        FROM vs_Access va
       WHERE w.useraddress = va.InterNetAddress
         AND va.DatabaseName = DB_NAME()
     )

DELETE w
  FROM Wrk08220ARTran w WITH(NOLOCK)
 WHERE w.UserAddress <> 'ARDebug'
   AND NOT EXISTS
     (SELECT 'Still Running'
        FROM vs_Access va
       WHERE w.useraddress = va.InterNetAddress
         AND va.DatabaseName = DB_NAME()
     )

DELETE w
  FROM Wrk08220SalesTax w WITH(NOLOCK)
 WHERE w.UserAddress <> 'ARDebug'
   AND NOT EXISTS
     (SELECT 'Still Running'
        FROM vs_Access va
       WHERE w.useraddress = va.InterNetAddress
         AND va.DatabaseName = DB_NAME()
     )


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08220CleanWrkDocs] TO [MSDSL]
    AS [dbo];

