public virtual with sharing class RecordTypesService
{
	private static Map<sObjectType, Schema.DescribeSObjectResult> describesBySObjectType = new Map<sObjectType, Schema.DescribeSObjectResult>();
	private static Map<sObjectType, RecordTypeInfoWrapper> cachedRecordTypes = new Map<sObjectType, RecordTypeInfoWrapper>();

	public static Id getRecordTypeId(SObjectType sObjectType, String value)
	{
		return getRecordTypeId(sObjectType, value, true);
	}

	public static Id getRecordTypeIdFromName(SObjectType sObjectType, String value)
	{
		return getRecordTypeId(sObjectType, value, false);
	}

	public static Id getRecordTypeId(SObjectType sObjectType, String value, Boolean useDeveloperName)
	{
		if (!cachedRecordTypes.containsKey(SObjectType))
		{
			fetchAllRecordTypeIdsForSObject(sObjectType);
		}

		RecordTypeInfoWrapper infoWrapper = cachedRecordTypes.get(SObjectType);

		Map<String, RecordTypeInfo> recordTypeInfo = useDeveloperName ? infoWrapper.infoByDevName : infoWrapper.infoByName;

		Id result = recordTypeInfo.get(value)?.getRecordTypeId();
		if (result == null)
		{
			throw new RecordTypeServiceException(
					String.format('Unknown record type {0} for SObject {1}',
							new List<String>
							{
									value,
									sObjectType.getDescribe().getName()
							}
					)
			);
		}
		return result;
	}

	private static void fetchAllRecordTypeIdsForSObject(sObjectType sObjectType)
	{
		if (!describesBySObjectType.containsKey(sObjectType))
		{
			describesBySObjectType.put(sObjectType, sObjectType.getDescribe());
		}

		cachedRecordTypes.put(SObjectType, new RecordTypeInfoWrapper(describesBySObjectType.get(sObjectType)));
	}
	
	private class RecordTypeInfoWrapper
	{
		public Map<String, RecordTypeInfo> infoByDevName = new Map<String, RecordTypeInfo>();
		public Map<String, RecordTypeInfo> infoByName = new Map<String, RecordTypeInfo>();

		private RecordTypeInfoWrapper(Schema.DescribeSObjectResult sObjectDescribe)
		{
			this.infoByDevName = sObjectDescribe.getRecordTypeInfosByDeveloperName();
			populateInfoByName();
		}

		private void populateInfoByName()
		{
			for (String devName : this.infoByDevName.keySet())
			{
				RecordTypeInfo info = this.infoByDevName.get(devName);
				String name = info.getName();
				if (!this.infoByName.containsKey(name))
				{
					this.infoByName.put(name, info);
				}
			}
		}
	}

	public class RecordTypeServiceException extends Exception {}
}