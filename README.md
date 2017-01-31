# README #

Projeto criado para teste de avaliação de Swift e iOS, com respectivo negócio de buscar dados de contatos da API, salvar os mesmos localmente e contemplar a alteração, criação e exclusão do contato.

### Bibliotecas utilizadas ###

Utilizado Pods para gerenciamento das Libs.

* SwiftJSON -> utilizada para deserialização do JSON de resposta da API
* Siesta e SiestaUI -> Utilizado para requisições Http, utilizei também o SiestaUI para fazer o loading das imagens com o componente de imagens da própria Lib, utilizei o Siesta exatamente por ter essa Lib de adendo para componentes de UI, que facilita o loading das imagens sem ter que criar uma task de download para carregar a mesma.
* RealmSwift -> utilizado como banco de dados local, tive como escolha o mesmo para poder ressaltar minha habilidade de trabalhar com o Realm, assim como vocês já trabalham.
* RxSwift e RxCocoa -> utilizado para compor a programação reativa do App com seus respectivos Observables, utilizei os mesmos para compor a arquitetura apresentada com DataProvider e a reatividade dos objetos manipulados no banco de dados local e requisições Http, foi utilizado classes Helper de extension para o Realm compor os observables.
* IGListKit -> utilizado para fazer um compare nos objetos e tomar suas ações na TableView na func de Reload com base na ViewModel;


### Geração do App ###

Utilizei como arquitetura o Mvvm com DataProvider, que se refere a uma arquitetura em que uma requisição Http é solicitada e espelhada em um banco de dados local, para contemplar o funcionamento do App Offline. Crie o App em etapas, começando pela estruturação dos arquivos e pastas, classes de apoio a conexão com API, banco de dados Local, e logo após a criação dos modelos, viewmodels, controllers e views. Utilizei Xib para as views, e para navegação das telas em si, utilizei um pattner Route que por sua vez tem a responsabilidade de aplicação da injeção de dependência. Criei também um campo id para os modelos, com responsabilidade de chave primária no banco de dados local, o mesmo não se encontra no modelo de resultado da API.

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Melhorias a serem implementadas ###

* Testes unitários
* Melhoria no Layout
* Implementação de seleção de data de nascimento com UIPickerView
* Implementação de escolha de foto e salvar local
* Utilização da ViewModel para ter responsabilidade absoluta dos Observables e criação dos Factorys.