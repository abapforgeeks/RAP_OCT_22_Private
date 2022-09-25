@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
}
@ObjectModel.dataCategory: #TEXT
define view entity ZT_I_OrderTypeText
  as select from zpo_type_txt
  association to ZT_I_OrderType as _OrderType on $projection.OrderType = _OrderType.OrderType
{
      @Semantics.language: true
  key spras     as Language,
       @ObjectModel.text.element: ['Text']
  key po_type   as OrderType,
      @Semantics.text: true
      type_desc as Text,

      _OrderType
}
