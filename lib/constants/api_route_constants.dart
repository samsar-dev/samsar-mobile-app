//base url 
const String _baseUrl = "https://samsar-backend-production.up.railway.app";


//post route for login body requires username and password
const String loginRoute = "$_baseUrl/api/auth/login";

//post route to create a new user body requires name email username and password
const String registerRoute = "$_baseUrl/api/auth/register";

//post route to verify email verification code body requires code and email
const String verifyCodeRoute = "$_baseUrl/api/auth/verify-email/code";

//get route to get user details
dynamic userProfileRoute(String id) => "$_baseUrl/api/users/public-profile/$id";

//get route to get single listing details
dynamic individualListingDetailsRoute(String id) => "$_baseUrl/api/listings/public/$id";

//post route to add listing into favourites and it is protected route so it required access token
dynamic addListingToFavouriteRoute(String listingId) => "$_baseUrl/api/listings/saved/$listingId";

//get route to get all the favourite listing of users it is protected route so it required access token
const getFavouriteListingRoute = "$_baseUrl/api/listings/favorites";

//delete route to remove listing from favourite section it is protected rotute so needed to pass access token
dynamic removeFavouriteListingRoute(String listingId) => "$_baseUrl/api/listings/saved/$listingId";

//put request to update the user profile it is multipart request because we need to upload the image it is protected route
const updateProfileRoute = "$_baseUrl/api/users/profile";

//get route to get notificationd protected route
const getNotificationsRoute = "$_baseUrl/api/notifications";


//put route to edit listing
dynamic editListingRoute(String id) => "$_baseUrl/api/listings/$id";

//post create listing route to add listing it is protected route
dynamic createListingRoute = "$_baseUrl/api/listings";

//get route to fetch trending listings it is not protected
const String trendingListingRoute = "$_baseUrl/api/listings/trending";

//get route to fetch the settings of the user it is protected route
const String getSettingsRoute = "$_baseUrl/api/users/settings";

// Get all conversations for the user (protected)
const String getConversationsRoute = "$_baseUrl/api/messages/conversations";

//Create a new conversation (protected)
const String createConversationRoute = "$_baseUrl/api/messages/conversations";

//Delete a specific conversation by ID (protected)
dynamic deleteConversationRoute(String conversationId) => "$_baseUrl/api/messages/conversations/$conversationId";

//Send a message (general or listing-specific) (protected)
const String sendMessageRoute = "$_baseUrl/api/messages";

//Send a message related to a listing (protected)
const String sendListingMessageRoute = "$_baseUrl/api/messages/listings/messages";

// Get all messages in a conversation by ID (protected)
dynamic getMessagesRoute(String conversationId) => "$_baseUrl/api/messages/$conversationId";

//Delete a specific message by ID (protected)
dynamic deleteMessageRoute(String messageId) => "$_baseUrl/api/messages/$messageId";
