FROM mcr.microsoft.com/dotnet/core/sdk:3.1

ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV USERNAME=jenkins
ENV HOME /home/${USERNAME}
ENV WORKDIR /home/${USERNAME}
ENV DOCFX_VER 2.56.1

# Add jenkins user
RUN adduser --disabled-password --gecos "" ${USERNAME}

WORKDIR $WORKDIR

# Setup APT
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
  && apt-get clean && apt-get update

# Install packages
RUN apt-get install -y --no-install-recommends \
    nodejs unzip git-lfs \
    mono-devel msbuild ca-certificates-mono \
    python3 python3-pip

# Install python modules
RUN pip3 install --no-cache-dir setuptools
RUN pip3 install --no-cache-dir pygithub
RUN pip3 install --no-cache-dir boto3

# Install DocFX
RUN wget --no-check-certificate -P /tmp https://github.com/dotnet/docfx/releases/download/v${DOCFX_VER}/docfx.zip \
  && mkdir /usr/share/docfx \
  && unzip /tmp/docfx.zip -d /usr/share/docfx \
  && echo '#!/bin/bash\nulimit -n 65535\nmono --assembly-loader=strict /usr/share/docfx/docfx.exe $@' > /usr/bin/docfx \
  && chmod +x /usr/bin/docfx \
  && chown -R ${USERNAME} /usr/share/docfx \
  && rm -f /tmp/docfx.zip

