-- Add dummy data to ClassAttendance table
INSERT INTO ClassAttendance (AttendanceDate)
VALUES
    ('2024-02-28'), -- Class held on February 28, 2024
    ('2024-03-06'), -- Class held on March 6, 2024
    ('2024-03-13'); -- Class held on March 13, 2024

-- Set the ID of the class session you're adding attendance for
DECLARE @AttendanceId INT;

-- Insert dummy data to StudentAttendance table for each class session
-- Iterate over each class session
DECLARE @ClassAttendanceCursor CURSOR;
SET @ClassAttendanceCursor = CURSOR FOR
    SELECT Id FROM ClassAttendance;

OPEN @ClassAttendanceCursor;
FETCH NEXT FROM @ClassAttendanceCursor INTO @AttendanceId;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Loop through student IDs and insert attendance records for each class session
    DECLARE @StudentId INT = 1; -- Start with the first student ID
    WHILE @StudentId <= 198
    BEGIN
        -- Generate a random attendance status between 1 and 4
        DECLARE @AttendanceStatus INT;
        SET @AttendanceStatus = ROUND(RAND() * 3 + 1, 0);

        -- Insert attendance record for each student
        INSERT INTO StudentAttendance (AttendanceId, StudentId, AttendanceStatus)
        VALUES (@AttendanceId, @StudentId, @AttendanceStatus);

        SET @StudentId = @StudentId + 1; -- Increment student ID for the next iteration
    END;

    FETCH NEXT FROM @ClassAttendanceCursor INTO @AttendanceId;
END;

CLOSE @ClassAttendanceCursor;
DEALLOCATE @ClassAttendanceCursor;


