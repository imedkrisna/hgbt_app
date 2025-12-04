library(tidyverse)      # wajib buat data wrangling
library(readxl)         # wajib buat baca data excel
library(fixest)         # Buat regresi data panel
library(modelsummary)   # buat bikin tabel deskripsi statistik dan hasil regresi
library(writexl)        # Nulis excel output dari tibble

# Data prep and summary
dat<-read_excel("dat/HGBT.xlsx",sheet="data") # baca data kalian dari excel
dut<-read_excel("dat/wpi.xlsx")               # baca data indeks harga produksi, ambil dari BPS
dat<-dat|>inner_join(dut) # gabungin wpi ke HGBT
dat$L1<-dat$L/dat$WPI*100 # pake deflator ke variabel-variabel utama
dat$K1<-dat$K/dat$WPI*100
dat$V1<-dat$V/dat$WPI*100
dat$lL1<-log(dat$L1) # bikin log buat nanti diregresi
dat$lK1<-log(dat$K1) # both data nominal maupun deflated
dat$lV1<-log(dat$V1)
dat$lL<-log(dat$L)
dat$lK<-log(dat$K)
dat$lV<-log(dat$V)

datasummary(L+M+K+R+V~factor(HGBT)*(Mean+Median+SD),data=dat,
  notes=c('sumber: penulis'), output="tab/sumstat.xlsx")

# Regresi
## Non deflated

reg1<-feols(data=dat,lV~lK+lL+HGBT)
reg2<-feols(data=dat,lV~lK+lL+HGBT|Perusahaan) # tanda | buat fixed effect
reg3<-feols(data=dat,lV~lK+lL+HGBT|Perusahaan+Tahun)

regtab<- list( # bikin dict buat modelsummary
  "OLS" = reg1,
  "FE"  = reg2,
  "TWFE" = reg3
)
modelsummary(regtab,stars=TRUE,gof_omit = 'FE|IC|RMSE|Std.|Adj.',
  notes=c('sumber: olahan penulis'),output="tab/regression_nominal.xlsx")

## Deflated

reg4<-feols(data=dat,lV1~lK1+lL1+HGBT)
reg5<-feols(data=dat,lV1~lK1+lL1+HGBT|Perusahaan)
reg6<-feols(data=dat,lV1~lK1+lL1+HGBT|Perusahaan+Tahun)

regtab1<- list(
  "OLS" = reg4,
  "FE"  = reg5,
  "TWFE" = reg6
)

modelsummary(regtab1,stars=TRUE,gof_omit = 'FE|IC|RMSE|Std.|Adj.',
  notes=c('sumber: olahan penulis'),output="tab/regression_deflated.xlsx")

# end of file

## Collecting F-stat

fstat<-tibble(
  data=c("Level","Level","Level","Deflated", "Deflated","Deflated"),
  Model=c("OLS","FE","TWFE","OLS","FE","TWFE"),
  Ftest=c(fitstat(reg1,"f")|>capture.output(),
          fitstat(reg2,"f")|>capture.output(),
          fitstat(reg3,"f")|>capture.output(),
          fitstat(reg4,"f")|>capture.output(),
          fitstat(reg5,"f")|>capture.output(),
          fitstat(reg6,"f")|>capture.output())
)

## Nulis fstatnya dalam bentuk excel
write_xlsx(
  fstat,
  path = "tab/fstat.xlsx"
)