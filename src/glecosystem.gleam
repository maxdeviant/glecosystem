import gleam/erlang/file
import gleam/dynamic as dyn
import gleam/io
import gleam/list
import gleam/map.{Map}
import gleam/result.{try}
import rad/toml
import snag.{Snag}

pub fn main() {
  use entries <- try(file.list_directory("gleam_repos"))

  io.debug(entries)

  entries
  |> list.each(fn(dirpath) {
    let dirpath = "gleam_repos/" <> dirpath
    io.debug(load_gleam_toml(dirpath))
  })

  Ok(Nil)
}

type GleamToml {
  GleamToml(
    dependencies: Map(String, String),
    dev_dependencies: Map(String, String),
  )
}

fn load_gleam_toml(package_path: String) -> Result(GleamToml, Snag) {
  let path_to_gleam_toml = package_path <> "/" <> "gleam.toml"

  io.debug(path_to_gleam_toml)

  use toml <- try(toml.parse_file(path_to_gleam_toml))

  use dependencies <- try(toml.decode(
    toml,
    get: ["dependencies"],
    expect: dyn.map(dyn.string, dyn.string),
  ))
  use dev_dependencies <- try(toml.decode(
    toml,
    get: ["dev-dependencies"],
    expect: dyn.map(dyn.string, dyn.string),
  ))

  Ok(GleamToml(dependencies: dependencies, dev_dependencies: dev_dependencies))
}
