FROM ubuntu:22.04

LABEL maintainer="Tomohisa Kusano <siomiz@gmail.com>"

ENV VNC_SCREEN_SIZE=1024x768


RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
	&& DEBIAN_FRONTEND=noninteractive \
	apt-get install -y --no-install-recommends \
	gnupg2 \
    vim \
    sudo \
    python3-pip \
    curl \
    nginx \
    net-tools \
	fonts-noto-cjk \
	pulseaudio \
	supervisor \
	x11vnc \
	fluxbox \
	eterm

ADD chrome/* /tmp/

RUN apt-key add /tmp/linux_signing_key.pub \
	&& dpkg -i /tmp/google-chrome-stable_current_amd64.deb \
	|| dpkg -i /tmp/chrome-remote-desktop_current_amd64.deb \
	|| DEBIAN_FRONTEND=noninteractive apt-get -f --yes install

COPY copyables /


RUN apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/* \
	&& useradd -m -G chrome-remote-desktop,pulse-access chrome \
	&& usermod -s /bin/bash chrome \
	&& ln -s /crdonly /usr/local/sbin/crdonly \
	&& ln -s /update /usr/local/sbin/update \
	&& mkdir -p /home/chrome/.config/chrome-remote-desktop \
	&& mkdir -p /home/chrome/.fluxbox \
	&& echo ' \n\
		session.screen0.toolbar.visible:        false\n\
		session.screen0.fullMaximization:       true\n\
		session.screen0.maxDisableResize:       true\n\
		session.screen0.maxDisableMove: true\n\
		session.screen0.defaultDeco:    NONE\n\
	' >> /home/chrome/.fluxbox/init \
	&& chown -R chrome:chrome /home/chrome/.config /home/chrome/.fluxbox
ENV PATH="$PATH:/home/chrome/.local/bin"
WORKDIR /home/chrome
ADD proxy /home/chrome/proxy
RUN mkdir -p /home/chrome/logs
RUN chmod +x /home/chrome/proxy/boot.sh
RUN chmod -R 777 /home/chrome
#
#
#
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/lib/nginx
RUN chmod -R 777 /var/lib/nginx
RUN chmod -R 777 /var/log/nginx
RUN export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
RUN DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
#
#
#
USER root
VOLUME ["/home/chrome"]

RUN mkdir -p /home/chrome/userData
RUN mkdir -p /home/chrome/proxy


EXPOSE 5900

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
