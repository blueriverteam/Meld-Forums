<cfcomponent displayname="MeldForumsBean" hint="Meld Event" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean" >
	<cfset variables.values	= StructNew() />

	<cffunction name="init" access="public" output="false" returntype="MeldForumsBean">
		<cfargument name="BeanFactory" type="any" required="true" />
		<cfargument name="$" type="any" required="true" />
		<cfargument name="ConferenceBean" type="any" required="false" default="" />
		<cfargument name="ForumBean" type="any" required="false" default="" />
		<cfargument name="ThreadBean" type="any" required="false" default="" />
		<cfargument name="Intercept" type="Array" required="false" default="#ArrayNew(1)#" />
		<cfargument name="Ident" type="String" required="false" default="" />
		<cfargument name="Action" type="String" required="false" default="" />

		<cfset var siteID					= $.event().getValue("siteID") />
		<cfset var sArgs					= StructNew() />
		<cfset var settingsBean				= "" />
		<cfset var themeBean				= "" />

		<cfset setConferenceBean( arguments.ConferenceBean ) />
		<cfset setForumBean( arguments.ForumBean ) />
		<cfset setThreadBean( arguments.ThreadBean ) />
		<cfset setIntercept( arguments.Intercept ) />
		<cfset setIdent( arguments.Ident ) />
		<cfset setAction( arguments.Action ) />

		<cfset variables.BeanFactory		= arguments.BeanFactory />
		<cfset variables.$					= arguments.$ />
		<cfset variables.displayRoot		= "" />
		<cfset variables.event				= arguments.$.event() />
		<cfset variables.siteID				= siteID />
		<cfset variables.pluginConfig		= variables.BeanFactory.getBean("MeldForumsManager").getPluginConfig() />
		<cfset variables.requestManager		= variables.BeanFactory.getBean("MeldForumsRequestManager") />
		<cfset variables.mmRBF				= variables.BeanFactory.getBean("mmResourceBundle") />

		<cfset variables.SettingsManager	= variables.BeanFactory.getBean("MeldForumsSettingsManager") />
		<cfset variables.themeService		= variables.BeanFactory.getBean("ThemeService") />

		<cfset setValue("mmRBF",mmRBF ) />

		<cfset sArgs.siteID					= siteID />
		<cfset settingsBean					= variables.SettingsManager.getSiteSettings( argumentCollection=sArgs ) />
		<cfset setValue("settingsBean",settingsBean ) />
		<cfset sArgs						= StructNew() />
		<cfreturn this/>
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="any" description="retrieves a forum user (userData)">
		<cfargument name="userID" type="string" required="true" />

		<cfreturn getUserCache().getUser( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getSettings" access="public" output="false" returntype="any">
		<cfreturn getValue("settingsBean") />
	</cffunction>

	<cffunction name="getTheme" access="public" output="false" returntype="any">
		<cfreturn getSettings().getThemeBean() />
	</cffunction>

	<cffunction name="getUserCache" access="public" output="false" returntype="any">
		<cfreturn getSettings().getUserCache() />
	</cffunction>

	<cffunction name="getMuraScope" access="public" output="false" returntype="any">
		<cfreturn variables.$ />
	</cffunction>

	<!--- ---------------------------------------------------------------------- --->
	<!--- MOVED --->

<!--- urls --->
	<cffunction name="getEditorAction" access="public" returntype="string" output="false">
		<cfargument name="section" type="string" required="true">
		<cfargument name="item" type="string" required="true">
		<cfargument name="useID" type="string" required="true">
		<cfset var rString = getForumWebRoot() & getUrlKey() & "#arguments.section#/#arguments.item#/#arguments.useID#/">
		<cfreturn rString>
	</cffunction>

	<cffunction name="getNewThreadAction" access="public" returntype="string" output="false">
		<cfargument name="forumID" type="string" required="true">
		<cfset var rString = "#getForumWebRoot()#newthread/#arguments.forumID#/" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getLogOutUrl" access="public" returntype="string" output="false">
		<cfset var rString = "#getForumWebRoot()#?display=logout" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getLogInUrl" access="public" returntype="string" output="false">
		<cfset var rString = "#getForumWebRoot()#?display=login" />
		<cfreturn rString>
	</cffunction>

	<cffunction name="getCurrentUser" access="public" returntype="any" output="false">
		<cfreturn variables.$.currentUser()>
	</cffunction>

	<cffunction name="getMuraScope" access="public" returntype="any" output="false">
		<cfreturn variables.$>
	</cffunction>

	<cffunction name="getLogInOutLink" access="public" returntype="string" output="false">
		<cfif variables.$.currentUser().isLoggedIn()>
			<cfreturn getLogOutLink()>
		<cfelse>
			<cfreturn getLogInLink()>
		</cfif>
	</cffunction>

	<cffunction name="getConferenceLink" access="public" returntype="string" output="false">
		<cfargument name="conferenceBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "c" & conferenceBean.getIDX() & "-" & conferenceBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getForumLink" access="public" returntype="string" output="false">
		<cfargument name="forumBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "f" & forumBean.getIDX() & "-" & forumBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getThreadLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & threadBean.getIDX() & "-" & threadBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getPostLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfargument name="postBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & threadBean.getIDX() & "-" & threadBean.getFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getLastPostLink" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "t" & postBean.getThreadIDX() & "-" & postBean.getThreadFriendlyName() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getProfileLink" access="public" returntype="string" output="false">
		<cfargument name="userBean" type="any" required="true">

		<cfset var rString = getForumWebRoot() & getUrlKey() & "profile/view/" & userBean.getUserID() />
		<cfreturn rString />
	</cffunction>

	<cffunction name="getThemeWebRoot" access="public" returntype="string" output="false">
		<cfreturn getPluginWebRoot() & "/themes/" & getTheme().getPackageName() & "/">
	</cffunction>

	<cffunction name="getThemeDirectory" access="public" returntype="string" output="false">
		<cfreturn getThemeRootDirectory() & getTheme().getPackageName()>
	</cffunction>

	<cffunction name="getThemeRootDirectory" access="public" returntype="string" output="false">
		<cfreturn "/" & variables.pluginConfig.getPackage() & "/themes/">
	</cffunction>

	<cffunction name="getForumWebRoot" access="public" returntype="string" output="false">
		<cfif not len(variables.displayRoot)>
			<cfset variables.displayRoot = $.getURLStem(siteID,$.event().getValue("currentFileName")) />
		</cfif>
		<cfreturn variables.displayRoot />
	</cffunction>
	
	<cffunction name="getPluginWebRoot" access="public" returntype="string" output="false">
		<cfreturn "#$.globalConfig().getContext()#/plugins/#variables.pluginConfig.getDirectory()#">
	</cffunction>

	<cffunction name="getUrlKey" access="public" returntype="string" output="false">
		<cfreturn "mf/">
	</cffunction>

<!---
	<cffunction name="getSiteWebRoot" access="public" returntype="string" output="false">
		<cfreturn "#$.globalConfig().getContext()#">
	</cffunction>
--->
<!--- links --->
	<cffunction name="getSubscribeLink" access="public" returntype="string" output="false">
		<cfargument name="id" type="any" required="true">
		<cfargument name="type" type="string" required="true">
		<cfargument name="isSubscribed" type="boolean" required="true">

		<cfset var link = "">
		<cfset var mode = "add">
		
		<!--- isn't group member --->
		<cfif not isLoggedIn()>
			<cfreturn "">
		</cfif>

		<cfif arguments.isSubscribed>
			<cfset mode = "remove">
		</cfif>
		<cfsavecontent variable="link"><cfoutput><a class="submit profile" href="#getForumWebRoot()##getUrlKey()#subscribe/#arguments.type#/#mode#/#id#/"><span>#variables.mmRBF.key('#mode#subscribe')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getProfilePanelLink" access="public" returntype="string" output="false">
		<cfset var link = "">

		<!--- isn't group member --->
		<cfif not isLoggedIn()>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit profile" href="#getForumWebRoot()##getUrlKey()#panel/view/"><span>#variables.mmRBF.key('profile')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getNewThreadLink" access="public" returntype="string" output="false">
		<cfargument name="forumBean" type="any" required="true">
		<cfset var link				 = "">

		<!--- isn't group member --->
		<cfif not CanUserCreateThread()>
			<cfreturn "">
		</cfif>
		<cfsavecontent variable="link"><cfoutput><a class="submit newthread" href="#getForumWebRoot()##getUrlKey()#thread/new/#arguments.ForumBean.getforumID()#/"><span>#variables.mmRBF.key('newthread')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getModeratePanelLink" access="public" returntype="string" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfset var link = "">

		<!--- isn't group member --->
		<cfif not UserHasModeratePermissions()>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit profile" href="#getForumWebRoot()#panel/moderate/#arguments.userID#/"><span>#variables.mmRBF.key('moderate')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getEditThreadLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link			= "">

		<!--- refuse if not editor AND not owner AND (owner AND locked) --->
		<cfif not CanUserEditThread(threadBean,arguments.threadBean.getUserID())>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link">
			<cfoutput><a class="submit editthread" href="#getForumWebRoot()##getUrlKey()#thread/edit/#arguments.threadBean.getThreadID()#/"><span>#variables.mmRBF.key('editthread')#</span></a></cfoutput>
		</cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getReplyPostLink" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">
		<cfargument name="doQuote" type="boolean" required="false" default="false">

		<cfset var link 		= "">
		<cfset var replyString	= "reply" />

		<cfif doQuote>
			<cfset replyString = "quote" />
		</cfif>		

		<cfif not canUserCreatePost(arguments.threadBean)>
			<cfreturn "">
		<cfelseif canUserCreatePost(arguments.threadBean) and isPostLocked(arguments.postBean) and isThreadLocked(arguments.threadBean)>
			<!--- in theory you could return a "disabled" button here --->
			<cfreturn "">
		<cfelse>
			<cfsavecontent variable="link"><cfoutput><a class="submit #replyString#post" href="#getForumWebRoot()##getUrlKey()#post/new/#arguments.threadBean.getThreadID()#/#arguments.postBean.getPostID()#/#doQuote#/"><span>#variables.mmRBF.key('#replyString#post')#</span></a></cfoutput></cfsavecontent>
			<!---<cfsavecontent variable="link"><cfoutput><a class="submit newpost" href="#getForumWebRoot()#newpost/#arguments.threadBean.getThreadID()#/#arguments.postBean.getPostID()#/"><span>#variables.mmRBF.key('quotepost')#</span></a></cfoutput></cfsavecontent>--->
		</cfif>

		<cfreturn link>
	</cffunction>

	<cffunction name="getNewPostLink" access="public" returntype="string" output="false">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link = "">

		<cfif not CanUserCreatePost(arguments.threadBean)>
			<cfreturn "">
		<cfelseif CanUserCreatePost(arguments.threadBean) and isThreadLocked(arguments.threadBean)>
			<!--- in theory you could return a "disabled" button here --->
			<cfreturn "">
		<cfelse>
			<cfsavecontent variable="link"><cfoutput><a class="submit newpost" href="#getForumWebRoot()##getUrlKey()#post/new/#arguments.threadBean.getThreadID()#/"><span>#variables.mmRBF.key('newpost')#</span></a></cfoutput></cfsavecontent>
		</cfif>

		<cfreturn link>
	</cffunction>

	<cffunction name="getSearchURL" access="public" returntype="string" output="false">

			<cfreturn "#getForumWebRoot()##getUrlKey()#search/">
	</cffunction>

	<cffunction name="getEditPostLink" access="public" returntype="string" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">
		<cfset var link			= "">

		<cfif not CanUserEditPost(argumentCollection=arguments)>
			<cfreturn "">
		</cfif>

		<cfsavecontent variable="link"><cfoutput><a class="submit editpost" href="#getForumWebRoot()##getUrlKey()#post/edit/#arguments.postBean.getPostID()#/"><span>#variables.mmRBF.key('editpost')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getLogOutLink" access="public" returntype="string" output="false">
		<cfset var link = "">
		<cfsavecontent variable="link"><cfoutput><a class="submit logout" href="#getLogOutUrl()#"><span>#variables.mmRBF.key('logout')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="getLogInLink" access="public" returntype="string" output="false">
		<cfset var link = "">
		<cfsavecontent variable="link"><cfoutput><a class="submit login" href="#getLogInUrl()#"><span>#variables.mmRBF.key('login')#</span></a></cfoutput></cfsavecontent>
		<cfreturn link>
	</cffunction>

	<cffunction name="setIntercept" access="public" returntype="void" output="false">
		<cfargument name="Intercept" type="array" required="true" />
		<cfset variables.instance['intercept'] = arguments.Intercept />
	</cffunction>
	<cffunction name="getIntercept" access="public" returntype="array" output="false">
		<cfreturn variables.instance.Intercept />
	</cffunction>

	<cffunction name="setIdent" access="public" returntype="void" output="false">
		<cfargument name="Ident" type="string" required="true" />
		<cfset variables.instance['ident'] = arguments.Ident />
	</cffunction>
	<cffunction name="getIdent" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Ident />
	</cffunction>

	<cffunction name="setAction" access="public" returntype="void" output="false">
		<cfargument name="Action" type="string" required="true" />
		<cfset variables.instance['action'] = arguments.Action />
	</cffunction>
	<cffunction name="getAction" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Action />
	</cffunction>

	<cffunction name="setConferenceBean" access="public" returntype="void" output="false">
		<cfargument name="ConferenceBean" type="any" required="true" />
		<cfset variables.instance['conferencebean'] = arguments.ConferenceBean />
	</cffunction>
	<cffunction name="getConferenceBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ConferenceBean />
	</cffunction>

	<cffunction name="setForumBean" access="public" returntype="void" output="false">
		<cfargument name="ForumBean" type="any" required="true" />
		<cfset variables.instance['forumbean'] = arguments.ForumBean />
	</cffunction>
	<cffunction name="getForumBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ForumBean />
	</cffunction>

	<cffunction name="setThreadBean" access="public" returntype="void" output="false">
		<cfargument name="ThreadBean" type="any" required="true" />
		<cfset variables.instance['threadbean'] = arguments.ThreadBean />
	</cffunction>
	<cffunction name="getThreadBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ThreadBean />
	</cffunction>

<!--- permission/evaluation --->
	<cffunction name="isLoggedIn" access="public" returntype="boolean" output="false">
		<cfreturn variables.$.currentUser().isLoggedIn()>	
	</cffunction>

	<cffunction name="userIsOwner" access="public" returntype="boolean" output="false">
		<cfargument name="userID" type="string" required="true">
		<cfreturn (variables.$.currentUser().getUserID() eq arguments.userID)>	
	</cffunction>

	<cffunction name="isThreadLocked" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfif threadBean.getIsClosed() or threadBean.getIsDisabled() or not threadBean.getIsActive() or threadBean.getIsAnnouncement()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="isPostLocked" access="public" returntype="boolean" output="false">
		<cfargument name="postBean" type="any" required="true">

		<cfif postBean.getIsDisabled() or not postBean.getIsActive()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="showInlineImages" access="public" returntype="boolean" output="false">
		<cfset var configurationBean = getConfigurationBean()>

		<!--- false if user is not moderator, not owner or owner and thread is closed  --->
		<cfif configurationBean.getdoInlineImageAttachments()>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="canUserCreateThread" access="public" returntype="boolean" output="false">
		<cfset var configurationBean = getConfigurationBean()>

		<!--- false if user is not moderator, not owner or owner and thread is closed  --->
		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() and not configurationBean.getDoClosed()>	
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="canUserEditThread" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() AND UserIsOwner(arguments.threadBean.getUserID()) AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="canUserCreatePost" access="public" returntype="boolean" output="false">
		<cfargument name="threadBean" type="any" required="true">

		<!--- false if user is not moderator, not owner or owner and post/thread is closed  --->
		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions() AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="canUserEditPost" access="public" returntype="boolean" output="false">
		<cfargument name="postBean" type="any" required="true">
		<cfargument name="threadBean" type="any" required="true">

		<cfif UserHasModeratePermissions()>
			<cfreturn true>
		<cfelseif UserHasContributePermissions()
			AND UserIsOwner(arguments.postBean.getUserID())
			AND not isPostLocked(arguments.postBean)
			AND not isThreadLocked(arguments.threadBean)>
			<cfreturn true>
		</cfif>

		<cfreturn false>
	</cffunction>
	
	<cffunction name="strip" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true">
		<cfargument name="stripHTML" type="boolean" required="false" default="true">
		<cfargument name="stripBBML" type="boolean" required="false" default="true">

		<cfset var sReturn = arguments.value>

		<cfif arguments.stripHTML>
			<cfset sReturn = rereplace(trim(sReturn),"<.[^<>]*>","","all")>
		</cfif>
		<cfif arguments.stripBBML>
			<cfset sReturn = rereplace(trim(sReturn),"\[.[^\[\]]*\]","","all")>
		</cfif>

		<cfreturn sReturn>
	</cffunction>
		
	<cffunction name="userHasReadPermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif isUserInRole("s2")>
			<cfset variables.instance.hasReadPermissions = true>
			<cfreturn true>
		<cfelseif isDefined("variables.instance.hasReadPermissions")>
			<cfreturn variables.instance.hasReadPermissions>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		</cfif>
		
		<cfif isSimpleValue( configurationBean )>
			<cfset variables.instance.hasReadPermissions = false>
			<cfreturn variables.instance.hasReadPermissions>
		</cfif>

		<cfset variables.instance.hasReadPermissions = getHasPermissions( configurationBean.getConfigurationID(),"read" )>

		<cfreturn variables.instance.hasReadPermissions>
	</cffunction>
		
	<cffunction name="userHasContributePermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif isUserInRole("s2")>
			<cfset variables.instance.hasContributePermissions = true>
			<cfreturn true>
		<cfelseif isDefined("variables.instance.hasContributePermissions")>
			<cfreturn variables.instance.hasContributePermissions>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		</cfif>
		
		<cfif isSimpleValue( configurationBean )>
			<cfset variables.instance.hasContributePermissions = false>
			<cfreturn false>
		</cfif>

		<cfset variables.instance.hasContributePermissions	= getHasPermissions( configurationBean.getConfigurationID(),"post" )>
		<cfreturn variables.instance.hasContributePermissions>
	</cffunction>

	<cffunction name="userHasModeratePermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>
		<cfset var configurationBean = getConfigurationBean()>

		<cfif isDefined("variables.instance.HasModeratePermissions")>
			<cfreturn variables.instance.HasModeratePermissions>
		</cfif>
		
		<cfif isUserInRole("s2")>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.hasModeratePermissions = true>
			<cfreturn true>
		<cfelseif isSimpleValue( configurationBean ) or not variables.$.currentUser().isLoggedIn()>
			<cfset variables.instance.hasModeratePermissions = false>
			<cfreturn false>
		</cfif>

		<cfset variables.instance.hasModeratePermissions = getHasPermissions( configurationBean.getConfigurationID(),"edit" )>
		<cfreturn variables.instance.hasModeratePermissions>
	</cffunction>

	<cffunction name="userHasFullPermissions" returntype="boolean" access="public" output="false">
		<cfset var hasPerm			 = false>

		<cfif isDefined("variables.instance.HasFullPermissions")>
			<cfreturn variables.instance.HasFullPermissions>
		</cfif>
		
		<cfif not variables.$.currentUser().isLoggedIn()>
			<cfset variables.instance.HasFullPermissions = false>
		<cfelseif isUserInRole("s2")>
			<cfset variables.instance.HasFullPermissions = true>
		<cfelseif getRequestManager().getHasFullPermissions(variables.$,variables.siteID)>
			<cfset variables.instance.HasFullPermissions = true>
		<cfelse>
			<cfset variables.instance.HasFullPermissions = false>
		</cfif>

		<cfreturn variables.instance.HasFullPermissions>
	</cffunction>

	<cffunction name="getHasPermissions" returntype="boolean" access="public" output="false">
		<cfargument name="configurationID" type="uuid" required="false" />
		<cfargument name="permType" type="string" required="false" default="read" />

		<cfset var sArgs	= StructNew() />
		<cfset sArgs.$					= variables.$ />

		<cfif StructKeyExists( arguments,"configurationID" ) and len( arguments.configurationID )>
			<cfset sArgs.configurationID	= arguments.configurationID />
		<cfelse>
			<cfset sArgs.configurationID	= getConfigurationBean().getConfigurationID() />
		</cfif>		
		<cfset sArgs.permType			= arguments.permType />
		
		<cfreturn getRequestManager().getHasPermissions( argumentCollection=sArgs )>
	</cffunction>

	<cffunction name="initConfiguration" access="public" returntype="any" output="false">
		<cfargument name="ConfigurationBean" type="any" required="true">

		<cfif hasConfiguration()>
			<cfreturn>
		</cfif>

		<cfset variables.ConfigurationBean = arguments.ConfigurationBean>
	</cffunction>
	<cffunction name="hasConfiguration" access="public" returntype="any" output="false">
		<cfif structKeyExists( variables,"ConfigurationBean" )>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="getConfigurationBean" access="public" returntype="any" output="false">
		
		<cfif not hasConfiguration()>
			<cfset initConfiguration( variables.BeanFactory.getBean("MeldForumsConfigurationManager").initConfiguration(variables.$) ) />
		</cfif>
		
		<cfreturn variables.ConfigurationBean>
	</cffunction>

	<cffunction name="getRequestManager" access="public" output="false" returntype="any">
		<cfreturn variables.RequestManager />
	</cffunction>

	<cffunction name="getVariables" access="public" output="false" returntype="struct">
		<cfreturn variables />
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.BeanFactory>
	</cffunction>
</cfcomponent>