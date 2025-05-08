# Como fazer uma instalação base do Arch Linux
By  https://dpnpinto.github.io

* [BASH Arch Install PintArch](#BASH-Arch-Install-PintArch)
* [Arch Linux Wiki e video](#Arch-Linux-Wiki-e-video)
* [Colocar o teclado em PT de Portugal](#Colocar-o-teclado-em-PT-de-Portugal)
* [Verificar se tem internet](#Verificar-se-tem-internet)
* [Para WIFI utilizar o iwctl](#Para-WIFI-utilizar-o-iwctl)
* [Acertar data](#Acertar-data)
* [Configurar o disco](#Configurar-o-disco)
* [Formatar](#Formatar)
* [Montagem do sistema](#Montagem-do-sistema)
* [Otimizar mirrorlist](#Otimizar-mirrorlist)
* [Instalar a base do Arch Linux](#Instalar-a-base-do-Arch-Linux)
* [Gerar a tabela FSTAB](#Gerar-a-tabela-FSTAB)
* [Entrar no novo sistema](#Entrar-no-novo-sistema)
* [Configurar data e hora do novo sistema](#Configurar-data-e-hora-do-novo-sistema)
* [Alterar o idioma do novo sistema](#Alterar-o-idioma-do-novo-sistema)
* [Complementar novo sistema](#Complementar-novo-sistema)
* [Instalar o GRUB](#Instalar-o-GRUB)
* [Concluir sistema base Arch Linux](#Concluir-sistema-base-Arch-Linux)


## BASH Arch Install PintArch

PintArch.sh disponivel em https://github.com/dpnpinto/PintArch

## Arch Linux Wiki e video

* https://wiki.archlinux.org/
* https://www.youtube.com/watch?v=rUEnS1zj1DM - Exemplo

## Colocar o teclado em PT de Portugal

* Para encontrar os mapas de teclas **localectl list-keymaps | grep pt**
* **loadkeys pt-latin1** 
nota: o traço (**-**) no teclado em ingles é na tecla do apóstrofo (**'**)
* Aumentar o tamanho da fonte, para verem melhor, **setfont ter-132n**

## Verificar se tem internet

* **ping -c 3 www.google.com**

## Para WIFI utilizar o iwctl
**iwctl**
* device list (para saber o nome do dispositivo)
* station nomedispositivo scan (ver as redes disponiveis)
* station nomedodispositivo get-network (listar as redes)
* station nomedodispositivo connect nomedarede (por fim para se ligar à rede WIFI)

## Acertar data

* **timedatectl set-ntp true**

## Configurar o disco

* **fdisk -l** (listar todos os discos disponiveis)
* **fdisk -l /dev/discopretendido** (ver todas as partições no disco)
* **cfdisk /dev/discopretendido** (criar as partições pretendidas)
* Recomenda-se o formato de tabela **GPT**
  * **GPT** - "GUID Partition Table"
  * **MBR** - "Master Boot Record"
* lsblk (para ver como ficaram as partições)

Exemplo:
* /dev/sda1 (1G para o /boot e /boot/efi)
* /dev/sda2 (2GB para swap)
* /dev/sda3 (30GB para /, root)

verificar se tem sistema EFI ou BIOS
* dmesg | grep EFI
* ls /sys/firmware/efi/efivars (outra forma de ver se arrancou por EFI)

Definir os tipos de sistema de ficheiros
* Para o GRUP - EFI System ou BIOS boot (conforme o sistema que tem)
* Swap - Linux Swap
* Restantes partições - Linux filesystem

Se pretendermos ter uma /home separado
* /dev/sda4 (todo o resto para o /home)

## Formatar

* Partição de boot - **mkfs.fat -F32 /dev/sda1** (indicar partição selecionada)
* Fartição Swap - **mkswap /dev/sda2** (indicar a partição selecionada)
* Partições do sistema **mkfs.ext4 /dev/sda3** (indicar a/s partição/ões) 

## Montagem do sistema

* **mount /dev/sda3 /mnt** (partição e raiz do sistema)
* **mkdir /mnt/boot/efi** (criar apenas para o caso de ser EFI)
* **mount /dev/sda1 /mnt/boot** (montar a partição boot apenas para EFI, em BIOS não montar partição)
* **swapon /dev/sda2** (Ativando a swap)

* verificar como ficou o sistema de ficheiros
  * **lsblk** (caso seja necessário corrigir ou alterar voltar aos pontos anteriores)

## Otimizar mirrorlist

* **vim /etc/pacman.d/mirrorlist** (se não tiver instalado o vim instalar o editor ou utilizar outro)
* De forma automatica
   - pacman -Sy reflector
   - reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

## Instalar a base do Arch Linux

Neste passo, instalaremos o metapacote base e o grupo base-devel, além do kernel Linux padrão do Arch, o firmware para hardware comum, o editor de texto (vim) e comunicaçoes (NetworkManager)

* **pacstrap -K /mnt base base-devel linux linux-firmware vim networkmanager "xpto"-ucode**
* -K inicia as chaves do pacman e não utiliza as do host de instalação
* linux - instala o kernel estável (http://www.kernel.org). Pode-se instalar outro tipo, por exemplo o Zen Kernel, com **linux-zen**.
* xpto-ucode - intel-ucode/amd-ucode, atualziações de estabilidade e segurança da Intel/AMD 

## Gerar a tabela FSTAB

Após instalar os pacotes essenciais é necessário gerar a tabela FSTAB, que vai dar a indicação ao sistema onde estão montadas cada uma das partições.

* **genfstab -U /mnt >> /mnt/etc/fstab**
   * Nota: **-U para colocar o UUID no lugar dos nomes (-L) dos devices para gatantir mais fiabilidade**

Devem sempre verificar se a tabela está correta
* **cat /mnt/etc/fstab**

## Entrar no novo sistema

O sistema está configurado vamos passar para dentro dele

* **arch-chroot /mnt**
  * Nota: tudo o que é feito daqui para a frente é efetuado dentro já do sistema Arch instalado no disco)

## Configurar data e hora do novo sistema

* **ln -sf /usr/share/zoneinfo/Região/Cidade /etc/localtime**
* Zonas em /usr/share/zoneinfo (efetuar ls para ver ou autocomplete no comando ln)
* Podem também utilizar **timedatectl list-timezones | grep Azores**

No caso dos Açores

* **ln -sf /usr/share/zoneinfo/Atlantic/Azores /etc/localtime**
  * Notas: -s para criar um link simbolico e o -f para forçar, se já existir apaga a cria novo
Sincronizar o relógio

* **hwclock --systohc** - Sicronizar o relógio de Hardware com os valores do relógio do sistema
  *Nota: --systohc significa "system to hardware clock"

Conferir se a data ficou correta

* **date**

## Alterar o idioma do novo sistema
Em /etc temos de ter os seguintes ficheiros:
- locale.gen - Define quais os locais (locales) que estão disponíveis para serem utilizados;
- vconsole.conf - Este ficheiro configura a consola virtual (os TTYs), tem as variaveis KEYMAP e FONT;
- locale.conf - Defefinição da variaveis no inicio do sistema pelo SystemD, vamos colocar a variavel LANG.

* **vim /etc/locale.gen** ( tirar o # comentário do idioma pretendido pt_PT* )
* **locale-gen** (gerar o local tendo por base o ficheiro locale.gen)
* **echo KEYMAP=pt-latin1 >> /etc/vconsole.conf** (colocar o mapa de teclas correto na configuração da consola)
* **echo LANG=pt_PT.UTF-8 >> /etc/locale.conf** (defenir a variavel LANG adequadamente)

## Complementar novo sistema

* **vim /etc/hostname** (colocar na primeira linha o nome do equipamento)
* **passwd** (mudar a palavra passe do utilizador root)
* **mkinitcpio -P** confirmar o ficheiro **/etc/mkinitcpio.conf** 

### Criar um novo utilizador

* Se for para criar um utilizador com permissões de administração por sudo
  * Instalar o sudo **pacman -S sudo**
  * Editar o ficheiro de sudo (/etc/sudoers) e tirar o **#** em **%wheel ALL=(ALL:ALL) ALL**, para que possa associar o utilizador a esse grupo de admin. 
* **useradd -m -g users -G wheel,storage,power -s /bin/bash nomedoutilizador**
  * Notas: -m para criar diretório home do utilizador, -g para defenir grupo primário, -G para defenir grupos segundários e -s para defenir o Shell padrão
* **passwd nomedoutilizador** (colocar palavra passe nesse utilizador)

### Melhorar o pacman

* Editar o **pacman.conf** em /etc e descomentar:
  * VerbosePkgLists (descritivo dos pacotes)
  * ParallelDownloads = 5 (descarregar 5 ficheiros em simultaneo)
  * Color (cores no pacman)
  * ILoveCandy (adicionar para ficar em modo pacman C-o-)

### Instalar outros pacotes uteis

exemplo:
* **pacman -S man dosfstools os-prober mtools**

### Ativar rede

Ativar o inicio automatico do serviço de comunicações e verificar serviços com arranque automático 
* Ativar networkmanager (systemd) **systemctl enable NetworkManager.service**
* systemctl list-unit-files --state=enabled
  *Nota: Podem sempre ativar e desativar o serviço a qualquer momento

## Instalar o GRUB

* **dmesg | grep EFI** (verificar se o sistema arrancou com EFI)
* **ls /sys/firmware/efi/efivars** (outra forma de verificar se é EFI)

### Se for BIOS

* **pacman -S grub** (instalar o GRUB)
* **grub-install --target=i386-pc --recheck /dev/sda** (instalar o GRUB na partição Boot em fat 32)
* **grub-mkconfig -o /boot/grub/grub.cfg** (gerar a configuração GRUB)

### Se for UEFI

* **pacman -S grub efibootmgr** (instalar o GRUB e o efibootmgr)
* **grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck** (instalar o GRUB na pasta efi)
* **grub-mkconfig -o /boot/grub/grub.cfg** (gerar a configuração GRUB)

## Concluir sistema base Arch Linux

* **exit** (para sair do sistema instalado)
* **umount** /mnt no live CD de instalação desmontar o /mnt que está no sda3
* **swapoff /dev/sda2** desligar a swap
* tirar a pen/cd de arranque do Arch do computador e **reboot**
  
Depois de arrancar
* Entrar com root
