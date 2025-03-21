# RISC MIPS Eğitim dökümanı

## Gereklilikler
* Debian Based GNU Linux
### Çalıştırma adımları
* Gerekli paketlerin yüklenmesi
```bash
~$ sudo apt update -y && sudo apt install spim -y
```
### Yetki adımları
* Dosyaya çalıştırılabilir yetkisi verilmesi ve çalıştırılması.
```
~$ chmod +x ./toybox/calculator.asm
~$ spim -file ./toybox/calculator.asm
```

