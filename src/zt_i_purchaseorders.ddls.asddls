@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order'

@UI.headerInfo: { imageUrl: 'ImageURL',
typeName: 'Purchase Order',
                  typeNamePlural: 'Purchase Orders' ,
                  title: {value: 'PurchaseDescription'},
                  description:{value: 'OrderTypeDesc' }
                    }

@ObjectModel.semanticKey: ['POrder']
@Search.searchable: true
define view entity ZT_I_PurchaseOrders
  as select from zpoheader_db
  association [1..*] to ZT_I_PurchaseItems as _Items        on $projection.POrder = _Items.PurchaseOrder
  association [1..*] to ZT_I_OrderTypeText as _OrderType    on $projection.OrderType = _OrderType.OrderType
  association [1]    to zt_i_supplier      as _SupplierData on $projection.Supplier = _SupplierData.Supplierid
{
      @UI.facet: [
            {
            id: 'Collection',
            purpose: #STANDARD,
            type:#COLLECTION,
            label: 'General Information',
            position: 10
            },
            { id: 'GeneralInfo',
            parentId: 'Collection',
            purpose:  #STANDARD,
            type:     #FIELDGROUP_REFERENCE,
            label:    'Basic Data',
            position: 10 ,
            targetQualifier: 'GeneralIdentGroup'
            },
            {
            id:'OrgData',
            parentId: 'Collection',
            type:#FIELDGROUP_REFERENCE,
            purpose: #STANDARD,
            label: 'Organization',
            targetQualifier: 'OrgDataFiledGroup',
            position: 20
            },
            {
            id:'FurtherData',
            parentId: 'Collection',
            type:#FIELDGROUP_REFERENCE,
            purpose: #STANDARD,
            label: 'Further Details',
            targetQualifier: 'FurtherDataFiledGroup',
            position: 30
            },
            {
            id:'POItems',
            purpose: #STANDARD,
            type: #LINEITEM_REFERENCE,
            position: 20,
            targetElement: '_Items',
            label: 'Items'            },

            {
            id:'Supplier',
            purpose: #STANDARD,
            type: #IDENTIFICATION_REFERENCE,
            position: 30,
            targetElement: '_SupplierData',
            label: 'Suplier Contact Info'

            },
            {id: 'Attachment',
            label: 'Attachment(Sample)',
            position: 40,
            type:#IDENTIFICATION_REFERENCE,
            targetQualifier: 'Sample',
            purpose: #STANDARD

            },
        {
        id:'Header',
        purpose:#HEADER,
        type:#DATAPOINT_REFERENCE,
        targetQualifier: 'OrderDate',
        position: 10
        },
        {
        id:'Header2',
        purpose:#HEADER,
        type:#DATAPOINT_REFERENCE,
        targetQualifier: 'OrderStatus',
        position: 20

        },
        {
        id:'Header3',
        purpose:#HEADER,
        type:#DATAPOINT_REFERENCE,
        targetQualifier: 'OrderNetValue',
        position: 30

        }

              ]
      @UI: {
      lineItem: [ { position: 10, label: 'Purchase Order' ,importance: #HIGH },
      {type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'manage' } ],
      fieldGroup:[ { position: 10, label: 'Purchase Order',qualifier: 'GeneralIdentGroup' } ],
      selectionField: [{ position: 10 }]}
      @ObjectModel.text.element: ['PurchaseDescription']
      @Search.defaultSearchElement: true
      @Consumption.semanticObject: 'PurchaseOrder'
      
      
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZT_Purchase_Order_VH',element: 'POrder' } }]
  key po_order                                               as POrder,
      @Search.defaultSearchElement: true
      @Search. fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      po_desc                                                as PurchaseDescription,
      @Semantics.imageUrl: true
      imageurl                                               as ImageURL,

      @UI: {
      lineItem: [ { position: 20, label: 'Order Type',importance: #HIGH } ],
      fieldGroup:[ { position: 20, label: 'Order Type',qualifier: 'GeneralIdentGroup' } ],
      selectionField: [{ position: 20 }] }
      @ObjectModel.text.association: '_OrderType'
      @ObjectModel.text.control: #ASSOCIATED_TEXT_UI_HIDDEN
      po_type                                                as OrderType,

      //------------------------------------------------------------
      //sample fields for Data points (Virutal, do not take these seriously )
      @UI.dataPoint:{title: 'Status',qualifier: 'OrderStatus',criticality: 'Criticality'}
      @UI: {
      lineItem: [ { position: 70, label: 'Approval Status',importance: #HIGH,criticality: 'Criticality' } ],
      fieldGroup:[ { position: 30, label: 'Approval Status',qualifier: 'GeneralIdentGroup' } ] }
      case
      when po_order = '0000001000' then 'In Approval'
      when po_order = '0000001001' then 'Rejected'
      else 'Sent'
      end                                                    as Status,

      @UI.dataPoint:{title: 'Net Value',qualifier: 'OrderNetValue',criticality: 'Criticality'}
      @UI: {
      lineItem: [ { position: 30, label: 'Net Value',importance: #LOW,criticality: 'Criticality' } ],
      fieldGroup:[ { position: 30, label: 'NetValue',qualifier: 'GeneralIdentGroup' } ] }
      case
      when po_order = '1000' then '500,00 EUR'
      when po_order = '1001' then '1000,00 EUR'
      else '5000,00 EUR'
      end                                                    as NetValue,

      case when po_order = '0000001000' then 03
        when po_order = '0000001001' then 01
        when po_order = '0000001002' then 03
        when po_order = '0000001003' then 01
        when po_order = '0000001004' then 03
      else 02 end                                            as Criticality,
      //------------------------------------------------------------
      _OrderType[1:Language=$session.system_language  ].Text as OrderTypeDesc,

      @UI.fieldGroup: [{ position: 10, label: 'Company Code',qualifier: 'OrgDataFiledGroup' }]
      comp_code                                              as CompanyCode,
      @UI: {
      fieldGroup:[ { position: 20, label: 'Purchase Group',qualifier: 'OrgDataFiledGroup' } ] }
      po_org                                                 as PurchaseOrg,

      @UI: {
       lineItem: [ { position: 50, label: 'Supplier',importance: #HIGH ,type:#AS_CONTACT,
       value: '_SupplierData' } ],
       fieldGroup:[ { position:50, label: 'Supplier',type:#AS_CONTACT,
       value: '_SupplierData',qualifier: 'GeneralIdentGroup'  } ],
       selectionField: [{ position: 30 }] }
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZT_Supplier_VH',element: 'Supplierid' } } ]
      supplier                                               as Supplier,
      @UI:{lineItem: [ { position: 60, label: 'Created By',importance: #HIGH}],
      fieldGroup:[ { position: 10, label: 'Created By',qualifier: 'FurtherDataFiledGroup' } ],
      selectionField: [{ position: 40 }] }

      create_by                                              as CreateBy,

      @UI.fieldGroup:[ { position: 20, label: 'Created By',qualifier: 'FurtherDataFiledGroup' } ]
      @UI.dataPoint:{qualifier: 'OrderDate',title: 'Purchase Order Date:'}
      @UI.lineItem: [{ position: 80, label: 'Order Date' }]
      created_date_time                                      as CreatedDateTime,

      _Items,

      @Consumption.filter.hidden
      @Search.defaultSearchElement: true

      _SupplierData,
      _OrderType
}
