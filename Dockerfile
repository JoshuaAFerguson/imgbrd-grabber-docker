# Pull base image.
FROM jlesage/baseimage-gui:debian-11-v4

# Install xterm.
RUN add-pkg git ca-certificates qtbase5-dev qtscript5-dev qtmultimedia5-dev qtdeclarative5-dev qttools5-dev qttools5-dev-tools libqt5networkauth5-dev g++ cmake libssl-dev nodejs npm make exiftool rsync

RUN git clone https://github.com/Bionus/imgbrd-grabber.git --recursive

RUN cd imgbrd-grabber && \
	./scripts/build.sh && \
	./scripts/package.sh "release" && \
	cp -r src/dist/linux/* "release" && \
	mkdir /grabber && \
	cp -r release/* /grabber && \
	mkdir /data

#Setup Volumes
VOLUME /grabber
VOLUME /data

#Copy the start script.
COPY startapp.sh /startapp.sh

#Copy extras into grabber path 
COPY /extras/ /grabber/

# Set the name of the application.
RUN set-cont-env APP_NAME "Grabber"
