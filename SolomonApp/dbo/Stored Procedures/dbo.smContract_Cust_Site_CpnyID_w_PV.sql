
CREATE PROCEDURE dbo.smContract_Cust_Site_CpnyID_w_PV
        @CustID varchar(15),        
	@SiteID varchar(10),              
	@CnpyId varchar(10),	
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(smContract.ContractID ) FROM smContract, SoAddress  
                                WHERE smContract.CustId = @CustID 
				AND smContract.SiteId = @SiteID 
				AND smContract.CpnyID = @CnpyId 
				AND smContract.Status = 'A' 
				AND SoAddress.ShipToId =* smContract.SiteId 
				AND soAddress.Custid =* smContract.CustId 

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(smContract.ContractID ) FROM smContract, SoAddress  
                                WHERE smContract.CustId = '" + @CustID + "' 
				AND smContract.SiteId = '" +@SiteID + "' 
				AND smContract.CpnyID = '" +@CnpyId + "' 
				AND smContract.Status = 'A' 
				AND SoAddress.ShipToId =* smContract.SiteId 
				AND soAddress.Custid =* smContract.CustId AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC ("SELECT TOP " + @Max + " smContract.ContractId, smContract.CpnyID, smContract.Custid, smContract.SiteId, SoAddress.Addr1, smContract.ContractType, smContract.StartDate, smContract.ExpireDate  FROM smContract, SoAddress  
                                WHERE smContract.CustId = '" + @CustID + "' 
				AND smContract.SiteId = '" +@SiteID + "' 
				AND smContract.CpnyID = '" +@CnpyId + "' 
				AND smContract.Status = 'A' 
				AND SoAddress.ShipToId =* smContract.SiteId 
				AND soAddress.Custid =* smContract.CustId  
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + "  smContract.ContractId, smContract.CpnyID, smContract.Custid, smContract.SiteId, SoAddress.Addr1, smContract.ContractType, smContract.StartDate, smContract.ExpireDate  FROM smContract, SoAddress    
                                WHERE smContract.CustId = '" + @CustID + "' 
				AND smContract.SiteId = '" +@SiteID + "' 
				AND smContract.CpnyID = '" +@CnpyId + "' 
				AND smContract.Status = 'A' 
				AND SoAddress.ShipToId =* smContract.SiteId 
				AND soAddress.Custid =* smContract.CustId AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Cust_Site_CpnyID_w_PV] TO [MSDSL]
    AS [dbo];

