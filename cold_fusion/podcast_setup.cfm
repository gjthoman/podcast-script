<!---
  Setup mytmmo podcast xml
  Setup itunes podcast xml
  Setup dr.com podcast xml
  Verify Streaming Archive Files exist
 --->

<cfif DayOfWeek(Now()) IS 1 OR DayOfWeek(Now()) IS 7>
  <cfexit/>
</cfif>

<cfset daveramseyPodcastFile = "/var/jboss/lampo.cfmain/deploy/cfusion.ear/cfusion.war/media/audio/podcast/podcast.xml"/>
<cfset daveramseyPodcastUrl = "http://www.podtrac.com/pts/redirect.mp3/a1611.g.akamai.net/f/1611/23422/9h/dramsey.download.akamai.com/23572/audio/mp3/drpodcast/"/>

<cfset itunesPodcastFile = "/var/jboss/lampo.cfmain/deploy/cfusion.ear/cfusion.war/media/audio/podcast/podcast_itunes.xml"/>
<cfset itunesPodcastUrl = "http://www.podtrac.com/pts/redirect.mp3/a1611.g.akamai.net/f/1611/23422/9h/dramsey.download.akamai.com/23572/audio/mp3/itunes/"/>

<cfset mytmmoSecurePodcastFile = "/var/jboss/lampo.mytmmo/deploy/cfusion.ear/cfusion.war/config/podcast3hour.xml"/>
<cfset mytmmoSecurePodcastUrl = "http://www.podtrac.com/pts/redirect.mp3/a1611.g.akamai.net/f/1611/23575/9h/dramsey.download.akamai.com/23575/audio/mp3/commercialfree/"/>

<cfset realStreamUrl = "http://a1611.g.akamai.net/f/1611/23422/9h/dramsey.download.akamai.com/23572/audio/rm/"/>
<cfset windowsMediaStreamUrl = "http://a1611.g.akamai.net/f/1611/23422/9h/dramsey.download.akamai.com/23572/audio/wm/"/>

<cfset emailToAddress = "podcastadmin@daveramsey.com"/>
<!--- Common --->
<cfparam name="url.dateoffset" default="0">
<cfset strDateToCreate = Now()-url.dateoffset/>
<cfset FormattedMonth = Left(MonthAsString(Month(strDateToCreate)),3)/>
<cfset FormattedDay = Left(DayOfWeekAsString(DayOfWeek(strDateToCreate)),3)/>
<cfset FormattedDate = DateFormat(strDateToCreate,'dd')/>
<cfset FormattedYear = DateFormat(strDateToCreate,'yyyy')/>
<cfset PublishDate = "#FormattedDay#, #FormattedDate# #FormattedMonth# #FormattedYear# 16:00:00 -0500"/>

<cfparam name="STROUTPUT" default="">
<cfparam name="DAVERAMSEYPODCASTRESULT" default="">
<cfparam name="ITUNESPODCASTRESULT" default="">
<cfparam name="MYTMMOSECUREPODCASTRESULT" default="#arrayNew(1)#">
<cfparam name="WINDOWSMEDIASTREAMRESULT" default="">
<cfparam name="REALSTREAMRESULT" default="">


<!--- Daveramsey --->
<cfset strFilenameDateSetting = itunesPodcastUrl & DateFormat(strDateToCreate,"mmddyyyy")/>
<cfset enclosureUrl = strFilenameDateSetting & "_the_dave_ramsey_show_itunes.mp3"/>
<cfset minContentLength = 13000000 />
  <cftry>
    <cfhttp method="head" result="filecheck" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>
    <cfif filecheck.Responseheader.Status_Code IS 200 AND filecheck.Responseheader["Content-Length"] GT minContentLength>
      <cftry>
        <cfinclude template="itunes_podcast_template.cfm"/>
        <cffile action="write"  addnewline="no" file="#daveramseyPodcastFile#" output="#xmlcontent#"/>
        <cfset daveramseyPodcastResult = "Success"/>
        <cfcatch type="any">
          <cfset daveramseyPodcastResult = "Couldn't create podcast.xml because: #cfCatch.message#"/>
        </cfcatch>
      </cftry>
    <cfelse>
      <cfset daveramseyPodcastResult = "Couldn't create podcast.xml because the filecheck resulted in: #filecheck.Responseheader.Status_Code# and content-length: #filecheck.Responseheader["Content-Length"]#"/>
    </cfif>
    <cfcatch  type="any">
      <cfset daveramseyPodcastResult = "Couldn't create podcast.xml because the filecheck resulted in: HTTP Error"/>
      <cfsavecontent variable="strOutput">
      <cfoutput>
        #strOutput#
        <style>
          * {font-family: arial; font-size: 13px; color: ##006600;}
          .error {font-weight:bold; color: ##aa0000;}
        </style>
        <ul>
          <li class="error">Daveramsey Podcast FAILURE: CFHTTP timeout error</li>
        </ul>
        <cfdump var="#CfCatch#">
      </cfoutput>
      </cfsavecontent>
    </cfcatch>
  </cftry>
  <cftry>
    <!--- iTunes --->
    <cfset strFilenameDateSetting = itunesPodcastUrl & DateFormat(strDateToCreate,"mmddyyyy")/>
    <cfset minContentLength = 13000000 />
    <cfset enclosureUrl = strFilenameDateSetting & "_the_dave_ramsey_show_itunes.mp3"/>
    <cfhttp method="head" result="filecheck" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>
    <cfif filecheck.Responseheader.Status_Code IS 200 AND filecheck.Responseheader["Content-Length"] GT minContentLength>
      <cftry>
        <cfinclude template="itunes_podcast_template.cfm"/>
        <cffile action="write" addnewline="no" file="#itunesPodcastFile#" output="#xmlcontent#"/>
        <cfset iTunesPodcastResult = "Success"/>
        <cfcatch type="any">
          <cfset iTunesPodcastResult = "Couldn't create podcast.xml because: #cfCatch.message#"/>
        </cfcatch>
      </cftry>
    <cfelse>
      <cfset iTunesPodcastResult = "Couldn't create podcast.xml because the filecheck resulted in: #filecheck.Responseheader.Status_Code# and content-length: #filecheck.Responseheader["Content-Length"]#"/>
    </cfif>
    <cfcatch  type="any">
      <cfset iTunesPodcastResult = "Couldn't create podcast.xml because the filecheck resulted in: HTTP Error"/>
      <cfsavecontent variable="strOutput">
      <cfoutput>
        #strOutput#
        <style>
          * {font-family: arial; font-size: 13px; color: ##006600;}
          .error {font-weight:bold; color: ##aa0000;}
        </style>
        <ul>
          <li class="error">iTunes Podcast FAILURE: CFHTTP timeout error</li>
        </ul>
        <cfdump var="#CfCatch#">
      </cfoutput>
      </cfsavecontent>
    </cfcatch>
  </cftry>
  <cftry>
    <!--- MYTMMO Secure--->
    <!--- Include the last 5 podcasts, going back as far as a week. --->
    <!--- Get the initial date to work back from. --->
    <cfset strDateToCreate = Now()-url.dateoffset/>
    <cfset daysAttemptedSoFar = 1/>
    <cfset daysToInclude = 5/>
    <cfset xmlPodcastFeed = ""/>
    <cfinclude template="mytmmo_secure_podcast_template_header.cfm"/>
    <cfset xmlPodcastFeed = xmlPodcastFeed & xmlcontent/>
    <cfloop condition="daysAttemptedSoFar lte daysToInclude">

      <cfset FormattedMonth = Left(MonthAsString(Month(strDateToCreate)),3)/>
      <cfset FormattedDay = Left(DayOfWeekAsString(DayOfWeek(strDateToCreate)),3)/>
      <cfset FormattedDate = DateFormat(strDateToCreate,'dd')/>
      <cfset FormattedYear = DateFormat(strDateToCreate,'yyyy')/>
      <cfset PublishDate = "#FormattedDay#, #FormattedDate# #FormattedMonth# #FormattedYear# "/>
      <cfif DayOfWeek(strDateToCreate) eq 1 >
        <!--- If it's looking at a Sunday, bounce it back two days to Friday' --->
        <cfset strDateToCreate = strDateToCreate -2 />
      <cfelseif DayOfWeek(strDateToCreate) eq 7 >
        <!--- If it's looking at a Saturday, bounce it back a day to Friday' --->
        <cfset strDateToCreate = strDateToCreate -1 />
      <cfelse>

        <cfset strFilenameDateSetting = mytmmoSecurePodcastUrl & DateFormat(strDateToCreate,"mmddyyyy")/>
        <cfset minContentLength = 13000000 />
        <cfset enclosureUrl = strFilenameDateSetting & "_" & 1 & "_the_dave_ramsey_show.mp3"/>
        <cfhttp method="head" result="filecheck1" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>
        <cfset enclosureUrl = strFilenameDateSetting & "_" & 2 & "_the_dave_ramsey_show.mp3"/>
        <cfhttp method="head" result="filecheck2" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>
        <cfset enclosureUrl = strFilenameDateSetting & "_" & 3 & "_the_dave_ramsey_show.mp3"/>
        <cfhttp method="head" result="filecheck3" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>

        <cfif ( filecheck1.Responseheader.Status_Code IS 200 AND filecheck1.Responseheader["Content-Length"] GT minContentLength ) AND
            ( filecheck3.Responseheader.Status_Code IS 200 AND filecheck2.Responseheader["Content-Length"] GT minContentLength ) AND
            ( filecheck3.Responseheader.Status_Code IS 200 AND filecheck3.Responseheader["Content-Length"] GT minContentLength )>
          <cfinclude template="mytmmo_secure_podcast_template_item.cfm"/>
          <cfset xmlPodcastFeed = xmlPodcastFeed & xmlcontent/>
          <cfset mytmmoSecurePodcastResult[daysAttemptedSoFar] = "Success"/>
        <cfelse>
          <cfset mytmmoSecurePodcastResult[daysAttemptedSoFar] = "Couldn't create podcast.xml because the filecheck resulted in: #filecheck1.Responseheader.Status_Code#/#filecheck2.Responseheader.Status_Code#/#filecheck3.Responseheader.Status_Code# Content-Length: #filecheck1.Responseheader["Content-Length"]#/#filecheck2.Responseheader["Content-Length"]#/#filecheck3.Responseheader["Content-Length"]#"/>

        </cfif>
        <!--- We gave it the old college try. Count it! --->
        <cfset daysAttemptedSoFar = daysAttemptedSoFar + 1>
        <!--- Shift the date back one more day. --->
        <cfset strDateToCreate = strDateToCreate -1 />
        <!--- Increment the number of days included. --->
      </cfif>
    </cfloop>
    <cfinclude template="mytmmo_secure_podcast_template_footer.cfm"/>
    <cfset xmlPodcastFeed = xmlPodcastFeed & trim(xmlcontent)/>
    <cftry>
      <cffile action="write" addnewline="no" file="#mytmmoSecurePodcastFile#" output="#xmlPodcastFeed#"/>

      <cfcatch type="any">
        <cfset mytmmoSecurePodcastResult[1] = "An error occured writing the podcast file: #cfCatch.message#"/>
      </cfcatch>
    </cftry>
    <cfcatch  type="any">
      <cfset mytmmoSecurePodcastResult[daysAttemptedSoFar] = "Couldn't create podcast.xml because the filecheck resulted in: HTTP Error"/>
      <cfsavecontent variable="strOutput">
      <cfoutput>
        #strOutput#
        <style>
          * {font-family: arial; font-size: 13px; color: ##006600;}
          .error {font-weight:bold; color: ##aa0000;}
        </style>
        <ul>
          <li class="error">MyTmmo Secure Podcast FAILURE: CFHTTP timeout error</li>
        </ul>
        <cfdump var="#CfCatch#">
      </cfoutput>
      </cfsavecontent>
    </cfcatch>
  </cftry>
  <cftry>
    <cfset strDateToCreate = Now()-url.dateoffset/>
    <!--- Streaming Files --->
    <cfset enclosureUrl = realStreamUrl & DateFormat(strDateToCreate,"mmddyyyy") & "_the_dave_ramsey_show.rm"/>
    <cfset minContentLength = 20000000 />
    <cfhttp method="head" result="filecheck" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>

    <cfset realStreamResult = "Success"/>
    <cfif filecheck.Responseheader.Status_Code IS 200>
      <cfif filecheck.Responseheader["Content-Length"] LTE minContentLength>
        <cfset realStreamResult = "Real Media file is too small: #filecheck.Responseheader["Content-Length"]# bytes"/>
      </cfif>
    <cfelse>
      <cfset realStreamResult = "Real Media file is missing."/>
    </cfif>
    <cfcatch  type="any">
      <cfset realStreamResult = "Real Media file is missing."/>
      <cfsavecontent variable="strOutput">
      <cfoutput>
        #strOutput#
        <style>
          * {font-family: arial; font-size: 13px; color: ##006600;}
          .error {font-weight:bold; color: ##aa0000;}
        </style>
        <ul>
          <li class="error">Real Media FAILURE: CFHTTP timeout error</li>
        </ul>
        <cfdump var="#CfCatch#">
      </cfoutput>
      </cfsavecontent>
    </cfcatch>
  </cftry>
  <cftry>

    <cfset enclosureUrl = windowsMediaStreamUrl & DateFormat(strDateToCreate,"mmddyyyy") & "_the_dave_ramsey_show.wma"/>
    <cfset minContentLength = 24000000 />
    <cfhttp method="head" result="filecheck" url="#enclosureUrl#"  timeout="10" throwonerror="true"/>

    <cfset windowsMediaStreamResult = "Success"/>
    <cfif filecheck.Responseheader.Status_Code IS 200>
      <cfif filecheck.Responseheader["Content-Length"] LTE minContentLength>
        <cfset windowsMediaStreamResult = "Windows Media file is too small: #filecheck.Responseheader["Content-Length"]# bytes"/>
      </cfif>
    <cfelse>
      <cfset windowsMediaStreamResult = "Windows Media file is missing."/>
    </cfif>
    <cfcatch  type="any">
      <cfset windowsMediaStreamResult = "Windows Media file is missing."/>
      <cfsavecontent variable="strOutput">
      <cfoutput>
        #strOutput#
        <style>
          * {font-family: arial; font-size: 13px; color: ##006600;}
          .error {font-weight:bold; color: ##aa0000;}
        </style>
        <ul>
          <li class="error">Windows Media FAILURE: CFHTTP timeout error</li>
        </ul>
        <cfdump var="#CfCatch#">
      </cfoutput>
      </cfsavecontent>
    </cfcatch>
  </cftry>
<cfsavecontent variable="strOutput">
<cfoutput>
  <style>
    * {font-family: arial; font-size: 13px; color: ##006600;}
    .error {font-weight:bold; color: ##aa0000;}
  </style>
  <ul>
    <li<cfif daveramseyPodcastResult neq "Success"> class="error"</cfif>>Daveramsey: #daveramseyPodcastResult#</li>
    <li<cfif iTunesPodcastResult neq "Success"> class="error"</cfif>>iTunes: #iTunesPodcastResult#</li>
    <li<cfif mytmmoSecurePodcastResult[1] neq "Success"> class="error"</cfif>>MyTMMO Secure: #mytmmoSecurePodcastResult[1]#</li>
    <li<cfif windowsMediaStreamResult neq "Success"> class="error"</cfif>>Windows Media Stream: #windowsMediaStreamResult#</li>
    <li<cfif realStreamResult neq "Success"> class="error"</cfif>>Real Stream: #realStreamResult#</li>
  </ul>
  <hr />
  #strOutput#
</cfoutput>
</cfsavecontent>
<cfset sendEmail(strOutput) />

<cffunction name="sendEmail" access="private">
  <cfargument name="strOutput" type="string" >
  <!--- Send results email --->
  <cfmail to="#emailToAddress#"
    from="webmaster@daveramsey.com"
    subject="Podcast Status"
    type="html">
    #arguments.strOutput#
  </cfmail>

  <cfoutput>
    #arguments.strOutput#
  </cfoutput>

</cffunction>