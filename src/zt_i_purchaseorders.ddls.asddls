@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZT_I_PurchaseOrders
  as select from zpoheader_db
  association[1..*] to ZT_I_PurchaseItems as _Items on $projection.PurchaseOrder = _Items.PurchaseOrder
{
  key po_order              as PurchaseOrder,
      po_type               as OrderType,
      comp_code             as CompanyCode,
      po_org                as PurchaseOrg,
      supplier              as Supplier,
      create_by             as CreateBy,
      created_date_time     as CreatedDateTime,
      changed_date_time     as ChangedDateTime,
      local_last_changed_by as LocalLastChangedBy,

      _Items
}
