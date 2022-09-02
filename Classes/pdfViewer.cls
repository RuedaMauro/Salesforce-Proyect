public without sharing class pdfViewer {
    Public String rut{
        get{
            return getDoc(ApexPages.currentPage().getParameters().get('rut'), ApexPages.currentPage().getParameters().get('pan'), ApexPages.currentPage().getParameters().get('fecemi'));
        }
        private set;
    }
    
    public static String getDoc(String rut, String pan, String fecemi){
        LP_Response rp = LP_MyAccountController.getDocument(rut, pan, fecemi);
        return rp.doc;
    }
}

//   <iframe src="data:application/pdf;base<64,{!$CurrentPage.rut}" height="100%" width="100%"></iframe>