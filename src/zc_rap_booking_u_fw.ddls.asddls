@EndUserText.label: 'Travel booking projection Unmanaged FW'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_BOOKING_U_FW as projection on ZI_RAP_BOOKING_U_FW {
    @Search.defaultSearchElement: true
    key TravelId,
    @Search.defaultSearchElement: true
    key BookingId,
    BookingDate,
    @Consumption.valueHelpDefinition: [{ 
                                         entity: { name:    '/DMO/I_Customer',
                                                   element: 'CustomerID' } 
                                      } ]
    CustomerId,
    @Consumption.valueHelpDefinition: [{
                                         entity: { name:    '/DMO/I_Carrier',
                                                   element: 'AirlineID' }
                                      } ]
    CarrierId,
    @Consumption.valueHelpDefinition: [{
                                         entity: { name:    '/DMO/I_Flight',
                                                   element: 'ConnectionID' },
                                         additionalBinding: [{
                                                               localElement: 'FlightDate',
                                                               element:      'FlighDate',
                                                               usage:        #RESULT },
                                                             { localElement: 'CarrierID',
                                                               element:      'AirlineID',
                                                               usage:        #RESULT },
                                                             { localElement: 'FlightPrice',
                                                               element:      'Price',
                                                               usage:        #RESULT },
                                                             { localElement: 'CurrencyCode',
                                                               element:      'CurrencyCode',
                                                               usage:        #RESULT      
                                                            }]
                                                            
                                      }]
    ConnectionId,
    FlightDate,
    FlightPrice,
    @Consumption.valueHelpDefinition: [{
                                         entity: { name:   'I_Currency',
                                                   element: 'Currency' } 
                                      }]
    CurrencyCode,
    /* Associations */
    _Carrier,
    _Connection,
    _Customer,
    _Flight,
    _Travel : redirected to parent ZC_RAP_Travel_U_FW
}
