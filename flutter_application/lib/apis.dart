// Define Apis Here
const String baseUrl = 'http://192.168.109.1:8082/api';
const String LOGIN_API = baseUrl + '/login';

// user
const String USER_REQUEST_BASE = baseUrl + '/user';
const String USER_CREATE = USER_REQUEST_BASE + '/create';
const String USER_GET = USER_REQUEST_BASE + '/get';

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
const String EXPENSES_GROUP_GET_GROUP_DETAILS =
    EXPENSES_GROUP_REQUEST_BASE + '/get-group-details';

// user-expenses-group
const String USER_EXPENSES_GROUP_REQUEST_BASE =
    baseUrl + '/user-expenses-group';
const String USER_EXPENSES_GROUP_READ =
    USER_EXPENSES_GROUP_REQUEST_BASE + '/read';
const String USER_EXPENSES_GROUP_ADD_USER =
    USER_EXPENSES_GROUP_REQUEST_BASE + '/add-user';

// itemization
const String ITEMIZATION_REQUEST_BASE = baseUrl + '/itemization';
const String ITEMIZATION_ADD = ITEMIZATION_REQUEST_BASE + '/add';
const String ITEMIZATION_READ = ITEMIZATION_REQUEST_BASE + '/read';
const String ITEMIZATION_UPDATE = ITEMIZATION_REQUEST_BASE + '/update';

// transaction-history
const String TRANSACTION_HISTORY_REQUEST_BASE =
    baseUrl + '/transaction-history';
const String TRANSACTION_HISTORY_CREATE =
    TRANSACTION_HISTORY_REQUEST_BASE + '/create';
const String TRANSACTION_HISTORY_READ =
    TRANSACTION_HISTORY_REQUEST_BASE + '/read';

// activity
const String ACTIVITY_REQUEST_BASE = baseUrl + '/activity';
const String ACTIVITY_READ = ACTIVITY_REQUEST_BASE + '/read';

// p2p-setup
const String P2P_SETUP_REQUEST_BASE = baseUrl + '/p2p-setup';
const String P2P_SETUP_APPLY = P2P_SETUP_REQUEST_BASE + '/apply';
const String P2P_SETUP_FIND_ALL = P2P_SETUP_REQUEST_BASE + '/find-all';