# Manutenção do Arch Linux

Para manter se manter o Arch Linux saudável, já que ele é Rolling Release (atualização contínua) temos de ter em atenção alguns aspectos.
A vantagem é que temos sempre o software mais recente, o desafio é que, se não cuidarmos do sistema este pode ficar com ficheiros desnecessários.
Aqui está um guia prático de como manter o seu Arch Linux funcionando perfeitamente:

1. A Regra de Ouro: Leia as Notícias
Antes de qualquer atualização grande, visite a página inicial do Arch Linux. Se houver uma mudança manual necessária (intervenção do utilizador), ela estará lá indicada.Isso evita 90% das quebras de sistema.

2. Atualização do Sistema (Frequência: Semanal ou Diária)
Nunca faça atualizações parciais. Sempre atualize o sistema inteiro de uma vez.
Comando: sudo pacman -Syu

Nota: Nunca use pacman -Sy (sem o u) para instalar um pacote, pois isso pode criar conflitos de versão (partial upgrade).
Se você usa AUR (Arch User Repository): Se você usa um auxiliar como yay ou paru, eles já atualizam o sistema e o AUR juntos:

yay
# ou
paru

3. Gestão de Espelhos/Mirrors (Frequência: Mensal)
Seus downloads estão lentos? A lista de espelhos pode estar desatualizada. O pacote reflector automatiza a escolha dos servidores mais rápidos e recentes.
Instale: sudo pacman -S reflector
Atualize a lista (exemplo para ir buscar os 5 mais rápidos de Portugal/Mundo):
sudo reflector --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

4. Limpeza do Sistema (Frequência: Mensal)

A) Remover Pacotes Órfãos. Ao remover programas, as dependências (bibliotecas) que eles usavam podem ficar para trás.

Comando:
sudo pacman -Rns $(pacman -Qdtq)
Se o comando der erro dizendo que "nenhum alvo foi especificado", parabéns! Seu sistema está limpo.

B) Limpar o Cache do Pacman
O Arch guarda todas as versões antigas dos pacotes que você baixa no cache (/var/cache/pacman/pkg/). Isso pode encher o disco.
Instale o pacote de ferramentas: sudo pacman -S pacman-contrib
Para manter apenas as 2 versões mais recentes (seguro):
sudo paccache -rk2

Para remover cache de programas desinstalados:
sudo paccache -ruk0

C) Limpar Logs do Systemd
Os logs podem ocupar, com o tempo, gigabytes.
Verificar tamanho: journalctl --disk-usage
Limpar e deixar apenas as últimas 2 semanas:
sudo journalctl --vacuum-time=2weeks

5) Arquivos de Configuração (.pacnew)
Quando uma atualização muda um arquivo de configuração que você já editou, o Pacman não sobrescreve o seu. Ele cria um arquivo .pacnew. Você precisa verificar se há mudanças importantes.
Ferramenta recomendada: pacdiff (vem no pacman-contrib).

sudo pacdiff

Ele vai mostrar as diferenças e perguntar se você quer sobrescrever, manter o seu ou mesclar (merge). Na dúvida, pesquise antes de aceitar a mudança.

6) A Rede de Segurança: Backups (Timeshift, não utilizo)
Como o Arch é muito dinâmico, ter um "ponto de restauração" é essencial para não perder tempo de trabalho no Hotel ou na Sauna.
Recomendação: Instale o Timeshift.

sudo pacman -S timeshift
Configure-o para fazer um "snapshot" diário ou semanal. Se uma atualização quebrar o sistema, você pode restaurar o estado anterior direto do GRUB (se configurado) ou via Live USB em minutos.
