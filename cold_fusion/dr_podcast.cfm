<cfset Podcast = {} />
<cfset emailToAddress = 'podcastadmin@daveramsey.com' />

<cffunction name="init" access="private" output="false">
	<cfparam name="url.dateoffset" default="0">
	
	<cfset Podcast.strDateToCreate = Now() - url.dateoffset />
	
	<cfset Podcast.PublishDate = formatPrettyDate(Podcast.strDateToCreate) />

	<cfset Podcast.PodcastFile = "#expandPath('/media/audio/podcast/podcast.xml')#"/>
	<cfset Podcast.PodcastFile2 = "#expandPath('/media/audio/podcast/podcast_itunes.xml')#"/>
	
	<cfset Podcast.drPodcastUrl = "http://a1611.g.akamai.net/f/1611/23422/9h/dramsey.download.akamai.com/23572/audio/mp3/dr_3hr_podcast/"/>

	<cfset Podcast.filenameString = "_the_dave_ramsey_show_itunes" />
	<cfset Podcast.filenameExtension = ".mp3" />

	<cfset Podcast.minContentLength = 13000000 />
		
	<cfset Podcast.currentOffset = 0 />
	<cfset Podcast.emailMessage = ''/>

	<cfset Podcast.numberOfSegments = 3 />
	<cfset Podcast.numberOfDays = 1 />

	<cfset Podcast.podcastArray = arrayNew(1) />
	<cfset Podcast.strOutput = "" />
	<cfset Podcast.drPodcastResult = "" />
	<cfset Podcast.itunes = "" />


</cffunction>
<cfset init() />

<cffunction name="addDayToPlaylist" access="private" output="false">
	<cfargument name="dateOffset" >

	<cfset local.strDate = Podcast.strDateToCreate - dateOffset />
	<cfset local.filenames = [renderFilename(local.strDate, 1), renderFilename(local.strDate, 2), renderFilename(local.strDate, 3) ] />
	<cfset local.prettyDate = formatPrettyDate(local.strDate) />
	
	<cfset Podcast.podcastArray[daysRecorded] = [local.filenames, local.prettyDate, local.strDate ]/> 

</cffunction>

<cffunction name="formatPrettyDate" access="private" output="false">
	<cfargument name="dateString" />
	
	<cfset local.formattedMonth = Left(MonthAsString(Month(dateString)),3)/>
	<cfset local.formattedDay = Left(DayOfWeekAsString(DayOfWeek(dateString)),3)/>
	<cfset local.formattedDate = DateFormat(dateString,'dd')/>
	<cfset local.formattedYear = DateFormat(dateString,'yyyy')/>
	<cfreturn "#local.formattedDay#, #local.formattedDate# #local.formattedMonth# #local.formattedYear#" />

</cffunction>

<cffunction name="renderFilename" access="private" output="false">
	<cfargument name="dateString" />
	<cfargument name="partNumber" />

	<cfreturn "#Podcast.drPodcastUrl##DateFormat(dateString,"mmddyyyy")##Podcast.filenameString#_#partNumber##Podcast.filenameExtension#" />

</cffunction>

<cffunction name="renderPodcast" access="private">
	
	<cftry>
		<cfinclude template="dr_3hr_podcast_template_item.cfm"/>
		<cffile action="write" addnewline="no" file="#Podcast.PodcastFile#" output="#dr_podcast#"/>
		
		<cfset Podcast.itunes = "_itunes" />
		<cfinclude template="dr_3hr_podcast_template_item.cfm"/>
		<cffile action="write" addnewline="no" file="#Podcast.PodcastFile2#" output="#dr_podcast#"/>
		
		<cfset Podcast.drPodcastResult = "Success"/>
		<cfoutput><h1>#Podcast.drPodcastResult#</h1></cfoutput>
		
		<cfcatch>
			<cfdump var="#cfcatch#"><cfabort>
			<cfset Podcast.drPodcastResult = "Error"/>
			<cfoutput><h1>#Podcast.drPodcastResult#</h1></cfoutput>
		</cfcatch>
		
	</cftry>
	
	<cfset Podcast.strOutput = "<br>" & Podcast.strOutput & "<br>#Podcast.PublishDate#: #Podcast.drPodcastResult# writing file: #Podcast.PodcastFile#" />
	<cfset Podcast.strOutput = "<br>" & Podcast.strOutput & "<br>#Podcast.PublishDate#: #Podcast.drPodcastResult# writing file: #Podcast.PodcastFile2#" />
	<cfoutput>#Podcast.strOutput#</cfoutput>
	
	<cfparam name="url.suppressEmail" default="0">
	<cfif not structKeyExists(url, "suppressEmail")
		  or url.suppressEmail neq true>
		<cfset sendEmail(Podcast.strOutput) />
	</cfif>

</cffunction>

<cffunction name="sendEmail" access="private">
	<cfargument name="strOutput" type="string" >
	<!--- Send results email --->
	<cfmail to="#emailToAddress#"
		from="webmaster@daveramsey.com"
		subject="Podcast Status: #Podcast.drPodcastResult#"
		type="html">
		<h1>#Podcast.drPodcastResult#</h1>
		#Podcast.strOutput#<hr>
		#Podcast.emailMessage#
	</cfmail>

</cffunction>

<cffunction name="verifyFilesForDay" access="private"  output="false">
	<cfargument name="dateString" />

	<cfset local.numberOfFiles = 0 />

	<cfloop index="segment" from="1" to="#Podcast.numberOfSegments#" step="1">
		<cftry>
			<cfhttp method="head" result="filecheck" url="#renderFilename(dateString, segment)#"  timeout="2"/>
			<cfif filecheck.Responseheader.Status_Code IS 200 AND filecheck.Responseheader["Content-Length"] GT Podcast.minContentLength>
				<cfset local.numberOfFiles += 1 />
				<cfelse>
					<cfreturn FALSE />
			</cfif>

			<cfcatch  type="any">
				<cfreturn FALSE />
			</cfcatch>

		</cftry>
	   
	</cfloop>

	<cfif local.numberOfFiles EQ Podcast.numberOfSegments>
		<cfset message = "<br>#local.numberOfFiles# of #Podcast.numberOfSegments# files are available for #formatPrettyDate(dateString)#<br>" />

		<cfset Podcast.strOutput = Podcast.strOutput & message />
		
		<cfreturn TRUE />
		<cfelse>
			<cfset Podcast.emailMessage = Podcast.emailMessage & message /><cfset Podcast.strOutput = Podcast.strOutput & message />
			<cfset Podcast.emailMessage = Podcast.emailMessage & message />
			<cfreturn FALSE />
	</cfif>

</cffunction>

<cffunction name="populatePodcastArray" access="private"  output="false">
	
	<cfset dayOffset = 0 />
	<cfset daysRecorded = 0 />

	<cfloop index='day' from="0" to="#Podcast.numberOfDays-1#" >

		<cfif day LT Podcast.numberOfDays + 10>
			<cfif verifyFilesForDay(Podcast.strDateToCreate - day) >
				<cfset daysRecorded = daysRecorded + 1 />
				<cfset addDayToPlaylist(day) />
			</cfif>
			<cfelse>
				<cfbreak>
		</cfif>
		
	</cfloop>
</cffunction>

<cfset populatePodcastArray() />
<cfset renderPodcast() />