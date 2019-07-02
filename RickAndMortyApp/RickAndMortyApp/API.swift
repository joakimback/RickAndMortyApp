//  This file was automatically generated and should not be edited.

import Apollo

public final class FetchCharactersQuery: GraphQLQuery {
  public let operationDefinition =
    "query FetchCharacters($page: Int = 1) {\n  characters(page: $page) {\n    __typename\n    results {\n      __typename\n      ...CharacterDetails\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CharacterDetails.fragmentDefinition) }

  public var page: Int?

  public init(page: Int? = nil) {
    self.page = page
  }

  public var variables: GraphQLMap? {
    return ["page": page]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("characters", arguments: ["page": GraphQLVariable("page")], type: .object(Character.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(characters: Character? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "characters": characters.flatMap { (value: Character) -> ResultMap in value.resultMap }])
    }

    /// Get the list of all characters
    public var characters: Character? {
      get {
        return (resultMap["characters"] as? ResultMap).flatMap { Character(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "characters")
      }
    }

    public struct Character: GraphQLSelectionSet {
      public static let possibleTypes = ["Characters"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Characters", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Character"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CharacterDetails.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var characterDetails: CharacterDetails {
            get {
              return CharacterDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct CharacterDetails: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CharacterDetails on Character {\n  __typename\n  image\n  name\n  species\n  gender\n  origin {\n    __typename\n    name\n  }\n  location {\n    __typename\n    name\n  }\n}"

  public static let possibleTypes = ["Character"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("image", type: .scalar(String.self)),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("species", type: .scalar(String.self)),
    GraphQLField("gender", type: .scalar(String.self)),
    GraphQLField("origin", type: .object(Origin.selections)),
    GraphQLField("location", type: .object(Location.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(image: String? = nil, name: String? = nil, species: String? = nil, gender: String? = nil, origin: Origin? = nil, location: Location? = nil) {
    self.init(unsafeResultMap: ["__typename": "Character", "image": image, "name": name, "species": species, "gender": gender, "origin": origin.flatMap { (value: Origin) -> ResultMap in value.resultMap }, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Link to the character's image.
  /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
  public var image: String? {
    get {
      return resultMap["image"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "image")
    }
  }

  /// The name of the character.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The species of the character.
  public var species: String? {
    get {
      return resultMap["species"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "species")
    }
  }

  /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
  public var gender: String? {
    get {
      return resultMap["gender"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "gender")
    }
  }

  /// The character's origin location
  public var origin: Origin? {
    get {
      return (resultMap["origin"] as? ResultMap).flatMap { Origin(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "origin")
    }
  }

  /// The character's last known location
  public var location: Location? {
    get {
      return (resultMap["location"] as? ResultMap).flatMap { Location(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "location")
    }
  }

  public struct Origin: GraphQLSelectionSet {
    public static let possibleTypes = ["Location"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Location", "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The name of the location.
    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }

  public struct Location: GraphQLSelectionSet {
    public static let possibleTypes = ["Location"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Location", "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The name of the location.
    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }
}