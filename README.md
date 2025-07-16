# ColdFusion 2025 REST API Setup

A simple and clean RESTful API built in ColdFusion 2025 for user CRUD operations. Includes full setup, CFAdmin REST mapping, JSON endpoints, and Postman-ready testing.

This documentation explains the folder structure, ColdFusion Admin (CFAdmin) setup, and API usage for a ColdFusion RESTful application. This project uses a simple user CRUD API, built with ColdFusion 2025.

---

## 📂 Folder Structure

```
cf_rest_api/
├── Application.cfc        # Application config and REST setup
├── api/
│   └── users.cfc             # REST component for user CRUD operations
└── README.md              # Documentation
```

---

## 📊 Application.cfc Setup

```cfml
<cfcomponent output="false">
    <cfset this.name = "RestAPIApp">
    <cfset this.applicationTimeout = createTimeSpan(1, 0, 0, 0)>
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>
    <cfset this.mappings["/api"] = expandPath("./api")>

    <cfsetting showDebugOutput="true">
    <cfset this.showDebugOutput = true>

    <cfset this.restSettings = {
        cfclocation = "api",               // Folder where REST CFCs are located
        restEnabled = true,                // Enable REST for this app
        restPath = "/rest/api"             // REST base path
    }>
</cfcomponent>
```

---

## 🛋️ ColdFusion Admin (CFAdmin) Setup

### Step-by-step:

1. Go to ColdFusion Admin ([http://localhost:8500/CFIDE/administrator/](http://localhost:8500/CFIDE/administrator/))
2. Navigate to **Data & Services > REST Services**
3. Click **Register REST Service**
4. Fill in:

   * **REST Path Mapping**: `api`
   * **REST Directory**: Full path to `/api`, e.g.:

     ```
     D:\ColdFusion2025\cfusion\wwwroot\coldfusion-rest-api-crud\api
     ```
   * Click **Register**
5. After any code changes in `users.cfc`, always click **Refresh** icon to reload REST mappings.

---

## 🚀 REST API Endpoints

| Action      | Endpoint                       | Method | Description             |
| ----------- | ------------------------------ | ------ | ----------------------- |
| List users  | `/rest/api/users`              | GET    | Returns all users       |
| Get user    | `/rest/api/users/profile/{id}` | GET    | Returns one user by ID  |
| Create user | `/rest/api/users/create`       | POST   | Creates a new user      |
| Update user | `/rest/api/users/update/{id}`  | PUT    | Updates user data by ID |
| Delete user | `/rest/api/users/delete/{id}`  | DELETE | Deletes user by ID      |

---

## 📃 users.cfc Overview (1-liner per function)

### Header

```cfml
<cfcomponent rest="true" restpath="users" output="false">
```

### Functions

* `getUsers()` – Fetches and returns all users as array of structs
* `getUser()` – Returns single user by `id` (path param)
* `createUser()` – Creates a new user using JSON payload
* `updateUser()` – Updates user record by `id` with JSON data
* `deleteUser()` – Deletes user by `id`

Each function includes:

* `<cfheader name="Content-Type" value="application/json">` for clean JSON response
* `deserializeJson(toString(getHttpRequestData().content))` to parse input

---

## 📝 How to Use via Postman

### Get All Users

* `GET http://localhost:8500/rest/api/users`

### Get User by ID

* `GET http://localhost:8500/rest/api/users/profile/1`

### Create User

* `POST http://localhost:8500/rest/api/users/create`
* Headers:

  * `Content-Type: application/json`
* Body:

```json
{
  "name": "Sandeep",
  "email": "sandeep@example.com",
  "phone": "9999999999"
}
```

### Update User

* `PUT http://localhost:8500/rest/api/users/update/1`
* Headers:

  * `Content-Type: application/json`
* Body:

```json
{
  "name": "Updated Name",
  "email": "new@example.com",
  "phone": "9999999999"
}
```

### Delete User

* `DELETE http://localhost:8500/rest/api/users/delete/1`

---



