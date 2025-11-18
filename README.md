# Tentang repo ini
Ini adalah repository untuk paper yang dikerjakan bersama dengan Yustika Pambudi, Dhisa Priyadi dan Dinar Safa. Kami meneliti tentang dampak Harga Gas Bumi Tertentu (HGBT) terhadap peningkatan nilai tambah dari industri manufaktur di Indonesia.

Repo ini hanya berfokus pada kode untuk mengeluarkan _summary statistics_ dan hasil regresi dari paper tersebut. Semua proses pengumpulan data dilakukan oleh para peneliti dan tidak termasuk dalam repo ini. Datanya sendiri dapat dilihat di folder `dat`.

Di repo ini ada `index.qmd` yang berisi kode untuk menghasilkan dokumennya dalam bentuk html dan docx. Disiapkan juga `hgbt.r` yang berisikan file R replikasi untuk menghasilkan tabel-tabel yang ada di dokumen. untuk run `hgbt.r` hanya diperlukan folder `dat` beserta isinya dan folder `tab` untuk lokasi penyimpanan tabel regresi dalam bentuk excel.

Jika repo ini bermanfaat untuk anda, mohon dapat sitasi tulisan ini dengan:

> Gupta, K., Pambudi, Y., Priyadi, D., & Safa, D. (2025). Bagaimana harga gas bumi tertentu mempengaruhi industri nasional? Unpublished.

atau jika anda menggunakan bibtex:

```{bibtex}
@article{hgbt,
author = {Gupta, Krisna and Pambudi, Yustika and Priyadi, Dhisa and Safa, Dinar},
title = {Bagaimana harga gas bumi tertentu mempengaruhi industri nasional?},
year = {2025},
journal = {Unpublished}
}
```