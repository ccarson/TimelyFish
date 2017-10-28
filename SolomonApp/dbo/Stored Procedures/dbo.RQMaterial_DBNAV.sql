 /****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 9/4/2003 6:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 1/23/01 2:47:54 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 10/2/00 4:58:14 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 9/13/00 8:46:36 AM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQMaterial_DBNAV    Script Date: 2/2/00 12:18:19 PM ******/

/****** Object : Stored Procedure dbo.RQMaterial_DBNAV  Script Date: 02/18/98 06:28:00 PM ******/
CREATE Procedure RQMaterial_DBNAV @Parm1 Varchar(10),  @Parm2 Varchar(10), @parm3 Varchar(16), @parm4 varchar(10)  AS
Select RQItemReqDet.*, RQItemReqHdr.*, Vendor.Name from
RQItemReqHdr, RQItemReqDet
left outer join Vendor on
Vendor.VendID = RQItemReqDet.prefvendor
  where
RQItemReqDet.Status = 'AP' And
RQItemReqDet.Reqnbr = '' and
RQItemReqDet.materialtype like @parm1 and
RQItemReqDet.Dept like @parm2 and
RQItemReqDet.Project like @parm3 and
RQItemReqDet.ItemReqNbr = RQItemReqHdr.ItemReqNbr and
RQItemReqDet.PurchaseFor <> 'DL' and
RQItemReqHdr.CpnyID = @parm4 and
(RQItemReqHdr.Status = 'RQ'  OR RQItemReqHdr.Status = 'AP')
ORDER BY RQItemReqDet.ItemReqNbr, RQItemReqDet.LineNbr


