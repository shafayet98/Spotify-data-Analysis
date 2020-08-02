# Spotify-data-Analysis
### Analysing my top tracks on Spotify using spotifyr and ggplot2 (answering valuable questions with data)

#### Description:

This is a data visualisation project in R and ggplot2. I collected this dataset using spotify API with the help of spotifyr package. This is a datset of my top 98 most listened (or played) tracks on spotify.

As data science is mostly about answering question with the help of data, visualising the data is a big part of it. So, In this project I tried to visualise with different plots and tried to find some answer with the visualisation.

#### R packages used:

1. spotifyr
2. dplyr
3. httpuv
4. ggpubr
5. ggplot2
6. reshape2

#### Visualisation in detail:

**(Question-01): As these are the songs I have listened more. What is most of the track's popularity lies on the graph? Can I draw a statement that, my favourites have have specific range of popularity?**

![](readme_images/Distribution%20of%20the%20popularity%20of%20tracks.jpeg)

Here's the distribution of popularity of the tracks, by watching this plot I think I might have an idea that most of my listened track's have a popularity in between 35-70 (Guess am not a lover of highly popular songs)

**(Question-02):  If I group the tracks according to keys. What is the key that has most of the song, technically speaking, What is my most favourite Key?**

Guess I am a fan of songs that is in scale C (noice..)

![](readme_images/Number%20of%20tracks%20Vs.%20Keys.jpeg)

**(Question-03): Does loud songs mean more energetic songs? most of the energy measured by loudness?**

![](readme_images/Energy%20Vs.%20Loudness.jpeg)

It looks like the relation between loudness and energy of a track is linear. 

**(Question-04): In my most played tracks what is the distribution of acoustic-ness? Do I prefer listening tracks those have specific acoustic range?**

![](readme_images/Distribution%20of%20the%20Acousticness%20of%20tracks.jpeg)

This one is tricky, maybe I like songs that have lower or higher acoustic-ness, maybe middle value are not that interesting to me. It's hard to tell, let's try another way:

![](readme_images/Popularity%20Vs%20Acousticness.jpeg)

This is 3-dimensional visualisation, the x and y axes are continuous variable and each of the track  is coloured by it's popularity class.
Popularity class was not on default, I created the column with conditions like if a track has a popularity in between 80-100 then it belongs to class-A and so on. It definitely gives us an interesting visualisation.

**(Question-05): Based on popularity class, which key of tracks has been listened most(how much)?**

![](readme_images/Key%20of%20tracks%20Count%20based%20on%20Popularity.jpeg)

clearly we can see most of my listened tracks are of class C (popularity between 40 and 60) which we thought 35-70 in our first plot, and inside of this class I think most of the songs are of scale C (what we found in Question-02). Impressive power of visualisation, right?

*Now I am making a column on basis of tracks index. so, I am categorising all tracks in 5 groups where group A have first 20 tracks and Group B have next 20 songs and so on. Let's do it if we can find any interesting visuals.*

**(Question-06): Now let's Finding out, on each index wise category which keys of tracks were played how many times?**

![](readme_images/Count%20tracks(According%20to%20Key)%20Vs%20Category(Index%20wise).jpeg)

Here,
class A = track (1-20),
class B = track (21-40),
class C = track (41-60),
class D = track (61-80),
class E = track (81-100)

It's clear thing to see, each class has different colour of keys(coloured) and count of tracks. we can come to a statement like in class-A most listened songs are in "scale of A" and in class-C it's "scale of C" etc etc.

**Now let's find of distribution of loudness, energy, acoustic-ness and popularity in terms of each Index based Class/Category**

![](readme_images/Category%20wise%20distribution%20of%20energy,loudness,%20acousticness%20and%20popularity.jpeg)

**Finding out the minimum, maximum, median and all four quartile of energy in each key using boxplot**

![](readme_images/Key%20wise%20boxplot%20of%20Enerygy.jpeg)

**Finding out the minimum, maximum, median and all four quartile of Loudness in each key using boxplot**

![](readme_images/Key%20wise%20boxplot%20of%20loudness.jpeg)

**Heat-map Correlation**

![](readme_images/heat-map%20correlation.jpeg)

Find this on medium by clicking [here](https://medium.com/@shafayet.islam.61/spotify-data-analysis-using-r-and-ggplot2-6b1252d98e8f)

***This is my very first visualisation using R and ggplot2. Hopefully the code and the process might help you to get some intuition. Thank you.*** 
