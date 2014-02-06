FROM ibuildthecloud/ubuntu-core:12.04.3
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d
RUN echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true; rm -rf /var/lib/apt/lists || true; rm -rf /var/cache/apt/*.bin || true";};' > /etc/apt/apt.conf.d/no-cache
RUN sed -i 's/main restricted/main universe restricted/g' /etc/apt/sources.list
RUN apt-get update -y && \
    apt-get upgrade -y
