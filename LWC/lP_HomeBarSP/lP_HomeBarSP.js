/*********************************************************************************
Project : LA POLAR Salesforce - Sitio Privado
Created By : Deloitte
Created Date : 14/06/2021
Description : Home Bar JS
History :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR ACRONYM
Lucas Agustin Lemes LAL
---------------------------------------------------------------------------------
VERSION AUTHOR DATE Description
1.0 LAL 21/07/2021 initial version
********************************************************************************/

import { LightningElement, api, track } from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';
import LogoLP from '@salesforce/resourceUrl/LP_LogoDocSP';
import getInfo from '@salesforce/apex/LP_HomeController.getUserInfo';
import getData from '@salesforce/apex/LP_PaymentController.getRefinanciationData';
import LP_TwitterfooterSP from '@salesforce/resourceUrl/LP_TwitterfooterSP'
import LP_YoutubefooterSP from '@salesforce/resourceUrl/LP_YoutubefooterSP'
import LP_FacebookfooterSP from '@salesforce/resourceUrl/LP_FacebookfooterSP'
import LP_ConsultasReclamos from '@salesforce/label/c.LP_ConsultasReclamos'
import LP_PreguntasFrencuentes from '@salesforce/label/c.LP_PreguntasFrencuentes'
import LP_TiendasLaPolarURL from '@salesforce/label/c.LP_TiendasLaPolarURL'
import LP_ConsultasyReclamosMenu from '@salesforce/label/c.LP_ConsultasyReclamosMenu'
import LP_PreguntasFrecuentesMenu from '@salesforce/label/c.LP_PreguntasFrecuentesMenu' 
import LP_TiendasLaPolarMenu from '@salesforce/label/c.LP_TiendasLaPolarMenu'
import LP_ServicioalClienteHome from '@salesforce/label/c.LP_ServicioalClienteHome'
import LP_BloqueoTarjetaHome from '@salesforce/label/c.LP_BloqueoTarjetaHome'
import LP_PagosHome from '@salesforce/label/c.LP_PagosHome'
import LP_RefinanciamientoMenu from '@salesforce/label/c.LP_RefinanciamientoMenu'
import LP_HistorialPagosMenu from '@salesforce/label/c.LP_HistorialPagosMenu'
import LP_PagarTuCuotaMenu from '@salesforce/label/c.LP_PagarTuCuotaMenu'
import LP_MiCuentaHome from '@salesforce/label/c.LP_MiCuentaHome'
import LP_EstadodeCuentaMenu from '@salesforce/label/c.LP_EstadodeCuentaMenu'
import LP_MovNoFacturadosMenu from '@salesforce/label/c.LP_MovNoFacturadosMenu'
import LP_MisCuposMenu from '@salesforce/label/c.LP_MisCuposMenu'
import LP_MiTarjetaDigitalMenu from '@salesforce/label/c.LP_MiTarjetaDigitalMenu'
import LP_BienvenidoHome from '@salesforce/label/c.LP_BienvenidoHome'
import LP_UltimaConexionHome from '@salesforce/label/c.LP_UltimaConexionHome'
import LP_PerfilUsuario from '@salesforce/resourceUrl/LP_PerfilUsuario'
import getCreatedPinData from '@salesforce/apex/LP_MyDigitalCardController.getCreatedPinData';
import LP_Power from '@salesforce/resourceUrl/LP_Power'
import basePath from "@salesforce/community/basePath";


export default class LP_HomeBarSP extends LightningElement {


    @api isMobile = FORM_FACTOR === 'Small';
    @api menuOpen = false;
    @api showCreatePin = false;
    @api showButtonDigitalAccount=false;
    @api showRefButton = false;
    @api nombre = "";
    @api conexion = "";
    @api showResponsive = false;
    @api menuResponsiveOpen = false;
    @api showMenuBar = false;

    logo = LogoLP;

    iconHome = {
        LP_TwitterfooterSP,
        LP_YoutubefooterSP,
        LP_FacebookfooterSP,
        LP_PerfilUsuario,
        LP_Power,
        LP_ConsultasReclamos,
        LP_PreguntasFrencuentes,
        LP_TiendasLaPolarURL,
        LP_ConsultasyReclamosMenu,
        LP_PreguntasFrecuentesMenu,
        LP_TiendasLaPolarMenu,
        LP_ServicioalClienteHome,
        LP_BloqueoTarjetaHome,
        LP_PagosHome,
        LP_RefinanciamientoMenu,
        LP_HistorialPagosMenu,
        LP_PagarTuCuotaMenu,
        LP_MiCuentaHome,
        LP_EstadodeCuentaMenu,
        LP_MovNoFacturadosMenu,
        LP_MisCuposMenu,
        LP_MiTarjetaDigitalMenu,
        LP_BienvenidoHome,
        LP_UltimaConexionHome
    }

  

    @api bloqueoOpen = false;


    openMenu(){
        this.menuOpen = true;
    }
    openMenuResponsive(){
        this.menuResponsiveOpen = true;
        this.showMenuBar = true;
    }
    closeMenuResponsive(){
        this.menuResponsiveOpen = false;
        this.showMenuBar = false;
    }
    closeMenu(){
        this.menuOpen = false;
    }
    openProfile(){

        /**
      * @Description: Opens in the same window the My Profile menu.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */


        window.open("mi-perfil","_self");
    }

    resize(){
        this.dispatchEvent(new CustomEvent('resize'));
    }


    connectedCallback() {

        var t;
        var c;

        if(window.innerWidth <= 1000){
            this.showResponsive = true;
        }

        window.onresize = () => {


           this.showMenuBar = resizing2(this, window.innerWidth, this.menuResponsiveOpen) //1
            

            this.showResponsive = t;
            this.showMenuBar;

            
            
        }

        function resizing2(target, w, h) {
            if(w <= 1000){
      
                t = true;
                if(h == true){
                    c = true;
                }
                else{
                    c = false;
                }
               
               
            }
            else{
                
                t = false;
                c = false;
              
                
            }
            return c
            
        } 


        getInfo()
        .then(result => {

            /**
      * @Description: Retrieves login data for the user.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */


            if (result.name.toLowerCase().indexOf("sitio") == -1 && result.name != '')
            {
                this.nombre = result.name;
                    if(result.loginOK==false){
                        this.conexion = " ";
                        
                    }
                    else{

                        var date = new Date(result.lastLoginDate);


                        var day = date.getDate();
                       
                        var month = new Date(date.setMonth(date.getMonth()+1));
                       
                        var hours = date.getHours();
                       
                        var minutes = date.getMinutes();
                        
                   
                        this.conexion = day + '/' + this.pad(month.getMonth(),2) + '/' + date.getFullYear() + '; ' + this.pad(hours,2) + ":" + this.pad(minutes,2) + ' hrs';
                 
                        
                    }
                    this.showUser = true;
            }

        })


        getCreatedPinData()

        /**
      * @Description: Verifies if the client has TLP Visa.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */

            .then((result) => {

                console.log(JSON.stringify(result));
                    if(result.VisaClient==true){
                        this.showButtonDigitalAccount=true;
                    }
            })
        
            getData()
            .then((result) => {

                /**
      * @Description: Verifies if the client has refinantiation posibilities.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */
                if (result.renegSituation == true) {
                    this.showRefButton = true;
                }

            })
        

    }

    handlePopup(){
        this.bloqueoOpen = false;
        this.bloqueoOpen = true;
    }

    openBlock(){
        window.open("bloqueo-de-tarjeta","_self");
    }
    openLockCard(){
        window.open("pagos-de-cuenta?clicked=paga-tu-cuota","_self");
    }
    openMyAccount(){
        window.open("mi-cuenta?clicked=mis-cupos","_self");
    }

    pad(num, size){

        /**
      * @Description: Adds a zero for the date if the date is a 1 char string.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */

        num = num.toString();
        while (num.length < size) num = "0" + num;
        return num;
    }
    

    get logoutLink() {

        /**
      * @Description: Creates the logout link.
      * @Author: Lucas Agustin Lemes, Deloitte, llemes@deloitte.com
      * @Date: 21/07/2021
      */

        const sitePrefix = basePath.replace(/\/s$/i, "");
        return sitePrefix + "/secur/logout.jsp";
    }


}