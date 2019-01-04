FROM microsoft/dotnet:2.1-sdk

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

# Install required python modules
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm -f get-pip.py
RUN pip2 install PyGithub

# Install DocFX
ADD docfx.tar.gz /usr/share/docfx
