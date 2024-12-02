import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../core/enum/language.dart';
import '../features/user_features/home/presentation/view/widgets/company_home_view.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'You can login with new password now':
              "يمكنك تسجيل الدخول الان بكلمة السر الجديدة",
          "Home": "الرئيسية",
          "calculator": "الحاسبة",
          "Verification code": "كود التفعيل",
          "Track Order": "تتبع الشحنة",
          "Please Complete Your Profile": "برجاء استكمال البيانات الشخصية",
          "Our Sponsored Companies": "شركاتنا الاكثر تقييما",
          "No Companies right now.!": "لا يوجد شركات ف الوقت الحالى",
          "menu": "المزيد",
          "Less": "اخفاء",
          "Ok": "حسنا",
          'Track': "متابعة",
          "Chats": "المحادثات",
          "Message": "محادثة",
          "Send Message": "ارسال رسالة",
          "Close": "اغلاق",
          'Language':"اللغة",
          'Settings':"الاعدادات",
          'Logout':"تسجيل خروج",
          'Who Are We':"من نحن",
          'Privacy Policy':"سياسات الخصوصية",
          'Dates': "التقويم",
          "Follow orders": "تتبع الشحنة",
          "Skip": "تخطى",
          "Register as new company": "تسجيل شركة جديدة",
          "Rate submitted successfully":"تم ارسال التقييم بنجاح",
          "Rate :":"التقييم :",
          "Shipping countries": "دول الشحن",
          "Shipment images": "صور الشحنة",
          "Select shipping methods": "اختر النشاط",
          "Select shipping countries": "اختر الدولة",
          "Personal license image": "صورة بطاقة الهوية للمالك",
          "Browser Files": "تصفح الملفات",
          "Shipping type": "نوع النشاط",
          "Company logo": "لوجو الشركة",
          "Company cover": "غلاف الشركة",
          "Manager name": "اسم المسئول",
          "More": "المزيد",
          "Official license image": "وثيقة الرخصة التجارية",
          "Continue as guest": "الاستمرار كضبف",
          "let's get start": "هيا بنا لنبدأ",
          "Repayment period": "فترة السداد",
          "No Installment right now.!": "لا يوجد اقساط الان",
          "Shipments": "الشحنات",
          "Likes": "الاعجابات",
          "Ratings": "التقييمات",
          "Sponsors ": "اعلانات ",
          "About company": "معلومات عن الشركة",
          "Users's opinions": "اراء بعض العملاء",
          "Order": "طلب شحن",
          "Follow": "متابعة",
          "Select service": "اختر الخدمة",
          "Shipment details": "وصف الشحنة",
          "Editing field": "حقل النصوص",
          "Order details": "وصف الشحنة",
          "Expected price": "السعر المتوقع",
          "shipment date": "تاريخ التوصيل",
          "shipment price": "سعر التوصيل",
          "Sender name": "اسم الراسل",
          "Sender country": "دولة الراسل",
          "Sender government": "محافظة الراسل",
          "Cairo": "القاهره",
          "Egypt": "مصر",
          "User": "اسم المستخدم",
          "Local shipping": "شحن محلى",
          "Global shipping": "شحن دولى",
          "sender number": "رقم الراسل",
          "Shipping address": "عنوان الشحنة",
          "Delivery country": "دولة التوصيل",
          "Delivery government": "محافظة التوصيل",
          "delivery address": "عنوان التوصيل",
          "Receiver name": "اسم المستقبل",
          "receiver number": "رقم المستقبل",
          'please select country': "يجب اختيار دولة",
          "Arabic company name": "اسم الشركة بالعربية",
          "English company name": "اسم الشركة بالانجليزية",
          "License number": "رقم الرخصة التجارية",
          "Company description": "وصف الشركة",
          'Register new company': "تسجيل شركة جديدة",
          ValidationMessage.email: "من فضلك ادخل بريد الكتروني صحيح",
          ValidationMessage.required: "حقل مطلوب",
          ValidationMessage.number: "ارقام فقط",
          ValidationMessage.minLength: "اقل من المطلوب",
          ValidationMessage.maxLength: "اكثر من المطلوب",
          ValidationMessage.mustMatch: "كلمتا السر غير متطابقتين",
          "card holder": "اسم صاحب الحساب",
          "available fund programs": "برامج التمويل المتاحة",
          "order number": "الشحنة رقم",
          "Notifications": "التنبيهات",
          "your account is not active right now":
              "حسابك غير مفعل في الوقت الحالي",
          "Welcome, ": "حياك, ",
          "seen": 'مقرؤة',
          "unseen": "غير مقرؤة",
          "we wish you a happy day 👋": "نتمني لك يوما سعيدا 👋",
          "official contracts": "العقود الرسمية",
          "signature": "الامضاء",
          "bank name": "اسم البنك",
          "Profile": "الحساب",
          "Save": "حفظ",
          "select your bank": "اختار البنك",
          "Personal info": "بيانات شخصية",
          "additional info": "بيانات الاضافية",
          "gender": 'الجنس',
          "address": "العنوان",
          "birthday": "تاريخ الميلاد",
          "next": "التالى",
          "monthly_payment": "القسط الشهري",
          "details": "تفاصيل",
          "apply": "تقديم الطلب",
          "personal info": "بيانات شخصية",
          "total": "الإجمالي",
          "bank info": "بيانات البنك",
          "first name": "الاسم الاول ",
          "last name": "الاسم الاخير ",
          "Email": "البريد الالكتروني",
          "Orders": "الشحنات",
          "Support": "الدعم",
          "email span": " ( صالح لاستقبال الرسائل ) *",
          "account number or IBAN": "رقم الحساب او ال IBAN ",
          "phone number": "رقم الهاتف ",
          "Program details": "تفاصيل البرنامج",
          "payment length": "فترات السداد",
          "available banks": "البنوك المتاحة",
          "required papers": "الاوراق المطلوبة",
          "proceed to order": "تقديم الطلب",
          "front id photo": "الصورة الوجه الامامي للهوية",
          "back id photo": "الصورة الوجه الخلفى للهوية",
          "download_info":
              "يقبل بجميع صيغ الصور والملفات ولا تزيد المساحة عن 10 MB",
          "please upload the required files": "برجاء رفع الملف المطلوب",
          "back": "السابق",
          "Sign": "توقيع",
          "clear": "حذف",
          "Male": "ذكر",
          "Female": "أنثي",
          "Options": "القائمة",
          "Log out": "تسجيل الخروج",
          "customer service": "الدعم",
          "language": "اللغة",
          "submit": "تأكيد",
          "filter": "الفلترة",
          "order view": "الترتيب",
          "please complete your profile": "برجاء استكمال البيانات الشخصية",
          "program type": "نوع البرنامج",
          "done": "تم",
          "paid": "مدفوع",
          "Welcome,we are happy to see you again 👋":
              'اهلا بك, مسرورون لرؤيتك مرة اخري 👋',
          "Login": "تسجيل الدخول",
          "Phone number": "رقم الهاتف",
          "Password": "كلمة المرور",
          "We are happy for your trust": "سعداء لثقتك",
          "in the name of the application": " باسم التطبيق",
          "and solutions": '  والحلول الجديدة 👋',
          "Forget Password": "هل نسيت كلمة المرور؟",
          "Or Login with fingerprint": "او باستخدام البصمة",
          "Don't have an account? ": "ليس لديك حساب؟ ",
          "Create account": "انشاء حساب",
          "Already have an account? ": "لديك حساب؟ ",
          "Check phone number": "تأكيد الهاتف",
          "we will send you otp message":
              "سيتم اراسال رمز تأكيدي للرقم المدخل مسبقا ",
          'Verification': "تحقق",
          "Authenticate To Login": "المصادقة لتسجيل الدخول",
          'Resend': 'اعادة ارسال الرمز',
          "fingerprint": "البصمة",
          "Authenticate To Enable FingerPrint": "المصادقة لتفعيل البصمة",
          "Activate": "تفعيل البصمة",
          "Complete data": "استكمال البيانات",
          "Create password": "تسجيل دخول",
          "password": " كلمة السر",
          "new password": " كلمة السر الجديدة",
          "confirm password": "تاكيد كلمة السر",
          "retrieve your account": "استعادة حسابك",
          "confirm new password": "تاكيد كلمة السر الجديدة",
          "Payment Period": "فترة السداد",
          "interest": "الفائدة",
          "Verify": "تأكيد",
          "Forget password": "نسيت كلمة المرور",
          "Enter amount": "ادخل المبلغ",
          "interest_calculator": "حاسبة القروض",
          "Amount": "المبلغ",
          "KWD": "دينار كويتي",
          "SR": "ريال",
          "from": "من",
          "to": "الى",
          "Search": "البحث",
          "Request order": "طلب شحنة",
          "not_paid": "لم يتم الدفع",
          "Companies Sponsors": "اعلانات بعض الشركات",
          "Shipping companies": "شركات الشحن",
          "Verification completed successfully, complete the following information data":
              "تم التحقق بنجاح, قم باستكمال البيانات التالية",
          "please enter your number to send a verification code and retrieve your account data":
              "ادخل رقم الهاتف الخاص بك ليتم ارسال رمز التحقق واستعادة بيانات حسابك.",
          'oldest': 'الاقدم',
          "Calender": "الأجندة",
          "Installment": "الأقساط",
          "My Installment": "أقساطي",
          'newest': 'الاحدث',
          'all': 'الكل',
          'asc': 'الاقدم',
          'desc': 'الاحدث',
          "Months": "شهر",
          "There is no history to show": "لا يوجد تسجيلات للعرض",
          "receiver area": "منطقة المستقبل",
          "sender area": "منطقة الراسل",
          "History": "طلبات تم تأكيدها",
          "Pre order": "الطلبات المسبقة",
          Language.arabic.name: "العربية",
          Language.english.name: "English",
          FilterTypes.top.name: "الاعلى تقييما",
          FilterTypes.bottom.name: "الاقل تقييما",
          "You have followed the company successfully":
              "لقد تابعت هذى الشركة بنجاح",
          "You have un followed the company successfully":
              "لقد الفيت متابعة هذى الشركة بنجاح",
          "Shipping Options": "خدمات الشحن",
          'Press again to exit': "اضفط مجددا للخروج",
          "No Notifications right now.!": "لا يوجد تنبيهات فى الوقت الحالى",
          "No orders right now.!": "لا يوجد طلبات فى الوقت الحالى",
          "are you sure you want to cancel order?":
              "هل انت متأكد من الغاء الطلب؟",
          "Cancel": "الغاء",
          "Confirm": "تأكيد",
          'Support email': "ايميل الدعم",
          "what's app number for calling support":
              "رقم الهاتف للوتساب والاتصال بالدعم",
        },
        'en': {
          "history": "History",
          "monthly_payment": "Monthly Installment",
          ValidationMessage.email: "Not a valid e-mail",
          ValidationMessage.required: "Required field",
          ValidationMessage.number: "Numbers only",
          "total": "Total",
          "required papers": "Required Papers",
          ValidationMessage.minLength: "Less than required",
          ValidationMessage.maxLength: "More than required",
          ValidationMessage.mustMatch: "Two passwords is not identical",
          Language.arabic.name: "العربية",
          Language.english.name: "English",
          "Repayment period": "Repayment period",
          "interest_calculator": "Interest Calculator",
          'oldest': 'Oldest',
          'newest': 'Newest',
          "language": "Language",
          "No Installment right now.!": "No Installment right now !",
          "paid": "Paid",
          "not_paid": "Not Paid",
          'asc': 'Asc',
          "customer service": "Customer Service",
          "filter": "Filter",
          'desc': 'Desc',
          "done": "Done",
          "Notifications": "Notifications",
          "Program details": "Program Details",
          'all': 'All',
          "please complete your profile": "Please complete your profile",
          "proceed to order": "Proceed to Order",
          "your account is not active right now":
              "Your Account Is Not Active Right Now",
          "available fund programs": "Available Fund Programs",
        }
      };
}

class FilterAttributes {
  final String key;
  final dynamic value;
  final String title;

  const FilterAttributes(
      {required this.key, required this.title, required this.value});
}
