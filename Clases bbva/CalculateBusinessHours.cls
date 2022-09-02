/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CalculateBusinessHours {
    @SuppressWarnings('sf:AvoidPublicFields')
    public class Request {
        @InvocableVariable (label='Fecha Hora' required = true)
        public DateTime givenDateTime;
        @InvocableVariable (label='Nombre de Horario de Oficina' required = true)
        public String businessHoursName;
    }
    @SuppressWarnings('sf:AvoidPublicFields')
    public class Response {
        @InvocableVariable (label='Dentro de horario de oficina')
        public Boolean isWithinBusinessHours;
    }
    /**
      * @description This method returns whether the current time is within the specified Business Hour or not
      * @param inputParams: Receives the given date time and the desired business hour name
      * @return Response: the validity state for the given date time
    */
    @InvocableMethod(label='Dentro de horario de oficina' description='Valida si el post de redes sociales ingresó dentro del horario de oficina')
    public static List<Response> isWithinBusinessHours(List<Request> inputParams){
        List<Response> responseList = new List<Response>();
        if(inputParams != null && inputParams.size()> 0){
            Map<String, Id> bhNamesWithId = getMappedBusinessHours(inputParams);

            for(Request param : inputParams) {
                Response rs = new Response();
                DateTime gmtParsedDate = Datetime.newInstanceGmt(param.givenDateTime.date(), param.givenDateTime.time());
                rs.isWithinBusinessHours = BusinessHours.isWithin(bhNamesWithId.get(param.businessHoursName), gmtParsedDate);
                responseList.add(rs);
            }
        }

        return responseList;
    }
    /**
      * @description This method returns a map between business hour names and ids
      * @param inputParams: Receives the given date time and the desired business hour name
      * @return Map<String, Id>: Business hours mapped with its correspond Id
    */
    private static Map<String, Id> getMappedBusinessHours(List<Request> inputParams){
        Set<String> bhNames = new Set<String>();

        for(Request param : inputParams){
            bhNames.add(param.businessHoursName);
        }

        List<BusinessHours> bhList = [SELECT Id, Name FROM BusinessHours WHERE Name IN :bhNames WITH SECURITY_ENFORCED];
        Map<String, Id> bhNamesWithId = new Map<String, Id>();

        for(BusinessHours bh : bhList){
            if(!bhNamesWithId.containsKey(bh.Name)){
                bhNamesWithId.put(bh.Name, bh.Id);
            }
        }

        return bhNamesWithId;
    }
}
