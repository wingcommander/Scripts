MERGE INTO dbo.STS_BrokerServerTimeZoneSettings AS Target
USING 
(	
	SELECT bs.ID, bs.Name, 1 AS IsUseAdminSettings, bz.Offset*60 AS Offset, bz.DST, ISNULL(tz.ID, 41) AS TZ --41 is CET 
	FROM BSTZ$ AS bz
	INNER JOIN dbo.STS_Brokers AS b
		ON bz.[Broker] = b.Name
	INNER JOIN dbo.STS_BrokerServers AS bs
		ON bs.BrokerID = b.ID
	LEFT JOIN dbo.STS_TimeZones AS tz
		ON bz.TZ = tz.LongDescription
) AS Source (ID, Name, IsUseAdminSettings, Offset, DST, TZ)
	ON Target.BrokerServerID = Source.ID
WHEN MATCHED AND 
(
	Target.IsUseAdminSettings != Source.IsUseAdminSettings OR
	Target.AdminMtOffset != Source.Offset OR
	Target.AdminServerTimeZoneID != Source.TZ OR
	Target.AdminIsMtDstEnabled != Source.DST				
) THEN
	UPDATE SET 
		Target.IsUseAdminSettings = Source.IsUseAdminSettings,
		Target.AdminMtOffset = Source.Offset,
		Target.AdminServerTimeZoneID = Source.TZ,
		Target.AdminIsMtDstEnabled = Source.DST
WHEN NOT MATCHED BY TARGET THEN
	INSERT (BrokerServerID, DefaultAbsoluteMtOffset, IsUseAdminSettings, AdminMtOffset, AdminIsMtDstEnabled, AdminServerTimeZoneID) 
	VALUES (ID, Offset, IsUseAdminSettings, Offset, DST, TZ);

