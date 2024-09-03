FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV USERNAME=jenkins
ENV USERGROUP=jenkins
ENV USERID=2000
ENV HOME /home/${USERNAME}
ENV WORKDIR /home/${USERNAME}
ENV DOCFX_VER 2.61.0
ENV MONO_VER 6.12.0

# Add jenkins user
RUN addgroup --gid ${USERID} ${USERGROUP}
RUN adduser --uid ${USERID} --gid ${USERID} --disabled-password --gecos "" ${USERNAME}
RUN chmod 775 $HOME

WORKDIR $WORKDIR

# Setup APT
RUN apt-get update && apt-get install -y --no-install-recommends gnupg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stable-buster/snapshots/$MONO_VER main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
  && apt-get update

# Install packages
RUN apt-get install -y --no-install-recommends \
    nodejs unzip git-lfs \
    mono-devel msbuild ca-certificates-mono \
    python3 python3-pip \
    vim

# Install python modules
RUN pip3 install --no-cache-dir setuptools
RUN pip3 install --no-cache-dir pygithub
RUN pip3 install --no-cache-dir boto3

# Install DocFX
RUN dotnet tool install -g docfx --version $DOCFX_VER
ENV PATH="$PATH:/home/jenkins/.dotnet/tools"