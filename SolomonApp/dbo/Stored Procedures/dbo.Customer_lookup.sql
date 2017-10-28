 CREATE PROCEDURE Customer_lookup @SearchBy varchar(2), @SearchInfo varchar(30), @SearchMethod varchar(1)

AS

DECLARE @szSelect	varchar(300)
DECLARE @szFrom		varchar(200)
DECLARE @szWhere	varchar(200)

DECLARE @szWhereSelection varchar(50)
DECLARE @szWhereTaskStatus	  varchar(50)

--Determines what field they are searching by.
SELECT @szWhereSelection = CASE WHEN @SearchBy = 'NA'  
                                 THEN 's.ShipToID LIKE ''' 
                                WHEN @SearchBy = 'AT' 
                                 THEN 's.attn LIKE  ''' 
                                WHEN @SearchBy = 'DE' 
                                 THEN 's.descr LIKE '''
                                WHEN @SearchBy = 'AD' 
                                 THEN 's.Addr1 LIKE '''
                                WHEN @SearchBy = 'A2' 
                                 THEN 's.Addr2 LIKE '''
                                WHEN @SearchBy = 'CT' 
                                 THEN 's.City LIKE '''
                                WHEN @SearchBy = 'ZP' 
                                 THEN 's.Zip LIKE '''
                                WHEN @SearchBy = 'PH' 
                                 THEN 's.Phone LIKE '''
                                WHEN @SearchBy = 'EQ' 
                                 THEN 'v.EquipID LIKE '''
                                WHEN @SearchBy = 'AS' 
                                 THEN 'v.AssetID LIKE '''
                                WHEN @SearchBy = 'SN' 
                                 THEN 'v.Serialnbr LIKE '''
                                WHEN @SearchBy = 'MO' 
                                 THEN 'v.ModelID LIKE '''
                                WHEN @SearchBy = 'U1' 
                                 THEN 's.User1 LIKE '''
                                WHEN @SearchBy = 'U2' 
                                 THEN 's.User2 LIKE '''
                                WHEN @SearchBy = 'U5' 
                                 THEN 's.User5 LIKE '''
                                WHEN @SearchBy = 'U6' 
                                 THEN 's.User6 LIKE '''
                                END

--Dynamically generating the SQL Statement.
SELECT @szSelect = 'SELECT v.AssetID, v.EquipID, v.Serialnbr, v.ManufID, v.ModelID, s.CustID, 
       s.ShipToID, s.Name, s.Descr, s.Attn, s.Addr1, s.Addr2, s.City, s.State, s.Zip, s.Country, 
       m.BranchID, s.Phone, s.Fax, m.GeographicZone, m.DwellingType ' 
SELECT @szFrom = ' FROM SOAddress s LEFT JOIN SMSOAddress m ON s.custid = m.custid AND s.shiptoid = m.ShipToID
       LEFT JOIN SMSvcEquipment v ON s.CustID = v.Custid AND s.siteid = v.SiteID'
If @SearchMethod = 'B' 
BEGIN
   SELECT @szWhere = ' WHERE ' + @szWhereSelection +  REPLACE( @SearchInfo,'''','''''') + '%''' 
END
ELSE
BEGIN
   SELECT @szWhere = ' WHERE ' + @szWhereSelection +  '%' + REPLACE( @SearchInfo,'''','''''') + '%''' 
END
EXEC (@szSelect + @szFrom + @szWhere)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_lookup] TO [MSDSL]
    AS [dbo];

