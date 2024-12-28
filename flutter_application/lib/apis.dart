// Define Apis Here
const String baseUrl = 'http://192.168.109.1:8082/api';
const String LOGIN_API = baseUrl + '/login';

// user
const String USER_REQUEST_BASE = baseUrl + '/user';
const String USER_CREATE = USER_REQUEST_BASE + '/create';

// friends
const String FRIENDS_REQUEST_BASE = baseUrl + '/friends';
const String FRIENDS_CREATE = FRIENDS_REQUEST_BASE + '/add';
const String FRIENDS_READ = FRIENDS_REQUEST_BASE + '/get';

//emergency-request
const String EMERGENCY_REQUEST_BASE = '/protected/emergency-request';
const String EMERGENCY_REQUEST_CREATE_API =
    baseUrl + EMERGENCY_REQUEST_BASE + '/create';
const String EMERGENCY_REQUEST_READ_API =
    baseUrl + EMERGENCY_REQUEST_BASE + '/read-by-username';

//visitor-pass
const String VISITOR_PASS_REQUEST_BASE = '/protected/visitor-pass';
const String VISITOR_PASS_CREATE_API =
    baseUrl + VISITOR_PASS_REQUEST_BASE + '/create';
const String VISITOR_PASS_READ_API =
    baseUrl + VISITOR_PASS_REQUEST_BASE + '/read-by-username';

//announcement
const String NOTICE_REQUEST_BASE = '/protected/notice';
const String NOTICE_READ_API = baseUrl + NOTICE_REQUEST_BASE + '/read';

//statement
const String STATEMENT_REQUEST_BASE = '/protected/statement';
const String STATEMENT_READ_API =
    baseUrl + STATEMENT_REQUEST_BASE + '/read-by-username';

//payment
const String PAYMENT_REQUEST_BASE = '/protected/payment';
const String PAYMENT_CREATE_API = baseUrl + PAYMENT_REQUEST_BASE + '/create';
