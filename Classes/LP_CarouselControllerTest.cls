@isTest
public class LP_CarouselControllerTest {

     @testSetup static void setup() {
        LP_BannerModal__c bannerMobile = New LP_BannerModal__c();
        bannerMobile.LP_Activo__c = true;
        bannerMobile.LP_Version__c = 'Mobile';
        bannerMobile.LP_Orden__c = 1;
        insert bannerMobile;
         
        LP_BannerModal__c bannerDesktop = New LP_BannerModal__c();
        bannerDesktop.LP_Activo__c = true;
        bannerDesktop.LP_Version__c = 'Desktop';
        bannerDesktop.LP_Orden__c = 1;
        insert bannerDesktop; 
    }
    
    @isTest
    public static void testMob(){
       List<LP_BannerModal__c> mob = LP_CarouselController.getCarousel(true);
       System.assert(mob.size() == 1);
    }
    
    @isTest
    public static void testDesk(){
       List<LP_BannerModal__c> desk = LP_CarouselController.getCarousel(false);
       System.assert(desk.size() == 1);
    }
}