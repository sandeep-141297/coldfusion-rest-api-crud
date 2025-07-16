<cfcomponent>

    <cffunction name="getConnection" access="public" returnType="any">
        <cfset var conn = createObject("java", "coldfusion.server.ServiceFactory")
                    .getDataSourceService().getDataSource("usercrud")>
        <cfreturn conn>
    </cffunction>

</cfcomponent>
