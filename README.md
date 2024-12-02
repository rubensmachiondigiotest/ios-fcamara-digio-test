[![Version](https://img.shields.io/badge/Version-1.0.0-green.svg?style=flat-square)](https://img.shields.io/badge/version-1.21.0-green.svg?style=flat-square) [![Swift](https://img.shields.io/badge/Swift-5.7_5.8_5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.7_5.8_5.9-Orange?style=flat-square) [![Platforms](https://img.shields.io/badge/Platforms-iOS-blue.svg?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-blue.svg?style=flat-square) [![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-square)  [![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat-square)](https://opensource.org/licenses/MIT)

# Desafio Técnio Digio via @FCamara

## Requisitos mínimos
- xcode 14.3.1
- Swift 5
- Xcodegen [ver](https://github.com/yonaskolb/XcodeGen)
- Swiftlint [ver](https://github.com/realm/SwiftLint)

## Instalação
Antes de rodar o projeto instale o [Xcodegen](https://github.com/yonaskolb/XcodeGen), para gerar o arquivo `DigioApp.xcodeproj` e opcionalmente instale o [Swiftlint](https://github.com/realm/SwiftLint). Após instalado o Xcodegen abra o terminal e navegue até a pasta do projeto clonado e rode o comando `xcodegen`. Agora já será possível abrir o projeto. `open DigioApp.xcodeproj`

## Dependências
Este projeto possui dependências locais, localizado na pasta `Packages`, e dependências externas instaladas via swiftPackage.

### Locais
 - AppProtocols - Pacote para centralizar abstrações de integrações do app para evitar forte acoplamento
 - DesignSystem - Pacote com componentes, fontes, cores e imagens comuns reutilizados no projeto
 - NetworkKit - Pacote com a implementação da camada de rede do app

### Externas

 - Mocker - Framework que facilita a escrita de testes mockados para testar a camada de rede e serviços da API
 - SDWebImage - Lib para facilitar o download e cache de imagens no app

## Estrutura do projeto
### Infra 
Pasta responsável pela centralização de algumas extensões, injeção de dependências e classes comuns que podem ser utilizadas por outros targets

### Root
Contém o `AppDelegate`, os xcconfigs para os ambientes, `LaunchScreen` e Assets.

### Modules
Aqui são listados todos os módulos do app, como Home e produtos

## Overview
O projeto foi desenvolvido com uma variação do Clean Arch com o Design pattern `MVVM-C`. A navegação entre módulos é feita através do `MainCoordinator` que este por sua vez instancia o coordinator de cada módulo. Esta separação foi pensada para evitar que o `MainCoordinator` atingisse um tamanho muito grande conforme o app evolui.
