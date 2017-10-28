CREATE Procedure [dbo].[pjinvhdr_spk8] @parm1 varchar (16), @parm2 varchar (15), @parm3 varchar (10), @parm4 varchar(10)  as
select * from pjinvhdr where
pjinvhdr.project_billwith = @parm1 AND
pjinvhdr.customer = @parm2 AND
pjInvhdr.draft_num = @parm3 AND
pjinvhdr.cpnyID = @parm4
AND PJINVHDR.ShipperID = ''


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk8] TO [MSDSL]
    AS [dbo];

