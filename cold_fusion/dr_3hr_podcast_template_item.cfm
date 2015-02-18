<cfxml variable="dr_podcast"><?xml version="1.0" ?>
	<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<atom:link href="http://www.daveramsey.com/media/audio/podcast/podcast<cfoutput>#Podcast.itunes#</cfoutput>.xml" rel="self" type="application/rss+xml" />
		<title>The Dave Ramsey Show</title>
		<link>http://www.daveramsey.com?ectid=itunes</link>
		<description>The Dave Ramsey Show is about real life and how it revolves around money. Dave Ramsey teaches you to manage and budget your money, get out of debt, build wealth, and live in financial peace. Managing your money properly will reduce stress, improve your marriage, and provide security for you and your family. Updated: <cfoutput>#Podcast.PublishDate#</cfoutput></description>
		<itunes:subtitle>The Dave Ramsey Show is about real life and how it revolves around money. Dave Ramsey teaches you to manage and budget your money, get out of debt, build wealth, and live in financial peace. Updated: <cfoutput>#Podcast.PublishDate#</cfoutput></itunes:subtitle>
		<itunes:summary>The Dave Ramsey Show is about real life and how it revolves around money. Dave Ramsey teaches you to manage and budget your money, get out of debt, build wealth, and live in financial peace. Managing your money properly will reduce stress, improve your marriage, and provide security for you and your family. Updated: <cfoutput>#Podcast.PublishDate#</cfoutput></itunes:summary>
		<language>en-us</language>
		<copyright>Copyright <cfoutput>#year(now())#</cfoutput></copyright>
		<itunes:owner>
			<itunes:name>Lampo Licensing, LLC.</itunes:name>
			<itunes:email>webmaster@daveramsey.com</itunes:email>
		</itunes:owner>
		<lastBuildDate><cfoutput>#Podcast.PublishDate#</cfoutput> 16:00:00 -0500</lastBuildDate>
		<pubDate><cfoutput>#Podcast.PublishDate#</cfoutput> 16:00:00 -0500</pubDate>
		<ttl>720</ttl>
		<skipDays>
			<day>Sunday</day>
		</skipDays>
		<generator>http://www.daveramsey.com?ectid=itunes</generator>
		<docs>http://www.daveramsey.com/media/audio/podcast</docs>
		<itunes:author>Dave Ramsey</itunes:author>
		<itunes:image href="http://a248.e.akamai.net/f/1611/23575/9h/dramsey.download.akamai.com/23572/daveramsey.com/media/image/general/itunes_img_640px.jpg" />
		<image>
		<url>http://a248.e.akamai.net/f/1611/23575/9h/dramsey.download.akamai.com/23572/daveramsey.com/media/image/general/itunes_img_640px.jpg</url>
		<title>The Dave Ramsey Show</title>
		<width>144</width>
		<height>144</height>
		<link>http://www.daveramsey.com?ectid=itunes</link>
		</image>
	 	<itunes:explicit>No</itunes:explicit>
	 	<itunes:category text="Business">
	 		<itunes:category text="Investing" />
	 	</itunes:category>
		<itunes:category text="Kids &amp; Family" />
	 	<itunes:category text="Health">
	 		<itunes:category text="Self-Help" />
	 	</itunes:category>
		<cfloop index="day" from="1" to="#ArrayLen(Podcast.podcastArray)#" step="1">
			<cfloop index="segment" from="1" to="#ArrayLen(Podcast.podcastArray[day][1])#" step="1">
				<item>
					<title><cfoutput>"#Podcast.podcastArray[day][2]# - Hour #segment#"</cfoutput></title>
					<itunes:subtitle>The Dave Ramsey Show</itunes:subtitle>
					<itunes:summary>The Dave Ramsey Show is about real life and how it revolves around money. Dave Ramsey teaches you to manage and budget your money, get out of debt, build wealth, and live in financial peace. Managing your money properly will reduce stress, improve your marriage, and provide security for you and your family. Updated: <cfoutput>#Podcast.podcastArray[day][2]#</cfoutput></itunes:summary>
					<enclosure url='<cfoutput>#Podcast.podcastArray[day][1][segment]#</cfoutput>' length="16371511" type="audio/mpeg" />
					<itunes:author>Lampo Licensing, LLC.</itunes:author>
					<link>http://www.daveramsey.com?ectid=itunes</link>
					<guid isPermaLink="false"><cfoutput>TDRS#DateFormat(Podcast.podcastArray[day][3],"mmddyyyy")#-#segment#</cfoutput></guid>
					<category>Educational</category>
					<category>Dave Ramsey</category>
					<category>Money</category>
					<category>Financial</category>
					<category>Life</category>
					<pubDate><cfoutput>#Podcast.podcastArray[day][2]#</cfoutput> <cfoutput>#16-segment#</cfoutput>:00:00 -0500</pubDate>
					<itunes:keywords>Dave, Ramsey, Financial, Peace, radio, debt, bankruptcy, budget, counseling, money, retirement, saving</itunes:keywords>
				</item>
			</cfloop>	
		</cfloop>
	</channel>
	</rss>
	</cfxml>