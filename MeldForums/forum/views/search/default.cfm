<cfsilent>
	<!--- headers --->
	<cfset local.sStr = "" />
</cfsilent><cfoutput>
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	<cfif local.rc.errors.hasErrors()>
		<cfsilent>
		<cfset local.sStr = "" />
		<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
		<cfset local.event.setValue('errors',rc.errors) />
		<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderErrors",local.event ) />
		</cfsilent>
		<cfif len(local.sStr)>
			#local.sStr#
		<cfelse>
			#view("global/inc_errors")#
		</cfif>
	</cfif>
	<cfsilent>
	<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
	<cfset local.sStr = "" />
	<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderThread",local.event ) />
	</cfsilent>
	<cfif len(local.sStr)>
		#local.sStr#
	<cfelse>
		<cfinclude template="#rc.MFBean.getThemeDirectory()#/templates/display/viewsearch.cfm">
	</cfif>
</div>	
<!--- end content --->
</cfoutput> 
<cfset request.layout = true>