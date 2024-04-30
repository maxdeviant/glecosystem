import gleam/dict.{type Dict}
import gleam/json.{type Json}
import gleam/list

pub type Graph {
  Graph(nodes: Dict(String, Node), edges: Dict(String, Edge))
}

pub type Node {
  Node(key: String, color: String)
}

pub type Edge {
  Edge(key: String, source: String, target: String)
}

pub fn new() -> Graph {
  Graph(nodes: dict.new(), edges: dict.new())
}

pub fn add_node(graph: Graph, node: Node) -> Graph {
  Graph(
    nodes: graph.nodes
      |> dict.insert(node.key, node),
    edges: graph.edges,
  )
}

pub fn add_edge(graph: Graph, edge: Edge) -> Graph {
  Graph(
    nodes: graph.nodes,
    edges: graph.edges
      |> dict.insert(edge.key, edge),
  )
}

pub fn to_json(graph: Graph) -> Json {
  json.object([
    #(
      "nodes",
      graph.nodes
        |> dict.values
        |> list.map(node_to_json)
        |> json.preprocessed_array,
    ),
    #(
      "edges",
      graph.edges
        |> dict.values
        |> list.map(edge_to_json)
        |> json.preprocessed_array,
    ),
  ])
}

fn node_to_json(node: Node) -> json.Json {
  json.object([
    #("key", json.string(node.key)),
    #(
      "attributes",
      json.object([
        #("label", json.string(node.key)),
        #("color", json.string(node.color)),
        #("size", json.int(10)),
        #("x", json.int(0)),
        #("y", json.int(0)),
      ]),
    ),
  ])
}

fn edge_to_json(edge: Edge) -> json.Json {
  json.object([
    #("key", json.string(edge.key)),
    #("source", json.string(edge.source)),
    #("target", json.string(edge.target)),
  ])
}
