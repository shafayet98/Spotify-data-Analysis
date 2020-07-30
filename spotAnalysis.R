library(spotifyr)
library(dplyr)
library(httpuv)

# user information
Sys.setenv(SPOTIFY_CLIENT_ID = '')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '')
access_token <- get_spotify_access_token()
userID <- ""

# get my top tracks
topTracks1 <- get_my_top_artists_or_tracks(type = "tracks", limit = 50)
topTracks2 <- get_my_top_artists_or_tracks(type = "tracks", limit = 50, offset = 49)

topTracks <- rbind.data.frame(topTracks1,topTracks2)


# get each tracks name
topTracksName <- topTracks$name
# total track number
total_tracks <- length(topTracksName)

# get each tracks id
topTracksID <- topTracks$id

# get each tracks artist Name
topTracksArtists <- topTracks$artists
topTracksArtistsName <- c()
for(i in 1:total_tracks){
  if(length(topTracksArtists[[i]][[3]] > 1)){
    topTracksArtistsName <- append(topTracksArtistsName,topTracksArtists[[i]][[3]][[1]])
  }else{
    topTracksArtistsName <- append(topTracksArtistsName,topTracksArtists[[i]][[3]])
  }
}

# get each tracks popularity
topTrackPopulairty <- topTracks$popularity

# get album name of each track
topTracksAlbumName <- topTracks$album.name
topTracksAlbumId <- topTracks$album.id

# get each track info
getTrackInfo <- get_track_audio_features(topTracksID)

# get each track energy
trackEnergy <- getTrackInfo[,"energy"]

# get each track acousticness
trackAcousticness <- getTrackInfo[,"acousticness"]

# get each track key
trackKey <- getTrackInfo[,"key"]

# get each track loudness
trackLoudNess <- getTrackInfo[,"loudness"]

#  create Data.frame
df <- data.frame("track.Name" = topTracksName,"track.Artist.Name" = topTracksArtistsName,
                 "track.Album.Name" = topTracksAlbumName, "track.Popularity" = topTrackPopulairty,
                 "track.Energy" = trackEnergy, "track.Acousticness" = trackAcousticness, "track.Key" = trackKey,
                 "track.Loudness" = trackLoudNess)

write.csv(df,file = "spotifyTopListenedTrackAnalysi-test.csv")






