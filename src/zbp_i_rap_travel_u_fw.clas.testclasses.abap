*"* use this source file for your ABAP unit test classes
CLASS ltcl_integration_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    CLASS-DATA:
      cds_test_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.
    METHODS:
      setup,
      teardown.
    METHODS:
      create_travel FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_integration_test IMPLEMENTATION.

  METHOD class_setup.
    cds_test_environment = cl_cds_test_environment=>create_for_multiple_cds(
      i_for_entities = VALUE #( ( i_for_entity = 'zi_rap_travel_u_fw' )
                                ( i_for_entity = 'zi_rap_booking_u_fw') )
                                ).
  ENDMETHOD.

  METHOD class_teardown.

  ENDMETHOD.

  METHOD create_travel.
    DATA(today) = cl_abap_context_info=>get_system_date(  ).
    DATA travels_in TYPE TABLE FOR CREATE zi_rap_travel_u_fw\\Travel.

    travels_in = VALUE #(  (  agencyid   = 070001 " Agency 070001 does not exist, Agency 1 does not exist
                            customerid = 1
                            begindate  = today
                            enddate    = today + 10
                            bookingfee = 30
                            totalprice = 330
                            currencycode = 'EUR'
                            description = |Test travel FW|
                        )  ).

    MODIFY ENTITIES OF zi_rap_travel_u_fw
      ENTITY Travel
        CREATE FIELDS ( AgencyId
                        CustomerId
                        BeginDate
                        EndDate
                        BookingFee
                        TotalPrice
                        CurrencyCode
                        Description
                        Status )
          WITH travels_in
      MAPPED DATA(mapped)
      FAILED DATA(failed)
      REPORTED DATA(reported).

    cl_abap_unit_assert=>assert_initial( failed-travel ).
    cl_abap_unit_assert=>assert_initial( reported-travel ).
    COMMIT ENTITIES.

    DATA(new_travel_id) = mapped-travel[ 1 ]-TravelId.

    SELECT * FROM zi_rap_travel_u_fw WHERE TravelId = @new_travel_id INTO TABLE @DATA(lt_travel).

    cl_abap_unit_assert=>assert_not_initial( lt_travel ).

    cl_abap_unit_assert=>assert_not_initial(
           VALUE #( lt_travel[ TravelId = new_travel_id ] OPTIONAL )
           ).

    cl_abap_unit_assert=>assert_equals(
           exp = 'N'
           act = lt_travel[ TravelID = new_travel_id ]-Status
           ).
  ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

  METHOD teardown.
    cds_test_environment->destroy(  ).
  ENDMETHOD.

ENDCLASS.
