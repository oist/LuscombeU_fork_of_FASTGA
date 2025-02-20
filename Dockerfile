FROM debian:12.9
MAINTAINER Charles Plessy <charles.plessy@oist.jp>

WORKDIR /FASTGA

RUN apt -y update
RUN apt -y install locales-all                  && apt-get clean  # Multilingual support
RUN apt -y install build-essential zlib1g-dev   && apt-get clean  # Install compiler
COPY . .
RUN make && make install DEST_DIR=/usr/bin                        # Compile and install
RUN apt -y purge build-essential                                  # Remove compiler
RUN apt -y purge apt --allow-remove-essential --auto-remove       # Reomove apt
RUN rm -rf /FASTGA /var/lib/apt                                   # Final cleanup
