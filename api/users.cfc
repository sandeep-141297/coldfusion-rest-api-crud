<cfcomponent rest="true" restpath="users" output="false">

    <!--- List All Users --->
    <cffunction name="getUsers" access="remote" returnType="array" httpMethod="GET" restPath="">
        <cftry>
            <cfquery name="users" datasource="usercrud">
                SELECT * FROM users
            </cfquery>

            <!--- Convert query to array of structs --->
            <cfset var result = []>
            <cfloop query="users">
                <cfset row = {}>
                <cfloop list="#users.columnList#" index="col">
                    <cfset row[col] = users[col][currentRow]>
                </cfloop>
                <cfset arrayAppend(result, row)>
            </cfloop>

            <cfreturn result>
            
        <cfcatch>
            <cfreturn { "error": cfcatch.message, "detail": cfcatch.detail }>
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- Get One User --->
    <cffunction name="getUser" access="remote" returnType="struct" httpMethod="GET" restPath="profile/{id}">
        <cfargument name="id" type="numeric" required="true" restargsource="path">
        <cfquery name="user" datasource="usercrud">
            SELECT * FROM users WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif user.recordCount>
            <cfreturn user.getRow(1)>
        <cfelse>
            <cfreturn {error="User not found."}>
        </cfif>
    </cffunction>

    <!--- Create User --->
    <cffunction name="createUser" access="remote" returnType="any" httpMethod="POST" restPath="create">
        <cftry>
            <cfset var body = deserializeJson(toString(getHttpRequestData().content))>

            <cfquery datasource="usercrud">
                INSERT INTO users (name, email, phone)
                VALUES (
                    <cfqueryparam value="#body.name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.phone#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>

            <cfreturn { success=true, message="User created successfully" }>

        <cfcatch>
            <cfreturn { error=true, message=cfcatch.message, detail=cfcatch.detail }>
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- Update User --->
    <cffunction name="updateUser" access="remote" returnType="any" httpMethod="PUT" restPath="update/{id}">
        <cfargument name="id" type="numeric" required="true" restargsource="path">
        <cftry>
            <cfset var body = deserializeJson(toString(getHttpRequestData().content))>

            <cfquery datasource="usercrud">
                UPDATE users
                SET
                    name = <cfqueryparam value="#body.name#" cfsqltype="cf_sql_varchar">,
                    email = <cfqueryparam value="#body.email#" cfsqltype="cf_sql_varchar">,
                    phone = <cfqueryparam value="#body.phone#" cfsqltype="cf_sql_varchar">
                WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfreturn { success=true, message="User updated successfully" }>

        <cfcatch>
            <cfreturn { error=true, message=cfcatch.message, detail=cfcatch.detail }>
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- Delete User --->
    <cffunction name="deleteUser" access="remote" returnType="any" httpMethod="DELETE" restPath="delete/{id}">
        <cfargument name="id" type="numeric" required="true" restargsource="path">
        <cftry>
            <cfquery datasource="usercrud">
                DELETE FROM users WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn { success=true, message="User deleted successfully" }>
        <cfcatch>
            <cfreturn { error=true, message=cfcatch.message, detail=cfcatch.detail }>
        </cfcatch>
        </cftry>
    </cffunction>


</cfcomponent>
