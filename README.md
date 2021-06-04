# HANDY ecosystem

👋 Hi, here is the #team2 implementation folder about the **Digital Innovation Lab** course at Polimi.

## Folder Structure

### 📱 handy_app
Here, inside /handy subfolder there is all the *flutter* application for the management end promotion of university events
    **Relevant files**
- `lib/views` contains all dart code for the flutter view screens
- `lib/services` contains all service logic to call the backend endpoints
- `lib/models` contains the model to valdiate the response of endpoints
- `assets` contains the static files. Mainly images and icons

### 🧠 handy_be
Here is the express nodejs backend services to serve the mobile application.
    **Relevant files**
- `routes/index.js` is the entry point for the routes and switch to the right function to call based on the called path
- `routes/events-api.js` contains the core logic of the backend, the queries to the database and the request and response management
- `routes/recsys.js` contains all the logic about the events recommendation system handled by getAll() function
            
### 💾 mongodb-documents
Here are the json file exported from the mongodb after populating it

### 🚀 handy-postman-collection.json
Here are the json file exported from postman. It contains the structure and documentaiton about our REST API
