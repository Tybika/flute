PT-BR
# flute
Um pequeno framework para construção de jogos narrativos móveis que simulam ambiente flutter para resolução de problemas, onde o jogador pode interagir com o próprio jogo que está jogando.

# Como instalar
## Jogador
Baixe o APK mais recente no repositório:

[Baixar APK do flute](PASTE_APK_REPOSITORY_PAGE_LINK_HERE)

Depois de baixar o APK no seu dispositivo Android:

1. Abra o arquivo `.apk` baixado.
2. Se o Android bloquear a instalação, toque na opção para permitir instalações desta fonte.
3. Confirme a instalação.
4. Quando a instalação terminar, abra o **Flute** pela sua lista de aplicativos.

Se o celular pedir permissão para instalar apps desconhecidos, isso é esperado para arquivos APK baixados fora da Play Store. Você pode desativar essa permissão novamente depois de instalar, para manter sua segurança.


## Desenvolvedor
Em breve


EN
# flute
A tiny framework to build a mobile narrative game that simulates a Flutter ambient to problem-solve, where players can interact with the very game they are playing.

# How to install
## Player installation

Download the latest APK from the repository:

[Download flute APK](https://github.com/Tybika/flute/blob/main/Flute.apk)

After downloading the APK on your Android device:

1. Open the downloaded `.apk` file.
2. If Android blocks the installation, tap the option to allow installs from this source.
3. Confirm the installation.
4. After the install finishes, open **flute** from your app list.

If your phone asks for permission to install unknown apps, this is expected for APK files downloaded outside the Play Store. You can disable that permission again after installing.

## Developer
**IMPORTANT: this project is passing by a big refactor, please, await to contribute without rework. Max date to refactoring: Dec. 2026**

### Contributors 

### Version and project info

Godot 4.6.1

### How this project is organized

According Godot Docs, the scenes and their resources are grouped by generic directories named by function, in resume:
1. "res://characters" groups scenes with sprites, animations and physics 
2. "res://levels" groups scenes with tilemap, background and characters
3. "res://ui" groups scenes with sprites, layout and interface events
4. "res://problems" groups the problems data resources
5. "res://dialogues" groups the dialogues data resources
6. "res://globals" groups global variables and global scripts


### How to customize Flute

Locales and acessibility are still unavailable.
Despite you can alter all project, the extensible part are problems and their calls, so you can develop more problems or complex the existent and replace the original problems. The sctructure of a problem will be socumented soon.
