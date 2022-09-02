/**
  * -------------------------------------------------------------------------------------------------
  * @Name   CRM_Case_Service
  * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
  * @Date   Created: 2021-11-17
  * @Group  Form Conversion
  * -------------------------------------------------------------------------------------------------
  * @Description This public class converts the emails received from public or private forms into
  *              cases and accounts / contacts, depending on the case.
  * -------------------------------------------------------------------------------------------------
  * @Changes
  *
  *   | 2021-11-18  galo.guardia.contractor@gdevtools.com
  *                 Creating new methods 'checkMissingRequiredFields', 'checkRequiredMessageFields',
  *                 'checkRequiredUserContactFields' and 'accountForCase' for best practices.
  *
  *   | 2021-11-26  galo.guardia.contractor@gdevtools.com
  *                 Creating new class 'FieldsAndMatchers' for best practices.
  *                 Creating new methods 'getFieldsAndMatchers' and 'mapCase' for best practices.
  *
  *   | 2021-11-30  galo.guardia.contractor@gdevtools.com
  *                 Creating new methods 'completeCasePrivateForm' and 'completeCasePublicForm' for best practices.
  *
  *   | 2022-01-06  galo.guardia.contractor@gdevtools.com
  *                 Creating new methods 'checkOtherRequiredFields' for best practices.
  *
  **/
public with sharing class CRM_Case_Service implements Messaging.InboundEmailHandler {

    /**
    * -------------------------------------------------------------------------------------------------
    * @Name   EmailData
    * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
    * @Date   Created: 2022-01-06
    * @Group  Form Conversion
    * -------------------------------------------------------------------------------------------------
    * @Description This public class is used to contain the email data
    **/
    public class EmailData {
        public String body { get; set; }
        public String subject { get; set; }
        public List<String> toAddress { get; set; }
    }

    /**
      * -------------------------------------------------------------------------------------------------
      * @Name   FieldsAndMatchers
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-26
      * @Group  Form Conversion
      * -------------------------------------------------------------------------------------------------
      * @Description This public class is used to contain the fields and matchers of the received email.
      **/
    public class FieldsAndMatchers {
        public Map<String, String> fields { get; set; }
        public Map<String, Matcher> matchers { get; set; }
    }

    /**
      * @Description This method generates a case and an account or contact based on an incoming email
      * -------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-17
      * @param email: Email to analyze
      * @param env: Envelope
      * @return Messaging.InboundEmailResult: Result of the covertion
      * @example public Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env)
      **/
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        EmailData emailData = getEmailData(email);

        try {
            FieldsAndMatchers fieldsAndMatchers = getFieldsAndMatchers(emailData.body);

            Map<String, String> fields = fieldsAndMatchers.fields;
            Map<String, Matcher> matchers = fieldsAndMatchers.matchers;

            List<String> missingRequiredFields = checkMissingRequiredFields(fields, matchers);

            if (missingRequiredFields.size() > 0) {
                String missingFields = String.join(missingRequiredFields, ', ');
                result.success = false;
                result.message = 'Error al generar los registros, hay campos obligatorios faltantes: ' + missingFields + '<br>Mensaje recibido: ' + emailData.body;
                System.debug(result.message);
                return result;
            }

            Map<String, String> emailValuesForCase = new Map<String, String>{
                'EnviadoDesde' => matchers.get('EnviadoDesde').group(0).replaceFirst(fields.get('EnviadoDesde'), '').trim(),
                'Subject' => emailData.subject,
                'SelectedEmail' => emailData.toAddress[0].trim(),
                'Mensaje' => (emailData.body.substringAfterLast('<td>Mensaje:') != '') ? emailData.body.substringAfterLast('<td>Mensaje:').substringBeforeLast('</table>').trim() : emailData.body.substringAfterLast('<br/>Mensaje:').substringBeforeLast('</body>').trim()
            };

            Case newCase = mapCase(emailValuesForCase, fieldsAndMatchers);

            String valueNroDocumento = matchers.get('NroDocumento').group(0).replaceFirst(fields.get('NroDocumento'), '').trim();
            String valueEmail = matchers.get('Email').group(0).replaceFirst(fields.get('Email'), '').replaceAll('<mailto:.*>', '').trim();
            String valueTelefono = (matchers.get('Telefono').find()) ? matchers.get('Telefono').group(0).replaceFirst(fields.get('Telefono'), '').trim() : '';

            List<String> listNombre = matchers.get('Nombre').group(0).replaceFirst(fields.get('Nombre'), '').split(' ');
            String valueFirstName = listNombre.remove(0).trim();
            String valueLastName = String.join(listNombre, ' ').trim();

            if (emailValuesForCase.get('EnviadoDesde') == 'BANCA ONLINE') {
                Map<String, String> values = new Map<String, String>{
                    'FirstName' => valueFirstName,
                    'LastName' => valueLastName,
                    'NroDocumento' => valueNroDocumento,
                    'Email' => valueEmail,
                    'Telefono' => valueTelefono
                };

                Account acc = accountForCase(values);
                if (acc != null) {
                    newCase.AccountId = acc.Id;
                    newCase.ContactId = [SELECT PersonContactId FROM Account WHERE Id =: acc.Id WITH SECURITY_ENFORCED LIMIT 1].PersonContactId;
                }
            } else {
                Contact newContact = new Contact(
                    FirstName = valueFirstName,
                    LastName = valueLastName,
                    CRM_SCC_DocumentNumber__c = valueNroDocumento,
                    CRM_SCC_DocumentType__c = 'DNI',
                    Email = valueEmail,
                    Phone = valueTelefono
                );

                if (Contact.sObjectType.getDescribe().isCreateable()) {
                    insert newContact;
                    newCase.ContactId = newContact.Id;
                } else {
                    System.debug('No tiene permisos para poder crear un Contacto.');
                }
            }

            if (Case.sObjectType.getDescribe().isCreateable()) {
                insert newCase;
                //Add email attachments
                insertEmailAttachments(email, newCase);
            } else {
                System.debug('No tiene permisos para poder crear un Caso.');
            }

            result.success = true;
            result.message = '';
        } catch (Exception e) {
            result.success = false;
            result.message = '';
            System.debug(result.message + ' | Line: ' + e.getLineNumber());
        }

        return result;
    }

    /**
      * @Description This method returns the email data to analyze the creation of the case
      * -------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2022-01-06
      * @param email: Email to analyze
      * @return EmailData: Email data to analyze the creation of the case
      * @example public EmailData getEmailData(Messaging.inboundEmail email)
      **/
    public EmailData getEmailData(Messaging.inboundEmail email) {
        EmailData emailData = new EmailData();

        emailData.body = (email.plainTextBody != null) ? email.plainTextBody : email.htmlBody.replace('</td></tr>', '');
        System.debug(emailData.body);
        emailData.subject = email.subject;
        System.debug(emailData.subject);
        emailData.toAddress = email.toAddresses;
        System.debug(emailData.toAddress);

        return emailData;
    }

    /**
      * @Description This method returns the fields and matchers obtained with the body of the received email
      * -------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-26
      * @param body: Body of the email received
      * @return FieldsAndMatchers: Fields and Matchers for the email body search
      * @example public FieldsAndMatchers getFieldsAndMatchers(String body)
      **/
    public FieldsAndMatchers getFieldsAndMatchers(String body) {
        FieldsAndMatchers res = new FieldsAndMatchers();

        Map<String, String> fields = new Map<String, String>{
            'Nombre' => 'Nombre:',
            'EnviadoDesde' => 'Enviado desde:',
            'NroContacto' => '(Contacto Nro:)|(Contacto Nro.:)',
            'NroDocumento' => 'Nro. de Documento:',
            'Email' => 'Email:',
            'Telefono' => '(Teléfono:)|(Tel&eacute;fono:)',
            'Horario' => 'Horario:',
            'TipoMensaje' => 'Tipo Mensaje:',
            'Mensaje' => 'Mensaje:'
        };

        final String regex_Nombre = '(' + fields.get('Nombre') + ')'+ '.+';
        final String regex_EnviadoDesde = '(' + fields.get('EnviadoDesde') + ')'+ '.+';
        final String regex_NroContacto = '(' + fields.get('NroContacto') + ')'+ '.+';
        final String regex_NroDocumento = '(' + fields.get('NroDocumento') + ')'+ '.+';
        final String regex_Email = '(' + fields.get('Email') + ')'+ '.+';
        final String regex_Telefono = '(' + fields.get('Telefono') + ')'+ '.+';
        final String regex_Horario = '(' + fields.get('Horario') + ')'+ '.+';
        final String regex_TipoMensaje = '(' + fields.get('TipoMensaje') + ')' + '.+';
        final String regex_Mensaje = '(' + fields.get('Mensaje') + ')' + '.+';

        Map<String, Matcher> matchers = new Map<String, Matcher>{
            'Nombre' => Pattern.compile(regex_Nombre).matcher(body),
            'EnviadoDesde' => Pattern.compile(regex_EnviadoDesde).matcher(body),
            'NroContacto' => Pattern.compile(regex_NroContacto).matcher(body),
            'NroDocumento' => Pattern.compile(regex_NroDocumento).matcher(body),
            'Email' => Pattern.compile(regex_Email).matcher(body),
            'Telefono' => Pattern.compile(regex_Telefono).matcher(body),
            'Horario' => Pattern.compile(regex_Horario).matcher(body),
            'TipoMensaje' => Pattern.compile(regex_TipoMensaje).matcher(body)
        };
        matchers.put('Mensaje', Pattern.compile(regex_Mensaje).matcher(matchers.get('TipoMensaje').replaceAll('')));

        res.fields = fields;
        res.matchers = matchers;

        return res;
    }

    /**
      * @Description This method verifies that there are no missing fields in the body of the email
      * -------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-18
      * @param fields: Name of fields to be analyzed in the body of the mail
      * @param matchers: Comparators to analyze the body of the email
      * @return List<String>: Names of missing fields
      * @example public List<String> checkMissingRequiredFields(Map<String, String> fields, Map<String, Matcher> matchers)
      **/
    public List<String> checkMissingRequiredFields(Map<String, String> fields, Map<String, Matcher> matchers) {
        List<String> missingRequiredFields = new List<String>();

        Map<String, String> othersFields = new Map<String, String>{
            'Nombre' => fields.get('Nombre'),
            'EnviadoDesde' => fields.get('EnviadoDesde'),
            'NroContacto' => fields.get('NroContacto'),
            'NroDocumento' => fields.get('NroDocumento')
        };
        Map<String, Matcher> othersMatchers = new Map<String, Matcher>{
            'Nombre' => matchers.get('Nombre'),
            'EnviadoDesde' => matchers.get('EnviadoDesde'),
            'NroContacto' => matchers.get('NroContacto'),
            'NroDocumento' => matchers.get('NroDocumento')
        };

        missingRequiredFields.addAll(checkOtherRequiredFields(othersFields, othersMatchers));

        Map<String, String> fieldsUserContact = new Map<String, String>{
            'Email' => fields.get('Email'),
            'Telefono' => fields.get('Telefono')
        };
        Map<String, Matcher> matchersUserContact = new Map<String, Matcher>{
            'Email' => matchers.get('Email'),
            'Telefono' => matchers.get('Telefono')
        };

        missingRequiredFields.addAll(checkRequiredUserContactFields(fieldsUserContact, matchersUserContact));

        Map<String, String> fieldsMessage = new Map<String, String>{
            'TipoMensaje' => fields.get('TipoMensaje'),
            'Mensaje' => fields.get('Mensaje')
        };
        Map<String, Matcher> matchersMessage = new Map<String, Matcher>{
            'TipoMensaje' => matchers.get('TipoMensaje'),
            'Mensaje' => matchers.get('Mensaje')
        };

        missingRequiredFields.addAll(checkRequiredMessageFields(fieldsMessage, matchersMessage));

        return missingRequiredFields;
    }

    /**
      * @Description This method verifies that there are no missing other fields in the body of the email
      * ----------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2022-01-06
      * @param othersFields: Name of fields to be analyzed in the body of the mail
      * @param othersMatchers: Comparators to analyze the body of the email
      * @return List<String>: Names of other missing fields
      * @example public List<String> checkOtherRequiredFields(Map<String, String> othersFields, Map<String, Matcher> othersMatchers)
      **/
    public List<String> checkOtherRequiredFields(Map<String, String> othersFields, Map<String, Matcher> othersMatchers) {
        List<String> missingRequiredFields = new List<String>();

        CRM_Utils_Service utilService = new CRM_Utils_Service();
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(othersFields, othersMatchers, 'Nombre'));
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(othersFields, othersMatchers, 'EnviadoDesde'));
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(othersFields, othersMatchers, 'NroContacto'));
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(othersFields, othersMatchers, 'NroDocumento'));

        return missingRequiredFields;
    }

    /**
      * @Description This method verifies that there are no missing message fields in the body of the email
      * ----------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-18
      * @param fieldsMessage: Name of fields to be analyzed in the body of the mail
      * @param matchersMessage: Comparators to analyze the body of the email
      * @return List<String>: Names of missing message fields
      * @example public List<String> checkRequiredMessageFields(Map<String, String> fieldsMessage, Map<String, Matcher> matchersMessage)
      **/
    public List<String> checkRequiredMessageFields(Map<String, String> fieldsMessage, Map<String, Matcher> matchersMessage) {
        List<String> missingRequiredFields = new List<String>();

        CRM_Utils_Service utilService = new CRM_Utils_Service();
        // missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(fieldsMessage, matchersMessage, 'TipoMensaje'));
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(fieldsMessage, matchersMessage, 'Mensaje'));

        return missingRequiredFields;
    }

    /**
      * @Description This method verifies that there are no missing user contact fields in the body of the email
      * ----------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-18
      * @param fieldsUserContact: Name of fields to be analyzed in the body of the mail
      * @param matchersUserContact: Comparators to analyze the body of the email
      * @return List<String>: Names of missing user contact fields
      * @example public List<String> checkRequiredUserContactFields(Map<String, String> fieldsUserContact, Map<String, Matcher> matchersUserContact)
      **/
    public List<String> checkRequiredUserContactFields(Map<String, String> fieldsUserContact, Map<String, Matcher> matchersUserContact) {
        List<String> missingRequiredFields = new List<String>();

        CRM_Utils_Service utilService = new CRM_Utils_Service();
        missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(fieldsUserContact, matchersUserContact, 'Email'));
        // missingRequiredFields.addAll(utilService.checkRequiredFieldsForFormConversion(fieldsUserContact, matchersUserContact, 'Telefono'));

        return missingRequiredFields;
    }

    /**
      * @Description This method verifies if there is an account already created with the same document number, if it does not exist create one
      * -----------------------------------------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-18
      * @param values: Values ​​for account creation and search
      * @return Account: Account created or found
      * @example public Account accountForCase(Map<String, String> values)
      **/
    public Account accountForCase(Map<String, String> values) {
        List<Account> accList = [SELECT Id, PersonContactId FROM Account WHERE CRM_SCC_DocumentNumber__c =: values.get('NroDocumento') WITH SECURITY_ENFORCED LIMIT 1];

        if (accList.size() == 0) {
            Account newAcc = new Account(
                FirstName = values.get('FirstName'),
                LastName = values.get('LastName'),
                CRM_SCC_DocumentNumber__c = values.get('NroDocumento'),
                CRM_SCC_DocumentType__c = 'DNI',
                PersonEmail = values.get('Email'),
                Phone = values.get('Telefono'),
                RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PersonAccount' AND SObjectType = 'Account'].Id
            );

            if (Account.sObjectType.getDescribe().isCreateable()) {
                insert newAcc;
                return newAcc;
            } else {
                System.debug('No tiene permisos para poder crear una Cuenta.');
                return null;
            }
        } else {
            return accList[0];
        }
    }

    /**
      * @Description This method creates a case based on the values ​​of the received email
      * -----------------------------------------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-26
      * @param emailValuesForCase: Mail settings for case creation
      * @param fieldsAndMatchers: Fields and matchers for case fields
      * @return Case: Case created
      * @example public Case mapCase(Map<String, String> emailValuesForCase, FieldsAndMatchers fieldsAndMatchers)
      **/
    public Case mapCase(Map<String, String> emailValuesForCase, FieldsAndMatchers fieldsAndMatchers) {
        List<String> subjectArray = emailValuesForCase.get('Subject').split(' - ');

        Case newCase = new Case(
            CRM_SCC_NroContacto__c = fieldsAndMatchers.matchers.get('NroContacto').group(0).replaceFirst(fieldsAndMatchers.fields.get('NroContacto'), '').trim(),
            Description = emailValuesForCase.get('Mensaje'),
            Subject = emailValuesForCase.get('Subject')
        );

        if (emailValuesForCase.get('SelectedEmail').length() <= 80) {
            newCase.CRM_SCC_SelectedEmail__c = emailValuesForCase.get('SelectedEmail');
            newCase.CRM_SCC_FirstSelectedEmail__c = emailValuesForCase.get('SelectedEmail');
        }

        if (emailValuesForCase.get('EnviadoDesde') == 'BANCA ONLINE') {
            newCase = completeCasePrivateForm(newCase, subjectArray, fieldsAndMatchers);
        } else {
            newCase = completeCasePublicForm(newCase, subjectArray, fieldsAndMatchers);
        }

        return newCase;
    }

    /**
      * @Description This method completes the subject of the case and the fields related to it for the private form
      * -----------------------------------------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-30
      * @param newCase: Case created
      * @param subjectArray: Email subject details list
      * @param fieldsAndMatchers: Fields and matchers for case fields
      * @return Case: Case created
      * @example public Case completeCasePrivateForm(Case newCase, List<String> subjectArray, FieldsAndMatchers fieldsAndMatchers)
      **/
    public Case completeCasePrivateForm(Case newCase, List<String> subjectArray, FieldsAndMatchers fieldsAndMatchers) {
        newCase.Origin = 'Formulario Privado';

        if (fieldsAndMatchers.matchers.get('Horario').find()) {
            newCase.CRM_SCC_Horario__c = fieldsAndMatchers.matchers.get('Horario').group(0).replaceFirst(fieldsAndMatchers.fields.get('Horario'), '').trim();
        }

        if (subjectArray.size() > 1) {
            newCase.Type = subjectArray[1].trim();
            newCase.CRM_SCC_ContactReason__c = (subjectArray.size() == 4) ? subjectArray[subjectArray.size() - 2].trim() : '';
            newCase.CRM_SCC_ProductAndService__c = subjectArray[subjectArray.size() - 1].trim();
        }

        if (fieldsAndMatchers.matchers.get('TipoMensaje').find()) {
            newCase.Type = fieldsAndMatchers.matchers.get('TipoMensaje').group(0).replaceFirst(fieldsAndMatchers.fields.get('Mensaje'), '').trim();
        }

        return newCase;
    }

    /**
      * @Description This method completes the subject of the case and the fields related to it for the public form
      * -----------------------------------------------------------------------------------------------------------------------------------------
      * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
      * @Date   Created: 2021-11-30
      * @param newCase: Case created
      * @param subjectArray: Email subject details list
      * @param fieldsAndMatchers: Fields and matchers for case fields
      * @return Case: Case created
      * @example public Case completeCasePublicForm(Case newCase, List<String> subjectArray, FieldsAndMatchers fieldsAndMatchers)
      **/
    public Case completeCasePublicForm(Case newCase, List<String> subjectArray, FieldsAndMatchers fieldsAndMatchers) {
        newCase.Origin = 'Formulario Público';

        if (subjectArray.size() > 1) {
            final Boolean isTest = (subjectArray[0].trim() == '[TEST]');
            if (isTest) {
                newCase.CRM_SCC_ContactReason__c = (subjectArray.size() == 5) ? subjectArray[subjectArray.size() - 2].trim() : '';
                newCase.Type = subjectArray[2].trim();
            } else {
                newCase.CRM_SCC_ContactReason__c = (subjectArray.size() == 4) ? subjectArray[subjectArray.size() - 2].trim() : '';
                newCase.Type = subjectArray[1].trim();
            }

            newCase.CRM_SCC_ProductAndService__c = subjectArray[subjectArray.size() - 1].trim();
        }

        if (fieldsAndMatchers.matchers.get('TipoMensaje').find()) {
            newCase.Type = fieldsAndMatchers.matchers.get('TipoMensaje').group(0).replaceFirst(fieldsAndMatchers.fields.get('Mensaje'), '').trim();
        }

        return newCase;
    }

    /**
      * @Description This method completes the subject of the case and the fields related to it for the public form
      * -----------------------------------------------------------------------------------------------------------------------------------------
      * @param inboundEmail: Incoming email
      * @param relatedCase: Parent record to add attachments
      **/
    private void insertEmailAttachments(Messaging.inboundEmail inboundEmail, Case relatedCase){
        Boolean hasTextAttachments = inboundEmail.textAttachments != null;
        Boolean hasBinaryAttachments = inboundEmail.binaryAttachments  != null;
        List<Attachment> attachmentsToInsert = new List<Attachment>();

        try {
            if(hasTextAttachments){
                for (Messaging.Inboundemail.TextAttachment tAttachment : inboundEmail.textAttachments) {
                    Attachment attachment = new Attachment();

                    attachment.Name = tAttachment.fileName;
                    attachment.Body = Blob.valueOf(tAttachment.body);
                    attachment.ParentId = relatedCase.Id;

                    attachmentsToInsert.add(attachment);
                }

            }

            if(hasBinaryAttachments){
                for (Messaging.Inboundemail.BinaryAttachment bAttachment : inboundEmail.binaryAttachments) {
                    Attachment attachment = new Attachment();

                    attachment.Name = bAttachment.fileName;
                    attachment.Body = bAttachment.body;
                    attachment.ParentId = relatedCase.Id;

                    attachmentsToInsert.add(attachment);
                }
            }

            if (Attachment.sObjectType.getDescribe().isCreateable()) {
                insert attachmentsToInsert;
            }
        } catch (Exception e) {
            System.debug('Insert attachments failed: ' + e.getMessage());
        }
    }
}