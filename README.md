# RickAndMortyApp
Rick and Morty!

# Setup guide

## 1. Install Apollo CLI (or don't)

This project uses Apollo for GraphQL integration. Apollo uses a scheme and .graphql files to generate Swift classes at build time. You can chose to either install the Apollo CLI to enable this OR remove the "Run script" build phase.

See https://github.com/apollographql/apollo-tooling

## 2. Install Cocoapods

See https://cocoapods.org/
and run 'pod install'

# Third party plugins

This project uses Apollo for GraphQL integration, PromiseKit for convenient asyncronous programming and Kingfisher for loading remote images.

# Missing parts...

* Empty states
* Error handling (will fail silently)
