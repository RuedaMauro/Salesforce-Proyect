global with sharing class LP_CarouselController {   

    /*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Carousel
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			10/06/2021		initial version
********************************************************************************/ 
     /**
    *  @Description: Get all carousel resources.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        17/06/2021
    */
    @AuraEnabled
    public static List<LP_BannerModal__c> getCarousel(Boolean isMobile){
        String version;
        
        if (isMobile){
            version = 'Mobile';
        }
        else
        {
            version = 'Desktop';
        }
    	return [SELECT id, LP_Activo__c, LP_Orden__c, LP_NombreImagen__c, LP_Version__c, LP_VinculoPublico__c 
                FROM LP_BannerModal__c 
                WHERE LP_Activo__c = true AND LP_Version__c =: version ORDER BY LP_Orden__c ASC];
    }
}