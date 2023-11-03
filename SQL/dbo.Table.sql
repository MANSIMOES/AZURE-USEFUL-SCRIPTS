CREATE TABLE [dbo].[Table]
(
	[IdTrackerItem] INT NOT NULL PRIMARY KEY, 
    [TrackerSummary] TEXT NULL, 
    [TrackerReminderPolicy] TEXT NULL, 
    [TrackerEndDate] TIMESTAMP NULL, 
    [TrackerFirstRegistered] TIMESTAMP NULL, 
    [TrackerStatus] TEXT NULL
)
