library(tidyverse)      # wajib buat data wrangling
library(readxl)         # wajib buat baca data excel
library(fixest)         # Buat regresi data panel
library(modelsummary)   # buat bikin tabel deskripsi statistik dan hasil regresi

# Data prep
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

