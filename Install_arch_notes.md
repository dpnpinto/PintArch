# How to make a manual Arch Linux Install - After boot from the oficial Arch ISO

## Minha versão de instalação automatizada do Arch

PintArch.sh disponivel em https://github.com/dpnpinto/PintArch 

## Consultar sempre a Arch Wiki para confirmação das opções disponiveis

 * https://wiki.archlinux.org/
 * https://www.youtube.com/watch?v=rUEnS1zj1DM - Exemplo

## Colocar o teclado em PT de Portugal

* Para encontrar os mapas de teclas **localectl list-keymaps | grep pt**
* **loadkeys pt-latin1** 
nota: o traço "-" no teclado em ingles é na tecla do apóstrofo "'"
* Aumentar o tamanho da fonte, para verem melhor, **setfont ter-132n**

## Ver se tem internet

* **ping www.google.com**

## Acertar o relogio

* **timedatectl set-ntp true**

## Se pretender utilizar o WIFI utilizar o iwctl
**iwctl**
* device list (para saber o nome do dispositivo)
* station nomedispositivo scan (ver as redes disponiveis)
* station nomedodispositivo get-network (listar as redes)
* station nomedodispositivo connect nomedarede (por fim para se ligar à rede WIFI)

## Configuração do disco
* **fdisk -l** (listar todos os discos disponiveis)
* **fdisk -l /dev/discopretendido** (ver todas as partições no disco)
* **cfdisk /dev/discopretendido** (criar as partições pretendidas)
*  Recomenda-se o formato de tabela **GPT**
*  lsblk (para ver como ficou os discos e as partições)

Exemplo:
* /dev/sda1 (1G para o /boot e /boot/efi)
* /dev/sda2 (2GB para swap)
* /dev/sda3 (30GB para /, root)

verificar se tem sistema EFI ou BIOS
* dmesg | grep "EFI v"
* ls /sys/firmware/efi/efivars (outra forma de ver se arrancou por EFI)

Definir os tipos de sistema de ficheiros
* Para o GRUP - EFI System ou BIOS boot (conforme o sistema que tem)
* Swap - Linux Swap
* Restantes partições - Linux filesystem

Se pretendermos ter uma /home separado
* /dev/sda4 (todo o resto para o /home)

## Formatar partições

* Partição de boot - **mkfs.fat -F32 /dev/sda1** (indicar partição selecionada)
* Fartição Swap - **mkswap /dev/sda2** (indicar a partição selecionada)
* Partições do sistema **mkfs.ext4 /dev/sda3** (indicar as partição) 

## Pontos de montagem  do sistema

* **mount /dev/sda3 /mnt** (partição e raiz do sistema)
* **mkdir /mnt/home**  (criar diretorio home)
* **mkdir /mnt/boot** (criar diretorio boot)
* **mkdir /mnt/boot/efi** (criar diretorio UEFI para o caso de utilizar UEFI)
* **mount /dev/sda1 /mnt/boot** (montado a partição boot apenas para EFI em BIOS GPT não montar partição)
* **mount /dev/sda1 /mnt/boot/efi** (montado a partição UEFI se for utilizar)
* **swapon /dev/sda2** (Ativando a swap)

## verificar como ficou o sistema de ficheiros

* **lsblk** (caso seja necessário corrigir ou alterar voltar aos pontos anteriores)

## Otimizar os mirrows para descarregar os pacotes

* **vim /etc/pacman.d/mirrorlist** (se não tiver instalado o vim instalar o editor ou utilizar outro)
* De forma automatica
   - pacman -Sy reflector
   - reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

## Instalar os pacotes base do Arch Linux

* **pacstrap -K /mnt base base-devel linux linux-firmware vim networkmanager "xpto"-ucode**
   * Nota : xpto -> depnde do CPU que estás a utilizar mas connvem instalar o microcódigo especifico. 
* -K inicia as chaves do pacman e não utiliza as do host de instalação
Neste passo, instalaremos o metapacote base e o grupo base-devel, além do kernel Linux padrão do Arch, o firmware para hardware comum, o editor de texto “vim” e o NetworkManager
* linux - instala o kernel estável (http://www.kernel.org). Pode-se instalar outro tipo, por exemplo o Zen Kernel, com **linux-zen**.
* xpto-ucode intel-ucode/amd-ucode - atualziações de estabilidade e segurança da Intel/AMD 
* Se necessário atualizar as chaves

    pacman -Syy
    pacman -S archlinux-keyring
    pacman-key --populate archlinux
    pacman-key --populate archlinux32 (apenas para o de 32 bit)  
    pacman-key --refresh-keys
    - Desativar a verificação (Arch32) colocar 'SigLevel = Never' em /etc/pacman.conf (não aconselhavel, perdes a verificação dos pacores)


* systemctl list-unit-files --state=enabled

## Gerar a tabela de FSTAB

Após instalar os pacotes essenciais é necessário gerar a tabela FSTAB, que vai dar a indicação ao sistema onde estão montadas cada uma das partições.
* **genfstab -U /mnt >> /mnt/etc/fstab**
   * Nota: **-U para colocar o UUID no lugar dos nomes dos devices para gatantir que está sempre a utilizar o mesmo dispositivo**

Devem sempre verificar se a tabela está correta
* **cat /mnt/etc/fstab**

## O sistema está configurado vamos passar para dentro dele

* **arch-chroot /mnt** (tudo o que é feito daqui para a frente é efetuado dentro já do sistema Arch instalado no disco)

## Configurar data e hora do nosso sistema operativo

* **ln -sf /usr/share/zoneinfo/Região/Cidade /etc/localtime**
* Zonas em /usr/share (efetuar ls para ver)
* Também pode utilizar **timedatectl list-timezones | grep Azores**

No caso dos Açores

* **ln -sf /usr/share/zoneinfo/Atlantic/Azores /etc/localtime**

Sincronizar o relógio

* **hwclock \--systohc**

Conferir se a data ficou correta

* **date**

## Alterar o idioma do sistema

* **vim /etc/locale.gen** ( tirar o # comentário do idioma pretendido pt_PT* )
* **locale-gen** (gerar o local tendo por base o ficheiro locale.gen)
* **echo KEYMAP=pt-latin1 >> /etc/vconsole.conf** (colocar o mapa de teclas correto na configuração da consola)
* **echo LANG=pt_PT.UTF-8 >> /etc/locale.conf** (defenir a variavel LANG adequadamente)

## Configurações gerais do novo sistema operativo

* **vim /etc/hostname** (colocar na primeira linha o nome do equipamento)
* **passwd** (mudar a palavra passe do utilizador root)
* **mkinitcpio -P** confirmar o ficheiro **/etc/mkinitcpio.conf** 
### criar um novo utilizador

* **useradd -m -g users -G wheel,storage,power -s /bin/bash nomedoutilizador**
* **passwd nomedoutilizador** (colocar palavra passe nesse utilizador)
* Editar o **pacman.conf** em /etc e colocar:
- VerbosePkgLists (descritivo dos pacotes)
- ParallelDownloads = 5 (descarregar 5 ficheiros em simultaneo)
- ILoveCandy (para ficar em modo pacman C-o-)

## Instalar pacotes uteis

* **pacman -S man dosfstools os-prober mtools networkmanager** 
* Ativar networkmanager (systemd) **sudo systemctl enable NetworkManager.service**

* systemctl list-unit-files --state=enabled

## Instalar o GRUB (Boot Loader)

* **dmesg | grep "EFI v"** (verificar se o sistema arrancou com EFI)
* **ls /sys/firmware/efi/efivars** (outra forma se não existe não é EFI)

### Se for BIOS

* **pacman -S grub** (instalar o GRUB)
* **grub-install --target=i386-pc --recheck /dev/sda** (instalar o GRUB na partição Boot em fat 32)
* **grub-mkconfig -o /boot/grub/grub.cfg** (gerar a configuração GRUB)

### Se for UEFI

* **pacman -S grub efibootmgr** (instalar o GRUB e o efibootmgr)
* **grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck** (instalar o GRUB na pasta efi)
* **grub-mkconfig -o /boot/grub/grub.cfg** (gerar a configuração GRUB)

# Feita instalação base

* **exit** (para sair do sistema instalado)
* **umount** /mnt no live CD de instalação desmontar o /mnt que está no sda3
* **swapoff /dev/sda2** desligar a swap
* tirar a pen/cd de arranque do Arch do computador e **reboot**
## Depois de arrancar

## Dar permissões ao grupo wheel para executar comandos de administração

* Entrar com root
* **vim /etc/sudoers** editar o ficheiros e colocar o grupo wheel como permissões de utilizar todos os comandos
* Esta linha **%wheel ALL=(ALL) ALL** dá acesso mas pedidos passwd
* Sair do utilziador root e entrar com o utilziador definido

### Arrancar com dhcp

* **sudo systemctl start dhcpcd.service**
* **sudo systemctl enable dhcpcd.service** ativar o serviço de dhcp
* **ip a** pode verificar se a placa de rede já tem a informação relativamente aos dados recolhidos pelo dhcp
* Instalar outros pacotes de software importantes **sudo pacman -S

### Ativar o acesso remoto por OpenSSH

* Neste ponto ter cuidado se for um servidor disponivel na inetrnet. Por exemplo limitar o acesso ao utilizador root e ativar ssh apemas para alguns utilizadores ou grupos
* **sudo pacman -S openssh** Instalar o serviço Open SSH. Normalmente já vem instlado o cliente para permitir acesso por ssh
* **systemctl start sshd.service**  Arrancar com o serviço
* **systemctl enable sshd.service**  Ativar o serviço no arranque

### Ativar o acesso ao repositorio Multilib

* O repositório Multilib permite a utilziação de aplicações 32 bit em sistemas 64 bit, por exemplo pelas aplicações Steam e Wine
* Edicatar o ficheiro de configuração do pacman com **sudo vim /etc/pacman.conf**
* Retirar os comentário **#** das linhas
  - [multilib]
  - Include = /etc/pacman.d/mirrorlist
* Pode confirmar que já tem este repositório com **pacman -Sy**
* Pode ver os pacotes do repositorio MultiLib com **pacman -Sl multilib**

### Melhorar o PACMAN

* Editar o pacman.conf (está dentro do /etc) **sudo vim /etc/pacman.conf**
* Ir até # Misc options

* Color (tirar o # para ficar com cores)
* VerbosePkgLists (tirar o # para detlhar os pacotes)
* ParallelDownloads=5  (tirar o # para descarreagar em apralelo 5 pacotes)
* ILoveCandy (Adicionar para ficar com o efeito do jogo pacman) 

### ATivar o TRIM nos discos SSD

* Este serviço faz parte do pacote util-linux
* Basta ativar o serviço de timer com **sudo systemctl enable fstrim.timer**
* O serviço de fstrim será utilziado semanalmente

## Instalar o ambiente grafico (GUI)

### Instalar X Window System Xorg

* **lspci | grep -e VGA -e 3D** identificar a placa de video com o **lspci** e com a indentificação de padrões (-e) do **grep**
* **sudo pacman -S xorg xorg-xinit**
* xorg - ambiente gráfico
* xorg-xinit - para arrancar o ambiente grafico **startx** recorrendo ao ficheiro .xinitrc
* No caso do Virtuabox instalar **sudo pacman -S virtualbox-guest-utils open-vm-tools xf86-video-vmware**
* **cp /etc/X11/xinit/xinitrc ~/.xinitrc** start do X e ambiente de janelas pretendido

### Não é necessário ter um display manager para arrancar com o ambiente gráfico

* no ficheiro **.bash_profile** (perfil do utilizador) arrancar automaticamente o xorg com **startx**
  ...
   * if [ -z "$(DISPLAY)" ] && [ "$(XDG_VTMR)" -eq 1 ] ; then
   *         exec startx
   * fi
  ...
### Intalar o Aplication Launcher Rofi

* **sudo pacman -S rofi** Instalar o Rofi

### Intalar o emulador de terminal PintoST

* **git clone https://github.com/dpnpinto/PintoST**
* **sudo male clean Install**
  
### Instalar o Windows Manager PintoDWM

* **git clone https://github.com/dpnpinto/PintoDWM**
* **sudo male clean Install**

### Instalar a barra de controle PintoDWMBlocks

* **git clone https://github.com/dpnpinto/PintoDWMBlocks**
* **sudo male clean Install**

### Instalar o PipeWire (melhor que o Pulseaudio)

* **sudo pacman -S pipewire pipewire-jack pipewire-alsa pipewire-pulse qjackctl**
* **sudo pacman -S lib32-pipewire lib32-pipewire-jack** para suporte multilib**
* For noire canceelation easy efects is the way then **sudo pacman -S easyeffects**
* https://wiki.archlinux.org/title/PipeWire
* https://www.youtube.com/watch?v=5a7_2mA2LYQ
