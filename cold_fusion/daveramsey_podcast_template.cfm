<cfset xmlcontent = "<?xml version=""1.0"" ?>
<rss version=""2.0"" xmlns:itunes=""http://www.itunes.com/dtds/podcast-1.0.dtd"">
<channel>
	<title>The Dave Ramsey Show Podcast</title>
	<link>http://www.daveramsey.com/</link>
	<description>The Dave Ramsey Show is a show about life and money. Show aired #PublishDate#</description>
	<language>en-us</language>
	<copyright>Copyright #year(now())#</copyright>
	<lastBuildDate>#PublishDate#</lastBuildDate>
	<pubDate>#PublishDate#</pubDate>
	<ttl>720</ttl>
	<skipDays>
		<day>Sunday</day>
	</skipDays>
	<generator>http://www.daveramsey.com</generator>
	<docs>http://www.daveramsey.com/media/audio/podcast</docs>
	<itunes:author>Dave Ramsey</itunes:author>
	<itunes:image href=""https://a248.e.akamai.net/f/1611/23575/9h/dramsey.download.akamai.com/23572/daveramsey.com/media/image/general/itunes_img_640px.jpg"" />
	<image>
	<url>https://a248.e.akamai.net/f/1611/23575/9h/dramsey.download.akamai.com/23572/daveramsey.com/media/image/general/itunes_img_640px.jpg</url>
	<title>The Dave Ramsey Show Podcast</title>
	<width>144</width>
	<height>144</height>
	<link>http://www.daveramsey.com/</link>
	</image>
 	<itunes:category text=""Business"">
 		<itunes:category text=""Investing"" />
 	</itunes:category>
	<itunes:category text=""Kids &amp; Family"" />
 	<itunes:category text=""Health"">
 		<itunes:category text=""Self-Help"" />
 	</itunes:category>
	<itunes:owner>
		<itunes:name>Lampo Licensing, LLC.</itunes:name>
		<itunes:email>webmaster@daveramsey.com</itunes:email>
	</itunes:owner>
	<item>
		<title>The Dave Ramsey Show Podcast - #PublishDate#</title>
		<description>The Dave Ramsey Show is about life and how it happens to revolve around money. Dave Ramsey teaches you to manage and budget your money to avoid bankruptcy, help yourself get out of debt, build wealth, and live in financial peace without debt consolidation. Managing your money properly will reduce stress, improve your marriage, and provide security for you and your family.</description>
		<enclosure url=""#enclosureUrl#"" length=""25194456"" type=""audio/mpeg"" />
		<itunes:author>Dave Ramsey</itunes:author>
		<link>http://www.daveramsey.com/</link>
		<guid isPermaLink=""false"">http://www.daveramsey.com/fullcommercialpodcast#DateFormat(strDateToCreate,"mmddyyyy")#</guid>
		<category>Educational</category>
		<category>Dave Ramsey</category>
		<category>Money</category>
		<category>Financial</category>
		<pubDate>#PublishDate#</pubDate>
		<itunes:keywords>Dave, Ramsey, Financial, Peace, radio, debt, bankruptcy, budget, counseling, money, retirement, saving</itunes:keywords>
	</item>
</channel>
</rss>">
