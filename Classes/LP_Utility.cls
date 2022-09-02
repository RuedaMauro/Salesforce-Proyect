/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 23/04/2021
Description  : Utility class for generic utility methods
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos                 ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO		    23/04/2021		Created the class
********************************************************************************/
public with sharing class LP_Utility {

    /**
    *  @Description: Declaration of static variables
    *  @Author:      ATO
    *  @Date:        26/04/2021
    */
    private static final String PRV_STR_STSINCMP;
    private static final String PRV_STR_STSCRT;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        PRV_STR_STSINCMP = 'incomplete';
        PRV_STR_STSCRT = 'current';
    }

    public LP_Utility() {

    }

    /**
    *  @Description: Wrapper used to set a Path
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/04/2021
    */
    public class PathWrapper implements Comparable{
        public PathWrapper path;
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String value {get; set;}
        @AuraEnabled
        public String status {get;set;}
        @AuraEnabled
        public String classList {get;set;}
        @AuraEnabled
        public Boolean selected {get;set;}
        @AuraEnabled
        public Integer tabIndex {get;set;}
        @AuraEnabled
        public Integer order {get;set;}
        // Constructor used to set the default value of status path
        public pathWrapper() {
            this.status = PRV_STR_STSINCMP;
            this.classList = '';
            this.selected = false;
            this.tabIndex = -1;
        }
        // Constructor        
        public pathWrapper(PathWrapper pth) {
            this.path = pth;
        }
        
        // Compare PathWrapper based on the PathWrapper order.
        public Integer compareTo(Object compareTo) {
            // Cast argument to PathWrapper
            PathWrapper compareToPath = (PathWrapper)compareTo;
            
            // The return value of 0 indicates that both elements are equal.
            Integer returnValue = 0;
            if (order > compareToPath.order) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (order < compareToPath.order) {
                // Set return value to a negative value.
                returnValue = -1;
            }
            
            return returnValue;       
        }
    }

    /**
    *  @Description: Gets the values ​​of a picklist depending on the object and the field
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/04/2021
    */
    private static List<Schema.PicklistEntry> getPickListEntry(String sObjectType, String fieldApiName) {
        // Globally desribe all the objects 
        Map<String, SObjectType> globalDescribe = Schema.getGlobalDescribe();
        DescribeSObjectResult describeResult = globalDescribe.get(sObjectType).getDescribe();
        Map<String, Schema.SObjectField> describedFields = describeResult.fields.getMap();
        Schema.SObjectField field = describedFields.get(fieldApiName);
        Schema.DescribeFieldResult fieldResult = field.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        return ple;
    }

    /**
    *  @Description: Get picklist values into path
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/04/2021
    */
    public static List<PathWrapper> getPickListValuesIntoPath(String sObjectType, String fieldApiName) {
        List<PathWrapper> path = new List<PathWrapper>();
        Integer order = 0;
        for (Schema.PicklistEntry pickListVal : getPickListEntry(sObjectType, fieldApiName)) {
            if (pickListVal.isActive()) {
                PathWrapper pth = new PathWrapper();
                pth.label = pickListVal.getLabel();
                pth.value = pickListVal.getValue();
                pth.order = order;
                pth.status =  pth.order == 0 ? PRV_STR_STSCRT : pth.status;
                pth.selected =  pth.order == 0 ? true : pth.selected;
                pth.tabIndex =  pth.order == 0 ? 0 : pth.tabIndex;
                path.add(pth);
                order++;
            }
        }
        return path;
    }

    /**
    *  @Description: Get label parameterization for lightning components
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/04/2021
    */
    public static String getDescribedObjects( List<String> lstSObjectType ) {
    	if(lstSObjectType.size() > 0)
        {
            try{
                // Globally desribe all the objects 
                Map<String, SObjectType> globalDescribe = Schema.getGlobalDescribe(); 
                // Create a JSON string with object field labels and picklist values
                String allObjJSON = '{';
                
                // Iterate over the list of objects and describe each object  
                for( String sObjectType : lstSObjectType ) {
                    
                    if( allObjJSON != '{' ) 
                        allObjJSON += ', ';
                    allObjJSON += '"' + sObjectType + '": ';
                    DescribeSObjectResult describeResult = globalDescribe.get(sObjectType).getDescribe();
                    Map<String, Schema.SObjectField> desribedFields = describeResult.fields.getMap();
                    String objJSON = '{';
                    
                    for( String fieldName :  desribedFields.keySet() ) {
                        
                        // Describe the field 
                        Schema.SObjectField field = desribedFields.get( fieldName );
                        Schema.DescribeFieldResult f = field.getDescribe();	   
                        if( objJSON != '{' )
                            objJSON += ', ';    
                        // Get the field label and append in the JSON string
                        objJSON += '"' + f.getName() + '": ' + '{ "label" : "' + f.getLabel().toUppercase() + '"';
                        
                        // if it's a picklist field then also add the picklist options
                        if( field.getDescribe().getType() == Schema.DisplayType.PICKLIST ){
                            
                            List <Schema.PicklistEntry> picklistValues = field.getDescribe().getPickListValues();
                            List<String> pickListOptions = new List<String>();
                            pickListOptions.add('{ "label": "--None--", "value": null }');
                            
                            for (Schema.PicklistEntry pe : picklistValues) { 
                                
                                pickListOptions.add('{ "label": "' + pe.getLabel() + '", "value": "' + pe.getValue() + '" }');
                            
                            }
                            
                            objJSON += ', "picklistOptions": [' + String.join(pickListOptions, ', ') + ']';   
                        }
                        objJSON += '}';
                    }
                    objJSON += '}';
                    
                    allObjJSON += objJSON;
                }
                
                // Close the object in the JSON String
                allObjJSON += '}';
                                
                return allObjJSON;
            } catch (Exception e) {
                return null;
            }
        } else{
            return null;
        }
    }
}