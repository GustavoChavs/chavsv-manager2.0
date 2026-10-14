# CHAVSV Account Manager

Personalização do Forked Roblox Account Manager, de hackyue, com identidade CHAVSV, preto/vermelho e botões com efeito de vidro.

## O que você está recebendo

Código-fonte completo e preparação para gerar o instalador Windows. Este pacote NÃO contém um .exe compilado. O aplicativo usa Tauri/Rust, interface TypeScript e backend Python. Bootstrap 5.3.8 foi integrado de forma restrita às telas de desbloqueio e mudança de criptografia para evitar conflitos no restante da interface.

- Tema CHAVSV Glass selecionado por padrão em uma instalação nova.
- Ícone CHAVSV e identificação no aplicativo, bandeja e instalador.
- Tela de senha mestra redesenhada, em português, com mostrar/ocultar, Caps Lock, foco de teclado e bloqueio de envio duplicado.
- Senhas com espaços no início/fim são enviadas sem alteração.
- AES-256-GCM, derivação de chave e formato de criptografia originais preservados.
- Demais telas, funções e integrações do projeto mantidas no código. A interface fora da tela de desbloqueio permanece majoritariamente em inglês.
- Dados da edição CHAVSV em `%LOCALAPPDATA%\CHAVSV Account Manager\data`, separados da instalação original.
- Verificação automática de atualizações FRAM desativada por padrão. O atualizador manual foi preservado e identifica que oferece versões do projeto original, sem o tema CHAVSV.

## Gerar o instalador no seu Windows

Requisitos: Windows 10/11 x64, Node.js 20, Python 3.11 com o comando `py`, Rust com Cargo, Visual Studio Build Tools com a carga de trabalho **Desenvolvimento para desktop com C++** e Windows SDK. O aplicativo Tauri usa o WebView2.

1. Extraia este ZIP inteiro para uma pasta, por exemplo `C:\CHAVSV`.
2. Instale os requisitos acima. Reabra o terminal depois de instalá-los.
3. Execute `GERAR-EXE-CHAVSV.bat` dentro da pasta extraída.
4. Aguarde o download das dependências e a compilação. Se houver erro, o script para e mostra a mensagem.
5. O instalador ficará em `src-tauri\target\release\bundle\nsis\`, com o nome CHAVSV Account Manager e final `-setup.exe`.

O script usa um ambiente Python `.venv` isolado. Internet é necessária na primeira compilação. Nenhuma conta Roblox, senha mestra ou cookie deve ser colocado no código para compilar. O instalador gerado não recebe assinatura digital neste processo.

## Alternativa pelo GitHub Actions

A pasta `.github/workflows/ci.yml` contém a tarefa **Build CHAVSV**, executada em Windows. Em um repositório seu que contenha estes arquivos, abra **Actions > Build CHAVSV > Run workflow**. Ao terminar com sucesso, baixe o artefato **CHAVSV-Windows-installer**. Este pacote não foi enviado nem publicado em sua conta GitHub.

## Trazer contas existentes

Feche o gerenciador original antes de iniciar a edição CHAVSV: ambos usam o serviço local na porta 5050. Use a importação do assistente inicial para selecionar a pasta de dados original. Informe a senha mestra original se os dados estiverem criptografados por senha. Não apague a pasta original antes de verificar todas as contas no CHAVSV. Dados protegidos por hardware dependem do computador e da configuração original; não trate a cópia simples entre computadores como garantia de recuperação.

Se uma importação trouxer outro tema, selecione **Settings > Appearance > CHAVSV Glass**. A senha mestra não pode ser recuperada se for esquecida.

## Verificações e limites

A compilação TypeScript/Vite passou. Os testes em `tests/test_encryption.py` validam leitura com a senha exata e salt exportado, rejeição de senha diferente, rejeição de ciphertext adulterado e nonces distintos. O módulo `backend/classes/encryption.py` não foi alterado.

A compilação nativa Windows, instalação, login real, abertura de Roblox e operações com contas reais precisam ser verificadas no Windows. Não foi realizada auditoria completa de segurança das integrações herdadas. Consulte `VERIFICACAO.md` para os resultados desta entrega.

## Origem e licença

Base: https://github.com/hackyue/ForkedRobloxAccountManager
Commit: 36fbf475d18234b1eb6867d96e0e0bbb59358bd9 (branch Windows).
Créditos originais, README e licença GPL-3.0 preservados. Personalização CHAVSV em 14/10/2026. O código modificado segue a licença GPL-3.0. Bootstrap usa licença MIT, incluída em `THIRD-PARTY-LICENSES/Bootstrap-LICENSE`.
