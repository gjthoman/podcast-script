# podcast-script

### Make sure it's not the weekend
### Establish file locations
* __daveramsey__ ( file & url )
* __itunes__ ( file & url )
* __mytmmo__ ( file & url )
* __real__ ( file & url )
* __windows__ ( file & url )

### Establish Publish Date ( allows date offset passed in via url )

### Process: DaveRamsey ( non-iTunes )
* Create podcast.xml url with _Publish Date_
* Check content length ( >13000000 )
* Write dr podcast xml ( *itunes_podcast_template.cfm* )
  * Alert email

### Process: DaveRamsey iTunes
* Create podcast.xml url with _Publish Date_
* Check content length ( >13000000 )
* Write iTunes podcast xml ( *itunes_podcast_template.cfm* )
  * Alert email

### Process: MYTMMO
* Create podcast.xml urls with _Publish Date_
* Check content length ( >13000000 )
* Write MYTMMO podcast xml ( *mytmmo_secure_podcast_template_item.cfm* )
  * Alert email

### Process: Real Stream
* Check for Real Media file
  * Alert email

### Process: Windows Media
* Check for Windows Media File
  * Alert email 
