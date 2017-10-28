CREATE PROCEDURE WS_PJUTLROL_INSERT
     @adjustments float, @cost float, @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @data1 char(16), @data2 float,
     @data3 float, @data4 float, @data5 float, @employee char(10), @fiscalno char(6), @lupd_datetime smalldatetime, @lupd_prog char(8),
     @lupd_user char(10), @rate float, @revenue float, @units float, @user1 char(30), @user2 char(30), @user3 float,
     @user4 float, @utilization_type char(4)
 AS
     BEGIN
      INSERT INTO [PJUTLROL]
       ([adjustments], [cost], [crtd_datetime], [crtd_prog], [crtd_user], [data1], [data2],
        [data3], [data4], [data5], [employee], [fiscalno], [lupd_datetime], [lupd_prog],
        [lupd_user], [rate], [revenue], [units], [user1], [user2], [user3],
        [user4], [utilization_type])
      VALUES
       (@adjustments, @cost, @crtd_datetime, @crtd_prog, @crtd_user, @data1, @data2,
        @data3, @data4, @data5, @employee, @fiscalno, @lupd_datetime, @lupd_prog,
        @lupd_user, @rate, @revenue, @units, @user1, @user2, @user3,
        @user4, @utilization_type);
     END

