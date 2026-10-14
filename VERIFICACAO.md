# Verificação da edição CHAVSV

Data: 14/10/2026. Base: 36fbf475d18234b1eb6867d96e0e0bbb59358bd9.

- `npm run build`: aprovado, TypeScript e bundle Vite. Avisos não bloqueantes de depreciação de Sass/Bootstrap e tamanho do bundle herdado.
- `python -m compileall -q backend`: aprovado.
- `python -m unittest discover -s tests -v`: 3 testes aprovados, incluindo senha exata com espaços/Unicode, salt portátil, rejeição de ciphertext adulterado e nonce distinto.
- `git diff --check`: aprovado.
- `backend/classes/encryption.py` e `src/api.ts`: idênticos ao commit de origem.
- Interface em Chromium headless, com APIs locais simuladas e nenhuma conta real: tema inicial CHAVSV, mostrar/ocultar senha, senha incorreta, envio preservando espaços, envio por Enter e exibição da lista após desbloqueio aprovados. Inspeção visual da tela de senha e da lista concluída.
- Ícones do instalador gerados com Tauri CLI.

Não executado neste ambiente Linux: build nativo Windows, instalador NSIS, bandeja e registro Windows, login real Roblox, importação de base real, proteção vinculada ao hardware e abertura de múltiplas instâncias. A preservação do código das demais funcionalidades não equivale a uma validação de todas elas em execução.

O ZIP é um pacote de código-fonte; não contém .exe pronto nem credenciais.
