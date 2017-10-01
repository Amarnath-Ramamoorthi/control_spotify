# Control Spotify using Linux shell script

## Getting Started

Control Spotify using simple very basic shell script, tested on Ubunutu 14.10

### Prerequisites

You would require amixer to control the volume of the system

```
$ sudo apt-get upgrade
$ sudo apt-get install amixer
```

### Execute

```
$ ./spotify.sh <user_commands>
```

play, next, prev, volume up, volume down, title, artist, album, status

### How to Use

Using command './spotify play' if spotify not running launches spotify and plays

```
$ ./spotify.sh play
```

Increases volume up and down by 5%

```
$ ./spotify.sh volume up
```

## Author

* **[Amarnath Ramamoorthi](https://github.com/Amarnath-Ramamoorthi)**


## References

* **[John](https://github.com/johnhamelink/spotify-status)**