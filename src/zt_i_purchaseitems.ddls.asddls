@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZT_I_PurchaseItems
  as select from zpoitem_db
{
  key po_order              as PurchaseOrder,
  key po_item               as PurchaseItem,
      short_text            as ShortText,
      material              as Material,
      plant                 as Plant,
      mat_group             as MatGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      order_qunt            as OrderQunt,
      order_unit            as OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      product_price         as ProductPrice,
      price_unit            as PriceUnit,
      local_last_changed_by as LocalLastChangedBy
}
