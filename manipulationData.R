#  reading the csv function
csv1 <- read.csv('spotifyTopListenedTrackAnalysi-test.csv')

# removing duplicate song
df <- df[!duplicated(df[1]),]

#  saving the file
write.csv(df,file = "spotifyTopListenedTrackAnalysi-final.csv")
df <- read.csv('spotifyTopListenedTrackAnalysi-final.csv')



# Visualization starts
View(df)
library(ggplot2)


# As these are the songs I have listened more. What is most of the track's popularity 
# lies on the graph?Can I draw a statement that, my favourites have have specific 
# range of popularity?

ggplot(df, aes(x = track.Popularity))+
  theme_bw() +
  geom_density( alpha= 0.5, fill = "#FF6666") +
  labs( x ="Popularity of tracks",
        title = "Popularity of songs")

# If I group the tracks according to keys. What is the key that has most of the song, 
# technically speaking, What is my most favourite Key? 

df$key <- as.factor(df$key)
# cbPalette <- c("#011a33", "#022448", "#1b426b", "#284a6f", "#33526f", "#33526f", "#405a73", "#325c84","4d7195","6685a2","809ab3","#000","#6385a2","109ab3")
length(cbPalette)
ggplot(df, aes(x = key, fill = key))+
  theme_bw()+
  geom_bar()+
  scale_fill_discrete(name="Pitches", labels=c("0-C", "1-C# Db", "2-D","3-D# Eb","4-E","5-F","6-F# Gb","7-G","8-G# Ab","9-A","10-A# Bb","11-B"))+
  labs(x = "Keys",
       y = "number of tracks",
       title = "Keys along with track counts")

# Does loudness effects track Popularity? 




