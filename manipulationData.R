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
library(ggpubr)
library(reshape2)

# As these are the songs I have listened more. What is most of the track's popularity 
# lies on the graph? Can I draw a statement that, my favorites have have specific 
# range of popularity?

ggplot(df, aes(x = track.Popularity))+
  theme_bw() +
  geom_density( alpha= 0.5, fill = "#FF6666") +
  labs( x ="Popularity of tracks",
        title = "Distribution of the popularity of tracks")

# If I group the tracks according to keys. What is the key that has most of the song, 
# technically speaking, What is my most favorite Key? 
df$key <- as.factor(df$key)
ggplot(df, aes(x = key, fill = key))+
  theme_bw()+
  geom_bar()+
  scale_fill_discrete(name="Pitches", labels=c("0-C", "1-C# Db", "2-D","3-D# Eb","4-E","5-F","6-F# Gb","7-G","8-G# Ab","9-A","10-A# Bb","11-B"))+
  labs(x = "Keys of tracks",
       y = "Number of tracks",
       title = "Number of tracks Vs. Keys")

# Does loud songs mean more energetic songs? most of the energy measured by loudness? 
ggplot(df, aes(x = loudness, y = energy))+ 
  theme_bw()+ 
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Loudness of track",
         y = "Energy of tracks",
         title = "Energy Vs. Loudness")


# In my most played tracks what is the distribution of acoustic-ness? Do I prefer listening 
# tracks those have specific acoustic range?


#  (Solution - 01)
df_test <- tbl_df(df) 
df_test <- mutate(df_test, popularity_class = cut(df$track.Popularity, breaks = 5))
View(df_test)


#  (Solution -02)
df_new <- tbl_df(df) 
dim(df_new)
df_new <- mutate( df_new, popularity_class = ifelse( df_new$track.Popularity >= 1 & df_new$track.Popularity <= 20,"E",
                                                     ifelse(df_new$track.Popularity > 20 & df_new$track.Popularity <=40, "D",
                                                            ifelse(df_new$track.Popularity > 40 & df_new$track.Popularity <=60,"C",
                                                                   ifelse(df_new$track.Popularity > 60 & df_new$track.Popularity <= 80, "B",
                                                                          ifelse(df_new$track.Popularity > 80, "A","NULL" ) ) ) ) ) )

# V-1 (using density plot)
# Distribution of Acoustic-ness of my most listened songs
ggplot(df_new, aes(x = acousticness))+
  theme_bw() +
  geom_density( alpha= 0.5, fill = "#0a5b96") +
  labs( x ="Acousticness of tracks",
        title = "Distribution of the Acousticness of tracks")

#  V-2 (using scatter plot along with popularity class)
#  (Solution - 02)
ggplot(df_new, aes(x = acousticness, y = track.Popularity, color = popularity_class))+ 
  theme_bw()+ 
  geom_point()+
  scale_color_discrete(name="Category of Popularity", labels=c("A-Popularity > 80","B-Popularity > 60","C-Popularity > 40","D-Popularity > 20","E-Popularity > 1"))+
  labs(x = "Acousticness of track",
       y = "Popularity of track",
       title = "Popularity Vs Acousticness")

#  (Solution - 01)
ggplot(df_test, aes(x = acousticness, y = track.Popularity, color = popularity_class))+ 
  theme_bw()+ 
  geom_point()+
  scale_color_discrete(name="Category of Popularity", labels=c("A-Popularity > 80","B-Popularity > 60","C-Popularity > 40","D-Popularity > 20","E-Popularity > 1"))+
  labs(x = "Acousticness of track",
       y = "Popularity of track",
       title = "Popularity Vs Acousticness")


# On popularity basis, which key of tracks has been listened most(how much)? 
ggplot(df_new, aes(x = popularity_class, fill = key ))+
  theme_bw() +
  geom_bar() +
  scale_fill_discrete(name="Pitches", labels=c("0-C", "1-C# Db", "2-D","3-D# Eb","4-E","5-F","6-F# Gb","7-G","8-G# Ab","9-A","10-A# Bb","11-B"))+
  labs( x ="Popularity Class (A(Highest)-E(Lowest))",
        title = "Key of tracks Count based on Popularity")

# ***** DONE (above) *****



# Adding an ID Column in df_new
df_new$ID <- seq.int(nrow(df_new))
View(df_new)
t_c <- sapply(df_new$ID, function(elem){
  if (elem <= 20){return("A")}
  else if(elem <= 40){return("B")}
  else if(elem <= 60){return("C")}
  else if(elem <= 70){return("D")}
  else if(elem <= 100){return("E")}
})
df_new <- mutate( df_new, top_class = t_c)
View(df_new)

# On each category (top 20, 2nd 20...) which key (C,C#,A,Ab etc) based track I have listened more??
df_new$top_class <- as.factor(df_new$top_class)
ggplot(df_new, aes(x = top_class, fill = key ))+
  theme_bw() +
  geom_bar() +
  labs( x ="Top Base Class",
        title = "")

# Top Song wise Energy Distribution
t_energy <- ggplot(df_new, aes(x = energy, fill = top_class))+
  theme_bw() +
  geom_density( alpha= 0.3) +
  labs( x ="Energy of tracks",
        title = "Distribution of Enerygy")

# Top Song wise acoustic-ness Distribution
t_acoustic <- ggplot(df_new, aes(x = acousticness, fill = top_class))+
  theme_bw() +
  geom_density( alpha= 0.3) +
  labs( x ="acousticness of tracks",
        title = "Distribution of Acousticness")

# Top Song wise loudness Distribution
t_loudness <- ggplot(df_new, aes(x = loudness, fill = top_class))+
  theme_bw() +
  geom_density( alpha= 0.3) +
  labs( x ="Loudness of tracks",
        title = "Distribution of Loudness")

# Top Song wise Popularity Distribution
t_popularity <- ggplot(df_new, aes(x = track.Popularity, fill = top_class))+
  theme_bw() +
  geom_density( alpha= 0.3) +
  labs( x ="Popularity of tracks",
        title = "Distribution of Popularity")

figure <- ggarrange(t_energy, t_loudness, t_acoustic, t_popularity,
                    labels = c("A", "B", "C","D"),
                    ncol = 2, nrow = 2)


figure

# key wise boxplot(range) of energy and loudness
key_enery <- ggplot(df_new, aes(x=energy, fill=key)) + 
  geom_boxplot() +
  facet_wrap(~key)

key_loudness <- ggplot(df_new, aes(x=loudness, fill=key)) + 
  geom_boxplot() +
  facet_wrap(~key)

# Heat-map Correlation
colnames(df_new)
cor_data <- select(df_new,energy,acousticness,loudness,track.Popularity)
View(cor_data)

#  create co-relation matric
cormat <- round(cor(cor_data),2)
# melt the correlation matrix
melted_cormat <- melt(cormat)

heat_map_corr <- ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()

heat_map_corr


