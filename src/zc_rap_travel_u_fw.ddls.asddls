@EndUserText.label: 'Travel data projection Unmanaged FW'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_RAP_Travel_U_FW as projection on ZI_RAP_TRAVEL_U_FW {
    key TravelId,
    @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency', element: 'AgencyID' } } ]
    AgencyId,
    @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID' } } ]
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } } ]
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_BOOKING_U_FW,
    _Currency,
    _Customer
}
