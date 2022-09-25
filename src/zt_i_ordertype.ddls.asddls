@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZT_I_OrderType
  as select from zpo_type
  association [1..1] to ZT_I_OrderTypeText as _Text on  $projection.OrderType = _Text.OrderType
                                                    and _Text.Language        = $session.system_language
{
  key po_type   as OrderType,
      is_active as IsActive,

      _Text
}
