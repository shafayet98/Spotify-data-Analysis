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
library(dplyr)


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

# Does loud songs mean more energetic songs? most of the energy measured by loudness? 
ggplot(df, aes(x = loudness, y = energy))+ 
  theme_bw()+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "loudness of track",
         y = "energy of tracks",
         title = "Effect of loudness in Measuring Energy")



# interesting most popular track (what i listen) has either high Acoustic-ness or Low Acoustic-ness
# nothing in the middle
ggplot(df_new, aes(x = acousticness, y = track.Popularity, color = popularity_class, size = 0.4))+ 
  theme_bw()+ 
  geom_point()+
  labs(x = "acousticness of track",
       y = "Popularity of track",
       title = "Acoustic-ness effects on popularity")


# Does loudness and energy effects on track popularity?
# creating A new column based on popularity
# using dplyr

df_new <- tbl_df(df) 
dim(df_new)
df_new <- mutate( df_new, popularity_class = ifelse( df_new$track.Popularity >= 1 & df_new$track.Popularity <= 20,"E",
                                                     ifelse(df_new$track.Popularity > 20 & df_new$track.Popularity <=40, "D",
                                                            ifelse(df_new$track.Popularity > 40 & df_new$track.Popularity <=60,"C",
                                                                   ifelse(df_new$track.Popularity > 60 & df_new$track.Popularity <= 80, "B",
                                                                          ifelse(df_new$track.Popularity > 80, "A","NULL" ) ) ) ) ) )






ggplot(df_new, aes(x = popularity_class, fill = key ))+
  theme_bw() +
  geom_bar() +
  labs( x ="Popularity Class (A(Highest)-E(Lowest))",
        title = "")




