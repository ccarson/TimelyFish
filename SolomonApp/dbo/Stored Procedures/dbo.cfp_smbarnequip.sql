CREATE PROCEDURE cfp_smbarnequip @parm1 varchar(15),@parm2 varchar (10),@parm3 varchar(10)
AS 
        SELECT * FROM smSvcEquipment
         WHERE Status = 'A' 
           AND CustId LIKE @parm1
           AND SiteID LIKE @parm2
           AND EquipID LIKE @parm3
	   AND EquipTypeID = 'BARN'
      ORDER BY EquipID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_smbarnequip] TO [MSDSL]
    AS [dbo];

