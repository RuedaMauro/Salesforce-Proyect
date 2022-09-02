public with sharing class CRM_CaseHierarchyController {

    public class HierachyResponse {
        @AuraEnabled public CaseMapper parentRecord {get;set;}
        @AuraEnabled public List<CaseMapper> childRecords {get;set;}
    }

    public class CaseMapper {
        @AuraEnabled public List<FullField> fields {get;set;}
    }

    public class FullField {
        @AuraEnabled public String developername {get;set;}
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }

    @AuraEnabled
    public static HierachyResponse getCaseWithChilds(Id recordId){
        List<Case> childs = new List<Case>();
        Case parent = new Case();
        CRM_CaseSelector selector = new CRM_CaseSelector();
        HierachyResponse response = new HierachyResponse();

        try {
            childs = selector.selectChildsByParentId(new List<Id>{recordId});
            parent = selector.selectById(new List<Id>{recordId}).get(0);
            System.debug('Parent :: ' + parent);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());//NOSONAR
        } finally {
            response.parentRecord = generateParentResponse(parent);
            response.childRecords = generateChildResponse(childs);
        }

        System.debug('Response: ' + response);

        return response;
    }

    @AuraEnabled
    public static String getParentIdIfExists(String childId){
        String parentId = '';
        try {
            parentId = new CRM_CaseSelector().getParentId(childId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());//NOSONAR
        }

        return parentId;
    }

    private static CaseMapper generateParentResponse(Case parent){
        CaseMapper parentMapper = new CaseMapper();
        parentMapper.fields = new List<FullField>();
        Map<String, Schema.SObjectField> mappedFields = getMappedField('Case');

        Map<String,Object> parentFields = parent.getPopulatedFieldsAsMap();
        System.debug('Fields :: ' + parentFields);

        for(String fieldName: parentFields.keySet()) {
            FullField newField = new FullField();
            newField.developername = fieldName;
            newField.label = mappedFields.get(fieldName).getDescribe().getLabel();
            newField.value = String.valueOf(parent.get(fieldName));

            parentMapper.fields.add(newField);
        }

        return parentMapper;
    }

    private static List<CaseMapper> generateChildResponse(List<Case> childs){
        List<CaseMapper> childMappers = new List<CaseMapper>();
        Map<String, Schema.SObjectField> mappedFields = getMappedField('Case');

        for(Case child : childs){
            CaseMapper childMapper = new CaseMapper();
            childMapper.fields = new List<FullField>();

            Map<String,Object> childFields = child.getPopulatedFieldsAsMap();
            System.debug('Fields :: ' + childFields);

            for(String fieldName: childFields.keySet()) {
                FullField newField = new FullField();
                newField.developername = fieldName;
                newField.label = mappedFields.get(fieldName).getDescribe().getLabel();
                newField.value = String.valueOf(child.get(fieldName));

                childMapper.fields.add(newField);
            }

            childMappers.add(childMapper);
        }


        return childMappers;
    }

    private static Map<String, Schema.SObjectField> getMappedField(String objectType){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objectSchema = schemaMap.get(objectType);
        Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();

        return fieldMap;
    }
}