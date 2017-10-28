 create procedure PJCOMDET_spta @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)   as
select  PJCOMDET.*,  VENDOR.*,  INVENTORY.descr
	from PJCOMDET
		left outer join VENDOR
			on PJCOMDET.vendor_num = VENDOR.vendid
		left outer join INVENTORY
			on PJCOMDET.part_number = INVENTORY.invtid
	where PJCOMDET.project =  @parm1 and
		PJCOMDET.pjt_entity  like  @parm2 and
		PJCOMDET.acct like @parm3
	order by po_date, purchase_order_num, cd_id04, part_number



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMDET_spta] TO [MSDSL]
    AS [dbo];

