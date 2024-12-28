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

// expenses-group
const String EXPENSES_GROUP_REQUEST_BASE = baseUrl + '/expenses-group';
const String EXPENSES_GROUP_CREATE = EXPENSES_GROUP_REQUEST_BASE + '/create';
const String EXPENSES_GROUP_UPDATE_TO_STARTED =
    EXPENSES_GROUP_REQUEST_BASE + '/update-to-started';
const String EXPENSES_GROUP_UPDATE_TO_CLOSED =
    EXPENSES_GROUP_REQUEST_BASE + '/update-to-closed';

// user-expenses-group
const String USER_EXPENSES_GROUP_REQUEST_BASE = baseUrl + '/user-expenses-group';
const String USER_EXPENSES_GROUP_READ = USER_EXPENSES_GROUP_REQUEST_BASE + '/read';
const String USER_EXPENSES_GROUP_ADD_USER = USER_EXPENSES_GROUP_REQUEST_BASE + '/add-user';

