# usrp-gnuradio-docker

USRP + GNU Radio 개발 환경을 Docker로 바로 띄우기 위한 저장소입니다.
이미지는 Docker Hub의 [`woodahyun/usrp`](https://hub.docker.com/r/woodahyun/usrp)에 올라가 있어서 빌드 없이 pull만 하면 됩니다.

## 포함된 것

- Ubuntu 22.04
- GNU Radio (공식 PPA), gr-osmosdr
- UHD (uhd-host, libuhd-dev, python3-uhd, uhd-soapysdr)
- USRP FPGA/펌웨어 이미지 (`uhd_images_downloader` 실행 완료)
- usbutils, net-tools, iputils-ping, x11-apps

## 요구 사항

- Linux 호스트 (USB 패스스루와 X11을 사용하므로 Linux 기준)
- Docker + Docker Compose v2 (`docker compose` 명령)

## 빠른 시작

```bash
git clone https://github.com/my-rtle/usrp-gnuradio-docker.git
cd usrp-gnuradio-docker

# GUI(gnuradio-companion)를 쓸 경우 1회 실행
xhost +local:docker

docker compose pull
docker compose up -d
docker compose exec gnuradio bash
```

컨테이너 안에서:

```bash
uhd_find_devices        # USRP 인식 확인
uhd_usrp_probe          # 장치 상세 정보
gnuradio-companion      # GUI 실행
```
