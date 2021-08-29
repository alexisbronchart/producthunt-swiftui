// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PostsFeedQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query PostsFeed($count: Int, $cursor: String) {
      posts(first: $count, after: $cursor) {
        __typename
        pageInfo {
          __typename
          hasNextPage
          endCursor
        }
        edges {
          __typename
          node {
            __typename
            ... on Post {
              id
              name
              tagline
              thumbnail {
                __typename
                url
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "PostsFeed"

  public var count: Int?
  public var cursor: String?

  public init(count: Int? = nil, cursor: String? = nil) {
    self.count = count
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["count": count, "cursor": cursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("posts", arguments: ["first": GraphQLVariable("count"), "after": GraphQLVariable("cursor")], type: .nonNull(.object(Post.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(posts: Post) {
      self.init(unsafeResultMap: ["__typename": "Query", "posts": posts.resultMap])
    }

    /// Look up Posts by various parameters.
    public var posts: Post {
      get {
        return Post(unsafeResultMap: resultMap["posts"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PostConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          GraphQLField("edges", type: .nonNull(.list(.nonNull(.object(Edge.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(pageInfo: PageInfo, edges: [Edge]) {
        self.init(unsafeResultMap: ["__typename": "PostConnection", "pageInfo": pageInfo.resultMap, "edges": edges.map { (value: Edge) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
        }
      }

      /// A list of edges.
      public var edges: [Edge] {
        get {
          return (resultMap["edges"] as! [ResultMap]).map { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Edge) -> ResultMap in value.resultMap }, forKey: "edges")
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PageInfo"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(hasNextPage: Bool, endCursor: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return resultMap["hasNextPage"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasNextPage")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return resultMap["endCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endCursor")
          }
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PostEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .nonNull(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node) {
          self.init(unsafeResultMap: ["__typename": "PostEdge", "node": node.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node {
          get {
            return Node(unsafeResultMap: resultMap["node"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Post"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("tagline", type: .nonNull(.scalar(String.self))),
              GraphQLField("thumbnail", type: .object(Thumbnail.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, tagline: String, thumbnail: Thumbnail? = nil) {
            self.init(unsafeResultMap: ["__typename": "Post", "id": id, "name": name, "tagline": tagline, "thumbnail": thumbnail.flatMap { (value: Thumbnail) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// ID of the Post.
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// Name of the Post.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// Tagline of the Post.
          public var tagline: String {
            get {
              return resultMap["tagline"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "tagline")
            }
          }

          /// Thumbnail media object of the Post.
          public var thumbnail: Thumbnail? {
            get {
              return (resultMap["thumbnail"] as? ResultMap).flatMap { Thumbnail(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "thumbnail")
            }
          }

          public struct Thumbnail: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Media"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("url", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(url: String) {
              self.init(unsafeResultMap: ["__typename": "Media", "url": url])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Public URL for the media object. Incase of videos this URL represents thumbnail generated from video.
            public var url: String {
              get {
                return resultMap["url"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "url")
              }
            }
          }
        }
      }
    }
  }
}

public final class PostQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Post($id: ID) {
      post(id: $id) {
        __typename
        id
        name
        tagline
        thumbnail {
          __typename
          url
          videoUrl
        }
        description
        createdAt
        featuredAt
        makers {
          __typename
          name
          username
          profileImage
        }
        media {
          __typename
          id: url
          type
          url
          videoUrl
        }
        votesCount
        website
      }
    }
    """

  public let operationName: String = "Post"

  public var id: GraphQLID?

  public init(id: GraphQLID? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("post", arguments: ["id": GraphQLVariable("id")], type: .object(Post.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(post: Post? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "post": post.flatMap { (value: Post) -> ResultMap in value.resultMap }])
    }

    /// Look up a Post.
    public var post: Post? {
      get {
        return (resultMap["post"] as? ResultMap).flatMap { Post(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "post")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Post"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("tagline", type: .nonNull(.scalar(String.self))),
          GraphQLField("thumbnail", type: .object(Thumbnail.selections)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("featuredAt", type: .scalar(String.self)),
          GraphQLField("makers", type: .nonNull(.list(.nonNull(.object(Maker.selections))))),
          GraphQLField("media", type: .nonNull(.list(.nonNull(.object(Medium.selections))))),
          GraphQLField("votesCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("website", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, tagline: String, thumbnail: Thumbnail? = nil, description: String? = nil, createdAt: String, featuredAt: String? = nil, makers: [Maker], media: [Medium], votesCount: Int, website: String) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "name": name, "tagline": tagline, "thumbnail": thumbnail.flatMap { (value: Thumbnail) -> ResultMap in value.resultMap }, "description": description, "createdAt": createdAt, "featuredAt": featuredAt, "makers": makers.map { (value: Maker) -> ResultMap in value.resultMap }, "media": media.map { (value: Medium) -> ResultMap in value.resultMap }, "votesCount": votesCount, "website": website])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// ID of the Post.
      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Name of the Post.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Tagline of the Post.
      public var tagline: String {
        get {
          return resultMap["tagline"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tagline")
        }
      }

      /// Thumbnail media object of the Post.
      public var thumbnail: Thumbnail? {
        get {
          return (resultMap["thumbnail"] as? ResultMap).flatMap { Thumbnail(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "thumbnail")
        }
      }

      /// Description of the Post in plain text.
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// Identifies the date and time when the Post was created.
      public var createdAt: String {
        get {
          return resultMap["createdAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      /// Identifies the date and time when the Post was featured.
      public var featuredAt: String? {
        get {
          return resultMap["featuredAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "featuredAt")
        }
      }

      /// Users who are marked as makers of the Post.
      public var makers: [Maker] {
        get {
          return (resultMap["makers"] as! [ResultMap]).map { (value: ResultMap) -> Maker in Maker(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Maker) -> ResultMap in value.resultMap }, forKey: "makers")
        }
      }

      /// Media items for the Post.
      public var media: [Medium] {
        get {
          return (resultMap["media"] as! [ResultMap]).map { (value: ResultMap) -> Medium in Medium(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Medium) -> ResultMap in value.resultMap }, forKey: "media")
        }
      }

      /// Number of votes that the object has currently.
      public var votesCount: Int {
        get {
          return resultMap["votesCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "votesCount")
        }
      }

      /// URL that redirects to the Post's website.
      public var website: String {
        get {
          return resultMap["website"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "website")
        }
      }

      public struct Thumbnail: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Media"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
            GraphQLField("videoUrl", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String, videoUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "url": url, "videoUrl": videoUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Public URL for the media object. Incase of videos this URL represents thumbnail generated from video.
        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        /// Video URL of the media object.
        public var videoUrl: String? {
          get {
            return resultMap["videoUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "videoUrl")
          }
        }
      }

      public struct Maker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, username: String, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "name": name, "username": username, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Name of the user.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// Username of the user.
        public var username: String {
          get {
            return resultMap["username"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "username")
          }
        }

        /// Profile image of the user.
        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }
      }

      public struct Medium: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Media"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", alias: "id", type: .nonNull(.scalar(String.self))),
            GraphQLField("type", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
            GraphQLField("videoUrl", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, type: String, url: String, videoUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "id": id, "type": type, "url": url, "videoUrl": videoUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Public URL for the media object. Incase of videos this URL represents thumbnail generated from video.
        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// Type of media object.
        public var type: String {
          get {
            return resultMap["type"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        /// Public URL for the media object. Incase of videos this URL represents thumbnail generated from video.
        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        /// Video URL of the media object.
        public var videoUrl: String? {
          get {
            return resultMap["videoUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "videoUrl")
          }
        }
      }
    }
  }
}
