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
define view entity ZT_Purchase_Order_VH as select from ZT_I_PurchaseOrders {
    @ObjectModel.text.element: ['PurchaseDescription']
    key POrder,
    @Search.defaultSearchElement: true
    @Semantics.text: true
    PurchaseDescription
   
}
