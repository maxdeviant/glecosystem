import gleam/json.{Json}
import gleam/list

pub type Graph {
  Graph(nodes: List(Node), edges: List(Edge))
}

pub type Node {
  Node(key: String)
}

pub type Edge {
  Edge(key: String, source: String, target: String)
}

pub fn new() -> Graph {
  Graph(nodes: [], edges: [])
}

pub fn add_node(graph: Graph, node: Node) -> Graph {
  Graph(nodes: [node, ..graph.nodes], edges: graph.edges)
}

pub fn add_edge(graph: Graph, edge: Edge) -> Graph {
  Graph(nodes: graph.nodes, edges: [edge, ..graph.edges])
}

pub fn to_json(graph: Graph) -> json.Json {
  json.object([
    #(
      "nodes",
      graph.nodes
      |> list.map(node_to_json)
      |> json.preprocessed_array,
    ),
    #(
      "edges",
      graph.edges
      |> list.map(edge_to_json)
      |> json.preprocessed_array,
    ),
  ])
}

fn node_to_json(node: Node) -> json.Json {
  json.object([#("key", json.string(node.key))])
}

fn edge_to_json(edge: Edge) -> json.Json {
  json.object([
    #("key", json.string(edge.key)),
    #("source", json.string(edge.source)),
    #("target", json.string(edge.target)),
  ])
}
