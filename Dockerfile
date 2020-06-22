FROM mcr.microsoft.com/dotnet/core/sdk:3.1

ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV HOME /home/jenkins
ENV WORKDIR /home/jenkins
ENV DOCFX_VER 2.55

# Add jenkins user
RUN adduser --quiet jenkins

WORKDIR $WORKDIR

# Install Mono
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends mono-devel msbuild ca-certificates-mono

# Install Python3
RUN apt-get install -y --no-install-recommends python3 python3-pip
RUN pip3 install --no-cache-dir setuptools
RUN pip3 install --no-cache-dir pygithub
RUN pip3 install --no-cache-dir boto3

# Install DocFX
RUN apt-get install -y --no-install-recommends unzip
RUN \
  wget --no-check-certificate -P /tmp https://github.com/dotnet/docfx/releases/download/v${DOCFX_VER}/docfx.zip \
  && mkdir /usr/share/docfx \
  && unzip /tmp/docfx.zip -d /usr/share/docfx \
  && rm -f /tmp/docfx.zip

