CREATE FUNCTION [dbo].[GetSubAcct] 
     (@SolomonContactID as varchar(6), @BarnNbr as varchar(6))  
RETURNS varchar(8) 
AS
	BEGIN 
	DECLARE @cReturn varchar(8),
		@System int,
		@FacilityType int,
		@Ownership int

	--Set @System=(Select ProductionSystem from CentralData.dbo.Site s join CentralData.dbo.Contact c
	--		on s.ContactID =c.ContactID where c.SolomonContactID=@SolomonContactID)
	Set @System=0
	Set @FacilityType=(Select FacilityTypeID from cftBarn b join cftContact c
			on b.ContactID=c.ContactID where c.ContactID=@SolomonContactID and b.BarnNbr=@BarnNbr)
	Set @Ownership=(Select OwnershipLevelID from cftSite s join cftContact c
			on s.ContactID =c.ContactID where c.ContactID=@SolomonContactID)
	set @cReturn=Case @System when 1 then (Select MultDivision from cftPGSetup)
				     when 0 then (Select CommDivision from cftPGSetup)
			END
			+
			Case @FacilityType when 2 then (Select NurseryDept from cftPGSetup)
					     when 5 then (Select WeanFinishDept from cftPGSetup)
				  	     when 6 then (Select FinishDept from cftPGSetup)
			END
			+
			Case @Ownership when 2 then (Select ContractLocation from cftPGSetup)
					  else (Select SiteID from cftSite s join cftContact c
			on s.ContactID =c.ContactID where c.ContactID=@SolomonContactID)
			END
	--set @cReturn= @FacilityType 	

	RETURN @cReturn
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSubAcct] TO [MSDSL]
    AS [dbo];

