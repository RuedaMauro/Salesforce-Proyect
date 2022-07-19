global class AgendaSchedule implements Schedulable, Database.AllowsCallouts {
    
    private String pagina = '1';   
    private String ultimaPagina;   
    private String type = 'begin';   

    public AgendaSchedule(String pag, String ultimaPagina, String type) {
        this.pagina = pag;
        this.type = type;
        this.ultimaPagina = ultimaPagina;
    }
    
    public AgendaSchedule() {
        this.pagina = '1';
        this.type = 'begin';
    }

    global void execute(SchedulableContext sc) {
        if (this.type == 'callout') {
            AgendaCallOutsTest.beginInitialize(this.pagina, this.ultimaPagina);
        }else if(this.type == 'begin'){
            AgendaCallOutsTest.getSerApp(Integer.valueOf(this.pagina));
        }
    }
 }