# RickAndMortyApp
Rick and Morty!

# Setup guide

## 1. Install Apollo CLI (or don't)

This project uses Apollo for GraphQL integration. Apollo uses a scheme and .graphql files to generate Swift classes at build time. You can choose to either install the Apollo CLI to enable this *OR* remove the "Run script" build phase since API.swift has already been generated.

'npm install -g apollo'

See https://github.com/apollographql/apollo-tooling

## 2. Install Cocoapods

See https://cocoapods.org/
and run 'pod install'

# Third party plugins

* Apollo for GraphQL integration, 
* PromiseKit for convenient asyncronous programming
* Kingfisher for loading remote images
* UIImageColors for detecting primary colors in images

# Missing parts...

* Empty states
* Error handling (will fail silently)
