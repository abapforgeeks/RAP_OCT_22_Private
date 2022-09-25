@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Info'

@Search.searchable: true
//@ObjectModel.dataCategory: #VALUE_HELP
define view entity zt_i_supplier
  as select from zsupplier
{
     @Search.defaultSearchElement: true
     @ObjectModel.text.element: ['SupplierName']
  key supplierid    as Supplierid,
      @Semantics: {
      text: true,
      name.fullName: true
      }
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @UI.identification: [{ position: 10, label: 'Supplier Name' }]    
      supplier_name as SupplierName,
      @Semantics.eMail.address: true
      @EndUserText.label: 'Email'
      @Semantics.eMail.type: [ #WORK]
      @UI.identification: [{ position: 20, label: 'Email Address' }]
      email_address as EmailAddress,
      @Semantics.telephone.type: [ #WORK]
      @UI.identification: [{ position: 20, label: 'Phone Number' }]
      
      phone_number  as PhoneNumber,
      @Semantics.telephone.type: [ #FAX ]
      fax_number as FaxNumber,
      @Semantics.address.type: [ #OTHER ]
      web_address as WebAddress
      
}
