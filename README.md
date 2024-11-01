# Score and Series viewer

## Build and run locally

### Build

```bash
docker build . -f ./Dockerfile -t snowexplorer-fsdh:latest
```

### Run

```bash
docker run -p 8080:8080 -v ./data:/fsdh -e SCORE_FILE=/fsdh/score_snw_station_diff_alti_200_HRDPS_CaPA01_CaPA02_period_20191001_20220629.nc -e SERIES_FILE=/fsdh/series_snw_station_diff_alti_200_HRDPS_CaPA01_CaPA02_period_20191001_20220629.nc -t snowexplorer-fsdh:latest

docker run -p 8080:8080 \
  -v ./data:/fsdh \
  -v ./SnowExplorer-V5.ipynb:/app/SnowExplorer-V5.ipynb \
  -e SCORE_FILE=/fsdh/score_snw_station_diff_alti_200_HRDPS_CaPA01_CaPA02_period_20191001_20220629.nc \
  -e SERIES_FILE=/fsdh/series_snw_station_diff_alti_200_HRDPS_CaPA01_CaPA02_period_20191001_20220629.nc \
  -t snowexplorer-fsdh:latest \
  --index=SnowExplorer-V5 \
  SnowExplorer-V5.ipynb
```
