class ApiEndPoints {
  static const String servergUrl = 'https://devicedoctors.in/api/';
  final String kycUpdate = 'homeservices/vendor/register/update_kyc';
  final String registration_endpoint = "homeservices/vendor/Register";
  final String categories_endpoint = "homeservices/vendor/categories";
  final String otp_endpoint = "homeservices/vendor/verify_otp";
  final String resend_otp_endpoint = "homeservices/vendor/login/resend_otp";
  static const imageUploadService = 'homeservices/vendor/register/image_upload';
  final String update_profile_image_endpoint =
      "homeservices/vendor/profile_image";
  final String update_bank_details_endpoint =
      "homeservices/vendor/Bank_details/add";
  final String get_bank_details_endpoint = "homeservices/vendor/Bank_details";
  final String profile_verification_endpoint =
      "homeservices/vendor/register/validate_details";
  final String login_endpoint = "homeservices/vendor/login";
  final String update_token_endpoint = "homeservices/vendor/update_token";
  final String update_status_endpoint = "homeservices/vendor/update_status";
  final String profile_fetch_endpoint = "homeservices/vendor/profile";
  final String orders_fetch_endpoint = "homeservices/vendor/orders";
  final String orders_details_endpoint = "homeservices/vendor/orders/view";
  final String all_orders_endpoint = "homeservices/vendor/all_orders";
  final String payouts_endpoint = "homeservices/vendor/payouts";
  final String payouts_details_endpoint = "homeservices/vendor/payouts/view";

  final String accept_order_endpoint =
      "homeservices/vendor/orders/accept_order";
  final String reject_order_endpoint =
      "homeservices/vendor/orders/reject_order";
  final String reached_location_endpoint =
      "homeservices/vendor/orders/reached_location";
  final String update_profile_endpoint =
      "homeservices/vendor/profile/update_profile";
  final String send_quote_endpoint =
      "homeservices/vendor/orders/send_quotation";
  final String add_quote_endpoint = "homeservices/vendor/orders/add_quotation";
  final String verify_pin_endpoint = "homeservices/vendor/orders/validate_pin";
  final String complete_order_endpoint =
      "homeservices/vendor/orders/complete_service";

  final String orders_count_endpoint =
      "homeservices/vendor/orders/orders_count";

  final String services_list_endpoint = "homeservices/vendor/services";
  final String update_service_status_endpoint =
      "homeservices/vendor/services/update_service";

  final String ratings_endpoint = "homeservices/vendor/rating";
  final String logout_endpoint = "homeservices/vendor/logout";

  final String cod_cash_endpoint = "homeservices/vendor/cod_cash";

  final String tips_endpoint = "homeservices/vendor/orders/vendor_tips";
}
