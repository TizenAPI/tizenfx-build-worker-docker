FROM microsoft/dotnet:2.1-sdk

ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV WORKDIR /home/worker

WORKDIR $WORKDIR

# Install Mono
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get clean && apt-get update \
  && apt-get install -y --no-install-recommends mono-devel ca-certificates-mono

# Install required python modules
