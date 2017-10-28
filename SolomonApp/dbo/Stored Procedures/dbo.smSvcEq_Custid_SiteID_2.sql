 CREATE PROCEDURE smSvcEq_Custid_SiteID_2 @parm1 varchar(15),@parm2 varchar (10),@parm3 varchar(10)
AS
        SELECT * FROM smSvcEquipment
         WHERE Status = 'A'
           AND CustId LIKE @parm1
           AND SiteID LIKE @parm2
           AND EquipID LIKE @parm3
      ORDER BY EquipID


