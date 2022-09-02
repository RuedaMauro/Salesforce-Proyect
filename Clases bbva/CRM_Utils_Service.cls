/**
  * -------------------------------------------------------------------------------------------------
  * @Name   CRM_Utils_Service
  * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
  * @Date   Created: 2022-01-06
  * @Group  Util
  * -------------------------------------------------------------------------------------------------
  * @Description This public class is for all kinds of logic that can be reused.
  * -------------------------------------------------------------------------------------------------
  * @Changes
  *
  **/
public with sharing class CRM_Utils_Service {
    /**
      * @Description This method verifies that there are no missing fields for the conversion of the form to case.
      * -----------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2022-01-06
      * @param fields: Name of fields to be analyzed in the body of the mail
      * @param matchers: Comparators to analyze the body of the email
      * @param referenceName: Referenced field name
      * @return List<String>: Names of missing fields
      * @example public List<String> checkRequiredFieldsForFormConversion(Map<String, String> fields, Map<String, Matcher> matchers, String referenceName)
      **/
    public List<String> checkRequiredFieldsForFormConversion(Map<String, String> fields, Map<String, Matcher> matchers, String referenceName) {
        List<String> missingRequiredFields = new List<String>();

        if (!matchers.get(referenceName).find()) {
            missingRequiredFields.add(referenceName);
        } else if (String.isEmpty(matchers.get(referenceName).group(0).replaceFirst(fields.get(referenceName),'').trim())) {
            missingRequiredFields.add(referenceName);
        }

        return missingRequiredFields;
    }
}