@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZT_Supplier_VH as select from zsupplier {
@ObjectModel.text.element: ['SupplierName']
    @Search.defaultSearchElement: true
    key supplierid as Supplierid,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Semantics.text: true
    supplier_name as SupplierName
//    email_address as EmailAddress,
//    phone_number as PhoneNumber,
//    fax_number as FaxNumber,
//    web_address as WebAddress
}
