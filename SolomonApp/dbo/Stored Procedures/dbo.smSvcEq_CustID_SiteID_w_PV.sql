
CREATE PROCEDURE dbo.smSvcEq_CustID_SiteID_w_PV
	@CnpyId varchar(10),	        
	@CustID varchar(15),        
	@SiteID varchar(10),              
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(EquipID) FROM smSvcEquipment  
                                WHERE (smSvcEquipment.CustId = @CustID OR smSvcEquipment.CustId = '%')
				AND (smSvcEquipment.SiteId =  @SiteID OR smSvcEquipment.SiteId = '%')
				AND smSvcEquipment.CpnyID =  @CnpyId
				
				

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(EquipID )  FROM smSvcEquipment  
                                WHERE (smSvcEquipment.CustId = '" + @CustID + "' OR smSvcEquipment.CustId = '%')
				AND (smSvcEquipment.SiteId = '" + @SiteID + "' OR smSvcEquipment.SiteId = '%')
				AND smSvcEquipment.CpnyID = '" + @CnpyId + "' 
				AND " + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC ("SELECT TOP " + @Max + " EquipID, CpnyID, ManufID, ModelID, SerialNbr, Descr, LocationID FROM smSvcEquipment  
                                WHERE (smSvcEquipment.CustId = '" + @CustID + "' OR smSvcEquipment.CustId = '%')
				AND (smSvcEquipment.SiteId = '" + @SiteID + "' OR smSvcEquipment.SiteId = '%')
				AND smSvcEquipment.CpnyID = '" + @CnpyId + "' 
				                     ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + "  EquipID, CpnyID, ManufID, ModelID, SerialNbr, Descr, LocationID FROM smSvcEquipment  
                                WHERE (smSvcEquipment.CustId = '" + @CustID + "' OR smSvcEquipment.CustId = '%')
				AND (smSvcEquipment.SiteId = '" + @SiteID + "' OR smSvcEquipment.SiteId = '%')
				AND smSvcEquipment.CpnyID = '" + @CnpyId + "' 
				AND " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSvcEq_CustID_SiteID_w_PV] TO [MSDSL]
    AS [dbo];

