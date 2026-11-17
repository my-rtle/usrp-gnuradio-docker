# 1. Base Image 설정
FROM ubuntu:22.04

# 2. 설치 중 사용자 입력 대기 방지
ENV DEBIAN_FRONTEND=noninteractive

# 3. 필수 패키지 및 PPA 저장소 추가
RUN apt-get update && apt-get install -y \
    software-properties-common \
    usbutils \
    iputils-ping \
    net-tools \
    sudo \
    x11-apps

# 4. GNU Radio 공식 PPA 추가
RUN add-apt-repository ppa:gnuradio/gnuradio-releases

# 5. GNU Radio, UHD(USRP API), 관련 패키지 설치
RUN apt-get update && apt-get install -y \
    gnuradio \
    gr-osmosdr \
    uhd-host \
    uhd-soapysdr \
    libuhd-dev \
    python3-uhd \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 6. USRP FPGA/Firmware 이미지 다운로드 (필수)
RUN uhd_images_downloader

# 7. 컨테이너 실행 시 기본 명령
CMD ["/bin/bash"]
