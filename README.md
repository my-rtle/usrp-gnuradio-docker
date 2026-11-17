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

## 디렉터리

| 경로 | 설명 |
|------|------|
| `docker-compose.yml` | Docker Hub 이미지를 pull해서 쓰는 기본 compose 파일 |
| `docker-compose.build.yml` | Dockerfile로 직접 빌드할 때 쓰는 compose 파일 |
| `Dockerfile` | 이미지 빌드 정의 |
| `workspace/` | 호스트와 컨테이너(`/workspace`)가 공유하는 작업 폴더. 플로우그래프(.grc) 등을 여기에 저장 |

## 직접 빌드하기

```bash
docker compose -f docker-compose.build.yml up -d --build
```

## compose 설정 요약

- `privileged: true`, `/dev/bus/usb` 마운트: USB 계열 USRP(B200/B210 등) 인식
- `network_mode: host`: 이더넷 계열 USRP(N2xx/X3xx 등) 연결
- `DISPLAY`, `/tmp/.X11-unix` 마운트: 호스트 X 서버로 GUI 출력
- `./workspace:/workspace`: 작업 파일 공유

## 문제 해결

- **USRP가 안 잡힘 (USB)**: 호스트에서 `lsusb`로 장치가 보이는지 확인하고, 컨테이너를 재시작합니다. 장치를 꽂은 뒤 컨테이너를 올려야 합니다.
- **USRP가 안 잡힘 (이더넷)**: 호스트 NIC IP를 `192.168.10.1/24`처럼 USRP와 같은 대역으로 설정하고 `ping 192.168.10.2`로 확인합니다.
- **GUI 창이 안 뜸**: 호스트에서 `xhost +local:docker`를 실행했는지, `echo $DISPLAY` 값이 있는지 확인합니다.
- **Wayland 환경**: `xhost +local:docker`가 동작하는 XWayland가 필요합니다.

## 라이선스

MIT
