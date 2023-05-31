import gleam/int
import gleam/io
import gleam/list
import shellout

pub fn main() {
  let gleam_repositories = [
    "https://git.chmeee.org/lustre_animation",
    "https://git.chmeee.org/lustre_http",
    "https://git.chmeee.org/lustre_websocket",
    "https://github.com/altenwald/ream", "https://github.com/arnarg/glats",
    "https://github.com/bcpeinhardt/gsv",
    "https://github.com/bcpeinhardt/simplifile",
    "https://github.com/brettkolodny/react-gleam",
    "https://github.com/cobbinma/gleamql",
    "https://github.com/dahlia-lib/dahlia-gleam",
    "https://github.com/endercheif/glucose", "https://github.com/fabjan/outil",
    "https://github.com/giacomocavalieri/non_empty_list",
    "https://github.com/gilevskaya/gleam_gun",
    "https://github.com/gleam-community/colour",
    "https://github.com/gleam-experiments/crypto",
    "https://github.com/gleam-experiments/pgo",
    "https://github.com/gleam-lang/elli", "https://github.com/gleam-lang/erlang",
    "https://github.com/gleam-lang/hackney",
    "https://github.com/gleam-lang/hexpm", "https://github.com/gleam-lang/http",
    "https://github.com/gleam-lang/httpc", "https://github.com/gleam-lang/json",
    "https://github.com/gleam-lang/otp", "https://github.com/gleam-lang/stdlib",
    "https://github.com/HarryET/gledis",
    "https://github.com/hayleigh-dot-dev/gleam-lustre",
    "https://github.com/hayleigh-dot-dev/gleam-nibble",
    "https://github.com/inoas/glacier", "https://github.com/JohnBjrk/gap",
    "https://github.com/JohnBjrk/glimt", "https://github.com/JohnBjrk/showtime",
    "https://github.com/lpil/beecrypt", "https://github.com/lpil/glance",
    "https://github.com/lpil/glue", "https://github.com/lpil/htmgrrrl",
    "https://github.com/lpil/nerf", "https://github.com/lpil/sqlight",
    "https://github.com/lunarmagpie/gloml", "https://github.com/lunarmagpie/gts",
    "https://github.com/lunarmagpie/runetracer",
    "https://github.com/massivefermion/birl",
    "https://github.com/massivefermion/blah",
    "https://github.com/massivefermion/gleam_bson",
    "https://github.com/massivefermion/gleam_mongo",
    "https://github.com/massivefermion/ranger",
    "https://github.com/maxdeviant/glenvy", "https://github.com/maxdeviant/glx",
    "https://github.com/nakaixo/nakai", "https://github.com/rawhat/glisten",
    "https://github.com/rawhat/mist", "https://github.com/rvcas/ids",
    "https://github.com/schurhammer/gleamy_structures",
    "https://github.com/sporto/gleam_qs", "https://github.com/TanklesXL/glint",
    "https://github.com/tynanbe/rad", "https://github.com/tynanbe/shellout",
    "https://github.com/Willyboar/colours", "https://github.com/Willyboar/glove",
    "https://gitlab.com/Nicd/finch_gleam", "https://gitlab.com/Nicd/glemplate",
    "https://gitlab.com/Nicd/glentities",
  ]

  gleam_repositories
  |> list.each(fn(repo_url) { clone_repository(repo_url, to: "gleam_repos") })

  io.println("Hello from glecosystem!")
}

fn clone_repository(url: String, to repos_directory: String) -> Result(Nil, Nil) {
  let result =
    ["clone", url]
    |> shellout.command(run: "git", in: repos_directory, opt: [])

  case result {
    Ok(output) -> {
      io.println(output)
    }
    Error(#(code, message)) -> {
      let code =
        code
        |> int.to_string

      io.println("git clone exited with code " <> code <> "\n" <> message)
    }
  }

  Ok(Nil)
}
