 create procedure PJCOMDET_SPK3 @project varchar (16), @subcontract varchar (16), @sub_line_item varchar (4) as
select * from PJCOMDET
where project = @project
and cd_id04 = @subcontract
and sub_line_item = @sub_line_item

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMDET_SPK3] TO [MSDSL]
    AS [dbo];

