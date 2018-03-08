

# Azure.iOS [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.com/Azure/Azure.iOS.svg?token=Vc4rMDzP2y3ixqPzXpX7&branch=master)](https://travis-ci.com/Azure/Azure.iOS)

Azure.iOS is a collection of SDKs for rapidly creating iOS apps with modern, highly-scalable backends on Azure.

_**This project is in active development and will change.** As the SDKs become ready for use, they will be versioned and released. We will do our best to conduct all development openly by posting detailed [requirements](/wiki/Requirements) and managing the project using [issues](/issues), [milestones](/milestones), and [projects](/projects)._

# SDKs
The SDKs are broken out by function and are designed to work just as well individually as they do together.
- [AzureCore](#AzureCore)
- [AzureAuth](#AzureAuth)
- [AzureData](#AzureData)
- [AzurePush](#AzurePush)
- [AzureStorage](#AzureStorage)

## AzureCore
![Current State: Requirements](https://img.shields.io/badge/Current_State-Requirements-red.svg)

[AzureCore API Reference](/wiki/AzureCore) and [samples](/wiki/AzureCore) can be found on our [wiki](/wiki).

AzureCore is a shared dependency of the other four SDKs. It will include the following functionality:
- Secure Storage
- Preference Storage
- Reachability
- Logging
- Encoding
- User Agent Generation
- Base Errors

More information on the features to be included in AzureCore can be found the [Requirements](/wiki/Requirements-AzureCore) wiki document.


## AzureAuth
![Current State: Requirements](https://img.shields.io/badge/Current_State-Requirements-red.svg)

[AzureAuth API Reference](/wiki/AzureAuth) and [samples](/wiki/AzureAuth) can be found on our [wiki](/wiki).

AzureAuth is an SDK that enables authentication with popular identity providers SDKs to be used to securely access backend services on [Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/app-service-authentication-overview). AzureAuth will support five identity providers out of the box: Azure Active Directory, Facebook, Google, Microsoft Account, and Twitter. Your app can use any number of these identity providers to provide your users with options for how they sign in.

Azure App Service uses federated identity, in which a third-party identity provider stores accounts and authenticates users. The application relies on the provider's identity information so that the app doesn't have to store that information itself. 

More information on the features to be included in AzureAuth can be found the [Requirements](/wiki/Requirements-AzureAuth) wiki document.


## AzureData
![Current State: Requirements](https://img.shields.io/badge/Current_State-Requirements-red.svg)

[AzureData API Reference](/wiki/AzureData) and [samples](/wiki/AzureData) can be found on our [wiki](/wiki).

AzureData is an SDK for interfacing with [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/sql-api-introduction) - A schema-less JSON database engine with rich SQL querying capabilities. It currently supports the full SQL (DocumentDB) API and development to add offline persistence will start very soon.


More information on the features to be included in AzureData can be found the [Requirements](/wiki/Requirements-AzureData) wiki document.


## AzurePush
![Current State: Requirements](https://img.shields.io/badge/Current_State-Requirements-red.svg)

[AzurePush API Reference](/wiki/AzurePush) and [samples](/wiki/AzurePush) can be found on our [wiki](/wiki).

AzurePush will provide push notification functionality.  The current SDK for Azure Notification Hubs can be found [here](https://github.com/Azure/azure-notificationhubs/tree/master/iOS/WindowsAzureMessaging). The intent is to migrate that SDK to this repository, update it, and refactor the API to ensure it works seamlessly with the other SDKs in this project to provide the best possible developer experience.


More information on the features to be included in AzureData can be found the [Requirements](/wiki/Requirements-AzurePush) wiki document.


## AzureStorage
![Current State: Requirements](https://img.shields.io/badge/Current_State-Requirements-red.svg)

[AzurePush API Reference](/wiki/AzurePush) and [samples](/wiki/AzurePush) can be found on our [wiki](/wiki).

AzureStorage will provide cloud storage functionality.  The current SDK for Azure Storage can be found [here](https://github.com/Azure/azure-storage-ios). The intent is to migrate that SDK to this repository, update it, and refactor the API to ensure it works seamlessly with the other SDKs in this project to provide the best possible developer experience.

More information on the features to be included in AzureStorage can be found the [Requirements](/wiki/Requirements-AzureStorage) wiki document.


# About
This project is in active development and will change. As the SDKs become ready for use, they will be versioned and released.

We will do our best to conduct all development openly by posting detailed [requirements](/wiki/Requirements) and managing the project using [issues](/issues), [milestones](/milestones), and [projects](/projects).

## Contributing
This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).  
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Reporting Security Issues
Security issues and bugs should be reported privately, via email, to the Microsoft Security Response Center (MSRC) at [secure@microsoft.com](mailto:secure@microsoft.com). You should receive a response within 24 hours. If for some reason you do not, please follow up via email to ensure we received your original message. Further information, including the [MSRC PGP](https://technet.microsoft.com/en-us/security/dn606155) key, can be found in the [Security TechCenter](https://technet.microsoft.com/en-us/security/default).

## License
Copyright (c) Microsoft Corporation. All rights reserved.  
Licensed under the MIT License.  See [LICENSE](License) for details.


