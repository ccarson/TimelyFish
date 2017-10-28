 
CREATE VIEW vp_1099Info_Prep
AS
  SELECT vc.RI_ID,
         vc.Master_Fed_ID      cMasterFedID,
         v.VendID              VendId,
         Max(vc.CpnyId)        CpnyId,
         Max(v.Name)           VendorName,
         Max(v.Addr1)          Addr1,
         Max(v.Addr2)          Addr2,
         Max(v.City)           City,
         Max(v.State)          State,
         Max(v.Zip)            Zip,
         Max(v.Vend1099)       Vend1099,
         Max(v.ContTwc1099)    ConTwc1099,
         Max(v.TIN)            TIN,
         Max(v.TINName)        TINName,
         Max(v.RecipientName2) RecipientName2,
         ---the following are off by one from the actual printed form box number
         ---i.e. Box 1 on the form = CYBox00, etc.
         Sum(CYBox00)          CYBox00,
         Sum(CYBox01)          CYBox01,
         Sum(CYBox02)          CYBox02,
         Sum(CYBox03)          CYBox03,
         Sum(CYBox04)          CYBox04,
         Sum(CYBox05)          CYBox05,
         Sum(CYBox06)          CYBox06,
         Sum(CYBox07)          CYBox07,
         Sum(CYBox08)          CYBox08,
         Sum(CYBox09)          CYBox09,
         Sum(CYBox10)          CYBox10,
         Sum(CYBox11)          CYBox15a,
         Sum(CYBox12)          CYBox15b,
         ---the following boxes match those on the form
         Sum(CYBox13)          CYBox13,
         Sum(CYBox14)          CYBox14,
         Sum(CYBox15)          CYBox15,
         Max(CYFor01)          CYFor01,
         ---the following are off by one from the actual printed form box number
         ---i.e. Box 1 on the form = NYBox00, etc.
         Sum(NYBox00)          NYBox00,
         Sum(NYBox01)          NYBox01,
         Sum(NYBox02)          NYBox02,
         Sum(NYBox03)          NYBox03,
         Sum(NYBox04)          NYBox04,
         Sum(NYBox05)          NYBox05,
         Sum(NYBox06)          NYBox06,
         Sum(NYBox07)          NYBox07,
         Sum(NYBox08)          NYBox08,
         Sum(NYBox09)          NYBox09,
         Sum(NYBox10)          NYBox10,
         Sum(NYBox11)          NYBox15a,
         Sum(NYBox12)          NYBox15b,
         ---the following boxes match those on the form
         Sum(NYBox13)          NYBox13,
         Sum(NYBox14)          NYBox14,
         Sum(NYBox15)          NYBox15,
         Max(NYFor01)          NYFor01,
         Max(v.User1)          AS VendorUser1,
         Max(v.User2)          AS VendorUser2,
         Max(v.User3)          AS VendorUser3,
         Max(v.User4)          AS VendorUser4,
         Max(v.User5)          AS VendorUser5,
         Max(v.User6)          AS VendorUser6,
         Max(v.User7)          AS VendorUser7,
         Max(v.User8)          AS VendorUser8
  FROM   vp_1099CpnyInfo vc
         INNER JOIN AP_Balances a
           ON vc.CpnyID = a.CpnyID
         INNER JOIN Vendor v
           ON a.VendID = v.VendID
  WHERE  ( v.Vend1099 = 1 )
  GROUP  BY vc.RI_ID,
            vc.Master_Fed_ID,
            v.VendId

