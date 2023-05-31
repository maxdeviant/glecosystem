import gleam/dynamic as dyn
import gleam/erlang/file
import gleam/io
import gleam/json
import gleam/list
import gleam/map.{Map}
import gleam/result.{try}
import gleam/string_builder
import graph.{Edge, Node}
import rad/toml
import snag.{Result}

pub fn main() {
  let assert Ok(entries) =
    file.list_directory("gleam_repos")
    |> result.map_error(fn(_reason) { snag.new("Failed to list gleam_repos.") })

  let assert Ok(package_dependencies) =
    entries
    |> list.try_map(fn(dirpath) {
      let dirpath = "gleam_repos/" <> dirpath

      use toml <- try(load_gleam_toml(dirpath))

      Ok(#(toml.name, toml))
    })
    |> result.map(map.from_list)

  let graph =
    package_dependencies
    |> map.values
    |> list.fold(
      from: graph.new(),
      with: fn(graph, package) {
        graph
        |> graph.add_node(Node(key: package.name))
        |> fn(graph) {
          package.dependencies
          |> map.fold(
            from: graph,
            with: fn(acc, dependency_name, _) {
              acc
              |> graph.add_node(Node(key: dependency_name))
              |> graph.add_edge(Edge(
                key: package.name <> " -> " <> dependency_name,
                source: package.name,
                target: dependency_name,
              ))
            },
          )
        }
      },
    )

  let graph_json =
    graph
    |> graph.to_json
    |> json.to_string_builder
    |> string_builder.to_string

  io.println(graph_json)

  Nil
}

type GleamToml {
  GleamToml(
    name: String,
    dependencies: Map(String, String),
    dev_dependencies: Map(String, String),
  )
}

fn load_gleam_toml(package_path: String) -> Result(GleamToml) {
  let path_to_gleam_toml = package_path <> "/" <> "gleam.toml"

  io.debug(path_to_gleam_toml)

  use toml <- try(toml.parse_file(path_to_gleam_toml))

  use name <- try(toml.decode(toml, get: ["name"], expect: dyn.string))
  use dependencies <- try(toml.decode(
    toml,
    get: ["dependencies"],
    expect: dyn.map(dyn.string, dyn.string),
  ))
  let dev_dependencies =
    toml.decode(
      toml,
      get: ["dev-dependencies"],
      expect: dyn.map(dyn.string, dyn.string),
    )
    |> result.unwrap(map.new())

  Ok(GleamToml(
    name: name,
    dependencies: dependencies,
    dev_dependencies: dev_dependencies,
  ))
}
