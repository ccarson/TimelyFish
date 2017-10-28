
create view BPv_APHistCpny as

SELECT DISTINCT CpnyID, VendId
  FROM APHist
