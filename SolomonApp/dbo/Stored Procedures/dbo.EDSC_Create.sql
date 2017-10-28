 CREATE Procedure EDSC_Create @CpnyId varchar(10), @Shipperid varchar(15) As
Declare @AutoGenContainer smallint
Declare @CustId varchar(15), @OrdNbr varchar(15), @SiteId varchar(10)
Declare @TrackLevel smallint,@TrackDetail smallint
Declare @SingleContainer smallint
Declare @ChangeMade smallint
Declare @SendViaEdi smallint
Declare @ContainerIDs smallint
Declare @Active smallint
Select @AutoGenContainer = AutoContainer, @Active = Active from ANSetup
If IsNull(@AutoGenContainer,9) = 9 Or @Active <> 1
Begin
 Select @ChangeMade = 0
 Goto ExitProg
End Else
 If @AutoGenContainer = 0
 Begin
  Select @ChangeMade = 0
  Goto ExitProg
 End
Select @CustId = CustId, @OrdNbr = OrdNbr, @SiteId = SiteId from SOShipHeader where CpnyId = @CpnyId and Shipperid = @ShipperId
If IsNull(@CustId,'~') = '~'
Begin
 Select @ChangeMade = 0
 Goto ExitProg
End
-- check to make sure that the site allows for the pregeneration of containers.
Select @ContainerIDs = ContainerIDs From EDSite Where SiteId = @SiteId
Set @ContainerIDs = IsNull(@ContainerIDs,0) -- convert nulls to zero
If @ContainerIDs <> 1
Begin
 Set @ChangeMade = 0
 Goto ExitProg
End
Select @TrackLevel =  Case  When ContTrackLevel = 'TCO'then 1
    When ContTrackLevel = 'TCD'then 2
    Else 0
   End
 From CustomerEDI where Custid = @CustId
If IsNull(@TrackLevel, 9) = 9
Begin
 Select @ChangeMade = 0
 Goto ExitProg
End
If @TrackLevel = 0
Begin
 Select @ChangeMade = 0
 Goto ExitProg
End
Select @TrackDetail =  Case  When @TrackLevel = 1 then 0
    When @TrackLevel = 2 then 1
    Else 0
   End
Select @SingleContainer = SingleContainer from EDSOHeader where CpnyId = @CpnyId and OrdNbr = @OrdNbr
If IsNull(@SingleContainer,9) = 9
Begin
 Select @SingleContainer = 0
end
If @SingleContainer = 0
Begin
 Exec EDSC_GenerateContainerMulti @CpnyId, @ShipperId,@TrackDetail, @ChangeMade Output
End Else
Begin
 Exec EDSC_GenerateContainerSingle @CpnyId, @ShipperId,@TrackDetail
 Select @ChangeMade = 0
End
ExitProg:   --Pass back flag that inform calling program of changes
Select @ChangeMade


