# RickAndMortyApp
Rick and Morty!

# Setup guide

## Install Cocoapods

See https://cocoapods.org/
and run 'pod install'

## Install Apollo iOS and CLI (optional)

This project uses Apollo for GraphQL integration. Apollo uses a scheme and .graphql files to generate Swift classes at build time. Be default this has been disabled since the API.swift file is complete. You can choose to install the Apollo CLI to enable this and uncomment the "Run script" build phase.

'npm install -g apollo'

Read more
* https://github.com/apollographql/apollo-tooling
* https://www.apollographql.com/docs/ios/installation/

# Third party plugins

* Apollo for GraphQL integration, 
* PromiseKit for convenient asyncronous programming
* Kingfisher for loading remote images
* UIImageColors for detecting primary colors in images

# Missing parts...

* Empty states
* Error handling (will fail silently)
