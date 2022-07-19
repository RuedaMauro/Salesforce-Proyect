global class EventoHCSchedule implements Schedulable, Database.AllowsCallouts {
    
    private String pagina = '1';   
    private String ultimaPagina;   
    private String type = 'begin';  

    public EventoHCSchedule(String pag, String ultimaPagina, String type) {
        this.pagina = pag;
        this.type = type;
        this.ultimaPagina = ultimaPagina;
    }
    
    public EventoHCSchedule() {
        this.pagina = '1';
        this.type = 'begin';
    }

    global void execute(SchedulableContext sc) {
        if (this.type == 'callout') {
        	EventosHCCallOut.beginInitialize(this.pagina, this.ultimaPagina);
        } else if(this.type == 'begin'){
            EventosHCCallOut.initializeEventosPagination(Integer.valueOf(this.pagina));
        }
    }
}