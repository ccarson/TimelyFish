 CREATE Proc ReQueue_SO_SOSh_ProjectID @CpnyId varchar(10), @ProjectId varchar(15), @ComputerName varchar(21) As
Declare @CPSOnOff int
Declare @Crtd_Prog as varchar(8)
Declare @Crtd_User as varchar(10)
Declare @OrderNbr as varchar(10)
Declare @ShipperNbr as varchar(10)
Declare @OrderLineRef as varchar(5)
Declare @ShipperLineRef as varchar(5)

-- initialize
Set @CPSOnOff = (select CPSOnOff from Insetup)

--sales orders
Declare csr_SO Cursor For Select OrdNbr, Crtd_Prog, Crtd_User
        From SOHeader
        Where SOHeader.CpnyId = @CpnyId And SOHeader.ProjectId = @ProjectId And SOHeader.Status = 'O'

Open csr_SO
Fetch Next From csr_SO Into @OrderNbr, @Crtd_Prog, @Crtd_User
While @@Fetch_Status <> -1
Begin
	--requeue 'PLNSO' records for header
	exec ADG_ProcessMgr_QueueSOPlan2 @CpnyId, @OrderNbr, '', '', @CPSOnOff, @ComputerName, @Crtd_Prog, @Crtd_User

	Declare csr_SODetail Cursor For Select LineRef
        From SOLine
        Where SOLine.CpnyId = @CpnyId And SOLine.OrdNbr = @OrderNbr Order by LineRef
		Open csr_SODetail

		Fetch Next From csr_SODetail Into @OrderLineRef
		While @@Fetch_Status <> -1
		Begin

			--requeue 'PLNSO' records for detail lines
			exec ADG_ProcessMgr_QueueSOPlan2 @CpnyId, @OrderNbr, @OrderLineRef, '', @CPSOnOff, @ComputerName, @Crtd_Prog, @Crtd_User

		Fetch Next From csr_SODetail Into  @OrderLineRef
		End
		
		Close csr_SODetail

		Deallocate csr_SODetail
		
		--requeue 'CRTSH' records
		exec ADG_ProcessMgr_QueueSOSh @CpnyId, @OrderNbr
		--requeue 'PRCSO' records
		exec ADG_ProcessMgr_QueueSOProcess2 @CpnyId, @OrderNbr, '', '', @ComputerName, @Crtd_Prog, @Crtd_User

  Fetch Next From csr_SO Into  @OrderNbr, @Crtd_Prog, @Crtd_User
End
Close csr_SO
Deallocate csr_SO

--shippers
Declare csr_SOSh Cursor For Select ShipperID, Crtd_Prog, Crtd_User
        From SOShipHeader
        Where SOShipHeader.CpnyId = @CpnyId And SOShipHeader.ProjectId = @ProjectId And SOShipHeader.Status = 'O'

Open csr_SOSh
Fetch Next From csr_SOSh Into @ShipperNbr, @Crtd_Prog, @Crtd_User
While @@Fetch_Status <> -1
Begin
		--requeue 'PLNSH' records
	exec ADG_ProcessMgr_QueueSHPlan2 @CpnyId, @ShipperNbr, '', @CPSOnOff, @ComputerName, @Crtd_Prog, @Crtd_User
		--requeue 'PRCSH' records
	exec ADG_ProcessMgr_QueueSHProcess2 @CpnyId, @ShipperNbr, '', @ComputerName, @Crtd_Prog, @Crtd_User

  Fetch Next From csr_SOSh Into  @ShipperNbr, @Crtd_Prog, @Crtd_User
End
Close csr_SOSh
Deallocate csr_SOSh


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ReQueue_SO_SOSh_ProjectID] TO [MSDSL]
    AS [dbo];

