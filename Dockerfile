FROM mcr.microsoft.com/dotnet/core/sdk:3.0

ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV HOME /home/jenkins
ENV WORKDIR /home/jenkins

# Add jenkins user
RUN adduser --quiet jenkins

WORKDIR $WORKDIR

# Install Mono
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends mono-devel msbuild ca-certificates-mono

# Install Python3
RUN apt-get install -y --no-install-recommends python3 python3-pip
RUN pip3 install --no-cache-dir setuptools
RUN pip3 install --no-cache-dir pygithub
RUN pip3 install --no-cache-dir boto3

# Install DocFX
ADD docfx.tar.gz /usr/share/docfx
