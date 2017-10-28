 CREATE PROCEDURE DMG_SOType_Insert_All

	@OMPlus		varchar(1),
	@CpnyID		varchar(10),
	@ASM		varchar(1)
as

	-- clear the sotype table
	delete
	from SOType
	where CpnyID = @CpnyID

	-- clear the sostep table
	delete
	from SOStep
	where CpnyID = @CpnyID

	-- Add the order types that are in common with OM Standard and OM Plus

	-- BL
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'BL',				365,				'',				'',
		@CpnyID,			'Blanket Order',		'',				'',
		'',				0,				'',				'',
		'',				'',				'',				'',
		'',				'0000001',			'',				'',
		'',				0,				'B',				'',
		0,				0,				0,				'',
		'',				'',				'C',				'',
		'',				'BL',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_BL @CpnyID

	-- CM
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'CM',				365,				'',				'',
		@CpnyID,			'Credit Memo',			'',				'',
		'',				0,				'',				'',
		'',				'CM',				'',				'',
		'000001',			'00001',			'00001',			'',
		'',				0,				'CMO',				'',
		0,				0,				0,				'',
		'CMS',				'',				'C',				'',
		'',				'CM',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_CM @CpnyID

	-- DM
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'DM',				365,				'',				'',
		@CpnyID,			'Debit Memo',			'',				'',
		'',				0,				'',				'',
		'',				'DM',				'',				'',
		'000001',			'00001',			'00001',			'',
		'',				0,				'DMO',				'',
		0,				0,				0,				'',
		'DMS',				'',				'C',				'',
		'',				'DM',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_DM @CpnyID

	-- INVC
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'INVC',				365,				'',				'',
		@CpnyID,			'Invoice',			'',				'',
		'',				1,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'INVC',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_INVC @CpnyID

	-- MO
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'MO',				365,				'',				'',
		@CpnyID,			'Manual Order',			'',				'',
		'',				1,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'MO',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_MO @CpnyID

	-- OU
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'SO',				365,				'',				'',
		@CpnyID,			'Order to Purchase',		'',				'',
		'',				0,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'OU',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_OU @CpnyID

	-- Q
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'Q',				365,				'',				'',
		@CpnyID,			'Quote',			'',				'',
		'',				0,				'',				'',
		'',				'',				'',				'',
		'',				'0000001',			'',				'&MI',
		'',				0,				'Q',				'',
		0,				0,				0,				'',
		'',				'',				'C',				'',
		'',				'Q',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_Q @CpnyID

	-- SO
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'SO',				365,				'',				'',
		@CpnyID,			'Sales Order',			'',				'',
		'',				0,				'',				'',
		'',				'I',				'',				'',
		'0000001',			'0000001',			'0000001',			'',
		'',				0,				'O',				'',
		0,				0,				0,				'',
		'S',				'',				'C',				'',
		'',				'SO',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_SO @CpnyID

	-- Add the order types that are only for OM Plus
	if @OMPlus = '1'
	begin

	-- ALL
	exec DMG_SOType_Insert
		0,				'',				'',				0,
		'SO',				365,				'',				'',
		@CpnyID,			'Template w/all possible steps','',				'',
		'',				0,				'',				'',
		'',				'I',				'',				'',
		'0000001',			'0000001',			'0000001',			'',
		'',				0,				'O',				'',
		1,				1,				1,				'',
		'S',				'',				'C',				'',
		'',				'ALL',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_All @CpnyID

	-- AO
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'SO',				365,				'',				'',
		@CpnyID,			'Advanced Sales Order',		'',				'',
		'',				0,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'AO',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_AO @CpnyID

	-- CS
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'CS',				365,				'',				'',
		@CpnyID,			'Counter Sale',			'',				'',
		'',				1,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'CS',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_CS @CpnyID

	-- KA
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'WO',				365,				'',				'',
		@CpnyID,			'Kit Assembly',			'',				'',
		'',				0,				'',				'',
		'',				'',				'',				'',
		'',				'000001',			'00001',			'',
		'',				0,				'KA',				'',
		0,				0,				0,				'',
		'KAS',				'',				'C',				'',
		'',				'KA',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_KA @CpnyID

	-- REP
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'RMA',				365,				'',				'',
		@CpnyID,			'Return for Repair',		'',				'',
		'REP',				0,				'',				'',
		'',				'IR',				'RFC',				'',
		'',				'',				'',				'',
		'',				0,				'RM',				'RFC',
		0,				0,				0,				'RMSH',
		'SR',				'RFC',				'C',				'',
		'',				'REP',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_REP @CpnyID

	-- RFC
	exec DMG_SOType_Insert
		1,				'',				'',				1,
		'RMA',				365,				'',				'',
		@CpnyID,			'Return for Credit',		'',				'',
		'X',				0,				'',				'',
		'',				'IR',				'',				'',
		'000001',			'000001',			'000001',			'',
		'',				0,				'RM',				'',
		0,				0,				0,				'RMSH',
		'SR',				'',				'C',				'',
		'',				'RFC',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_RFC @CpnyID

	-- RMSH
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'RMSH',				365,				'',				'',
		@CpnyID,			'RMA Return Shipment',		'',				'',
		'',				0,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'',				'',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'RMSH',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_RMSH @CpnyID

	-- RPL
	exec DMG_SOType_Insert
		1,				'',				'',				1,
		'RMA',				365,				'',				'',
		@CpnyID,			'Return for Replacement',	'',				'',
		'X',				0,				'',				'',
		'',				'IR',				'RFC',				'',
		'',				'',				'',				'',
		'',				0,				'RM',				'RFC',
		0,				0,				0,				'RMSH',
		'SR',				'RFC',				'C',				'',
		'',				'RPL',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_RPL @CpnyID

	-- SHIP
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'SHIP',				365,				'',				'',
		@CpnyID,			'Non-Order Shipment',		'',				'',
		'',				1,				'',				'',
		'',				'',				'',				'',
		'001',				'000001',			'000001',			'',
		'',				0,				'SH',				'',
		0,				0,				0,				'',
		'SH',				'',				'C',				'',
		'',				'SHIP',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_SHIP @CpnyID

	-- TR
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'TR',				365,				'',				'',
		@CpnyID,			'Warehouse Transfer',		'',				'',
		'',				0,				'',				'',
		'',				'',				'',				'',
		'',				'000001',			'00001',			'',
		'',				0,				'TR',				'',
		0,				0,				0,				'',
		'TRS',				'',				'S',				'',
		'',				'TR',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_TR @CpnyID

	-- WC
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'WC',				365,				'',				'',
		@CpnyID,			'Will-Call Order',		'',				'',
		'',				0,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'WC',				1,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_WC @CpnyID

	end
-- Insert the order type for advanced Shipment Management (de 230737)
if @ASM = '1'
begin
	exec DMG_SOType_Insert
		1,				'',				'',				0,
		'SO',				365,				'',				'',
		@CpnyID,			'Advanced Shipment Management',	'',				'',
		'',				0,				'',				'',
		'',				'I',				'SO',				'',
		'',				'',				'',				'',
		'',				0,				'O',				'SO',
		0,				0,				0,				'',
		'S',				'SO',				'C',				'',
		'',				'ASM',				0,				'',
		'', 0                           ,0                              ,0

	exec DMG_SOStep_Create_ASM @CpnyID
end

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Insert_All] TO [MSDSL]
    AS [dbo];

