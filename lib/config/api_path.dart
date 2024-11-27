abstract class ApiPath {
  static const baseurl = 'https://taisser.onclick-eg.com/api/v1/';
  static const taiseerBaseurl = 'https://taisser.onclick-eg.com/api/v1/';
  // static const baseurl = 'http://loan.test/api/';
  static const uploadPath = 'https://taisser.onclick-eg.com/api/v1/uploads/topics/';
  static const uploadPath2 = 'https://taisser.onclick-eg.com/api/v1/uploads/companies/';
  static const filteredCompanies = 'getCompanies';
  static const companyDetails = 'getCompaniesDetails';
  static const followedCompany = 'storeFollower';
  static const support = 'website/contacts';
  static const checkPhone = 'otpCreate';
  static const sendOTP = 'resendOtp';
  static const login = 'login';
  static const userRegister = 'register';
  static const updateProfile = 'updateProfile';
  static const getShipments = 'getShipments';
  static const submitShipment = 'storeShipment';
  static const getChats = 'getChats';
  static const getMessages = 'getMessages/';
  static const storeMessage = 'storeMessage';
  static const user = 'userProfile/';
  static const countries = 'getCountryWithCity';
  static const upload = 'upload/file';


  static const changePassword = 'forget/password/change/password';
  static const forgetPassword = 'forget/password';
  static const notifications = 'notafication/all/';
  static const seen = 'seen/';
  static const loans = 'programs';
  static const installment = 'order/installments';
  static const validateOTPForgetPassword = 'forget/password/verifyOtp';
  static const verifyOTP = 'verify-otp';
  static const verifyForRegister = 'verifyOtp/For/Register';
  static const storeOrder = 'store/order';
  static const lastOrder = 'all/orders/last';
  static const allOrders = 'all/orders';
  static const deleteOrder = 'remove/order';
  static const filter = 'filter';
}
