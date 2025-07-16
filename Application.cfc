<cfcomponent output="false">
    <cfset this.name = "RestAPIApp">
    <cfset this.applicationTimeout = createTimeSpan(1, 0, 0, 0)>
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>
    <cfset this.mappings["/api"] = expandPath("./api")>

    <cfsetting showDebugOutput="true">
    <cfset this.showDebugOutput = true>

    <cfset this.restSettings = {
        cfclocation = "api",
        restEnabled = true,
        restPath = "/rest/api"
    }>
</cfcomponent>
