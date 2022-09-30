@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@UI.headerInfo:{
description:{ value: 'ShortText'},
title:{value: 'PurchaseItem' },
typeName: 'Item',
typeNamePlural: 'Items'
}
@Search.searchable: true
define view entity ZT_I_PurchaseItems
  as select from zpoitem_db
  association [1] to ZT_I_PurchaseOrders as _Orders on $projection.PurchaseOrder = _Orders.POrder
{
      @UI.facet: [{
      id:'ItemData',
      type: #IDENTIFICATION_REFERENCE,
      position: 10,
      purpose: #STANDARD,
      label: 'Item Information'
       }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key po_order      as PurchaseOrder,
      @UI.lineItem: [{ position: 20 }]
      @ObjectModel.text.element: ['ShortText']
      @UI.identification: [{ position: 20,label: 'Item Number' }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key po_item       as PurchaseItem,
      short_text    as ShortText,
      @UI.lineItem: [{ position: 30 ,label: 'Materilal'}]

      @UI.identification: [{ position: 30,label: 'Material' }]
      material      as Material,
      @UI.lineItem: [{ position: 40,label: 'Plant' }]
      plant         as Plant,
      @UI.lineItem: [{ position: 50,label: 'Materilal Group' }]
      mat_group     as MatGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      @UI.lineItem: [{ position: 60,label: 'Quantity' }]

      @UI.identification: [{ position: 40, label: 'Quanity' }]
      order_qunt    as OrderQunt,
      //      @UI.lineItem: [{ position: 70,label: '' }]
      order_unit    as OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      @UI.lineItem: [{ position: 80,label: 'Price' }]

      @UI.identification: [{ position: 50,label: 'Price' }]
      product_price as ProductPrice,
      //      @UI.lineItem: [{ position: 90,label: 'Materilal' }]
      price_unit    as PriceUnit,
      //      local_last_changed_by as LocalLastChangedBy
      _Orders
}
