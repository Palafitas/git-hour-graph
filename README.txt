+++ Sobre +++
Esse projeto cria um relatório dos horários que você faz commits em seus repositórios git utilizando chart.js e exporta os hashs, autor, commits para arquivos separados por projeto (se +1).

+++ Uso +++

chmod +x horas.sh
./horas.sh ~/pasta/dos/projetos/ou/projeto 'nome.autor' '2024-04-26'

A pasta referente ao(s) projeto(s) deve ser o caminho completo, e.g1: /home/usuario/projetos, e.g2: ~/projetos, e.g3: ~/projetos/meu_projeto;
Substituir 'nome.autor' pelo nome do autor dos commits, para ter certeza do nome, pode-se utilizar o comando git log no repositório e idenficar a saída 'Author';
A data '2024-04-26' é referente a data de ínicio para buscar dos commits (colocar sempre 1 dia antes), e.g: Quero filtrar do dia 26/04/2024, devo usar '25/04/2024';

+++ Saída +++
Após executar os comandos acima, será criado 2 pastas no diretório raiz do projeto, uma chamada 'dados' e outra chamada 'relatorio'.

- Dados:
Aqui vão ficar os arquivos .txt dos commits de cada repositório, contendo os hashs, email do autor e a respectiva data. 
Para alterar a forma de apresentação é necessário modificar o script principal (se atentar ao --format do git log e no while read que lê as linhas)

- Relatorio:
Aqui vão ficar os arquivos .txt contendo o total de commits por repositório, um arquivo com todos os commits dos repositórios unidos e um arquivo contendo o gráfico dos horários.
