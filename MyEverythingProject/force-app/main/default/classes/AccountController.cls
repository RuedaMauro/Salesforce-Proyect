public without sharing class AccountController {
	public Account acct{get; set;}
	public AccountController(){
		acct = new Account();
	}
	
	public void save(){
		upsert acct;
	}
}