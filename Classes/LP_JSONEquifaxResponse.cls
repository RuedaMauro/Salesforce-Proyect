/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 18/05/2021
Description  : JSON response for Equifax validation
History      : PCRM-13
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Alan Sanhueza Carrasco	     ASC
Nelson Lepiqueo Lepiqueo     NLL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ASC-NLL     18/05/2021		  initial version
********************************************************************************/
public class LP_JSONEquifaxResponse {

	public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       ASC-NLL, Deloitte, asanhuezac@deloitte.com
    *  @Date:        18/05/2021
    */
	public class Items {
		public String genderDescription;
		public String gender;
		public String unpaidTotalNumber;
		public String flagDeathDescription;
		public String totalDebts;
		public String transactionId;
		public String totalAmountDebts;
		public String rut;
		public Decimal score;
		public String nameFull;
		public String dateLastDebts;
		public String unpaidTotalNumberInformed;
		public String surname;
		public String name;
		public String fatherSurname;
		public String documentStatus;
		public String age;
		public String amountLastDebts;
	}

	/**
    *  @Description: parse method
    *  @Autor:       ASC-NLL, Deloitte, asanhuezac@deloitte.com
    *  @Date:        18/05/2021
    */
	public LP_JSONEquifaxResponse parse(String json) {
		return (LP_JSONEquifaxResponse) System.JSON.deserialize(json, LP_JSONEquifaxResponse.class);
	}
}