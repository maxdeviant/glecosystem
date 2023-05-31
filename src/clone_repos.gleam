import gleam/int
import gleam/io
import gleam/list
import shellout

pub fn main() {
  let gleam_repositories = [
    "https://git.chmeee.org/lustre_animation",
    "https://git.chmeee.org/lustre_http",
    "https://git.chmeee.org/lustre_websocket",
    "https://github.com/adz/glow_auth", "https://github.com/altenwald/ream",
    "https://github.com/arnarg/glats",
    "https://github.com/avdgaag/gleam_ag_html",
    "https://github.com/bcpeinhardt/gsv",
    "https://github.com/bcpeinhardt/simplifile",
    "https://github.com/brettkolodny/gleam-hug",
    "https://github.com/brettkolodny/react-gleam",
    "https://github.com/chouzar/crow", "https://github.com/cobbinma/gleamql",
    "https://github.com/dahlia-lib/dahlia-gleam",
    "https://github.com/DanielleMaywood/glexer",
    "https://github.com/defgenx/glog", "https://github.com/defgenx/gxid",
    "https://github.com/dennisschroeder/glome",
    "https://github.com/endercheif/glucose", "https://github.com/fabjan/outil",
    "https://github.com/giacomocavalieri/non_empty_list",
    "https://github.com/gilevskaya/gleam_gun",
    "https://github.com/gleam-community/ansi",
    "https://github.com/gleam-community/colour",
    "https://github.com/gleam-experiments/bbmustache",
    "https://github.com/gleam-experiments/crypto",
    "https://github.com/gleam-experiments/pgo",
    "https://github.com/gleam-experiments/snag",
    "https://github.com/gleam-lang/bitwise",
    "https://github.com/gleam-lang/cowboy", "https://github.com/gleam-lang/elli",
    "https://github.com/gleam-lang/erlang",
    "https://github.com/gleam-lang/fetch",
    "https://github.com/gleam-lang/hackney",
    "https://github.com/gleam-lang/hexpm", "https://github.com/gleam-lang/http",
    "https://github.com/gleam-lang/httpc",
    "https://github.com/gleam-lang/javascript",
    "https://github.com/gleam-lang/json", "https://github.com/gleam-lang/otp",
    "https://github.com/gleam-lang/stdlib", "https://github.com/HarryET/gledis",
    "https://github.com/HarryET/shimmer",
    "https://github.com/HarryET/transparent_http",
    "https://github.com/hayleigh-dot-dev/gleam-eval",
    "https://github.com/hayleigh-dot-dev/gleam-lustre",
    "https://github.com/hayleigh-dot-dev/gleam-nibble",
    "https://github.com/inoas/glacier", "https://github.com/inoas/glychee",
    "https://github.com/J3RN/form_coder", "https://github.com/JohnBjrk/galant",
    "https://github.com/JohnBjrk/gap", "https://github.com/JohnBjrk/glimt",
    "https://github.com/JohnBjrk/showtime", "https://github.com/lpil/beecrypt",
    "https://github.com/lpil/glance", "https://github.com/lpil/gleam_sendgrid",
    "https://github.com/lpil/glue", "https://github.com/lpil/htmgrrrl",
    "https://github.com/lpil/nerf", "https://github.com/lpil/sqlight",
    "https://github.com/lpil/zeptomail", "https://github.com/lucasavila00/fp_gl",
    "https://github.com/lucasavila00/fp2", "https://github.com/lucasavila00/fp2",
    "https://github.com/lucasavila00/parser_gleam",
    "https://github.com/lunarmagpie/gloml", "https://github.com/lunarmagpie/gts",
    "https://github.com/lunarmagpie/runetracer",
    "https://github.com/manveru/gleam_erlexec",
    "https://github.com/manveru/gleam_os_mon",
    "https://github.com/massivefermion/birl",
    "https://github.com/massivefermion/blah",
    "https://github.com/massivefermion/gleam_bson",
    "https://github.com/massivefermion/gleam_mongo",
    "https://github.com/massivefermion/ranger",
    "https://github.com/maxdeviant/glenvy", "https://github.com/maxdeviant/glx",
    "https://github.com/megapctr/gleam_cors",
    "https://github.com/mikeyjones/howdy_uuid",
    "https://github.com/mikeyjones/howdy",
    "https://github.com/mikeyjones/project",
    "https://github.com/mrdimosthenis/emel",
    "https://github.com/mrdimosthenis/gleam_synapses",
    "https://github.com/mrdimosthenis/gleam_zlists",
    "https://github.com/mrdimosthenis/minigen",
    "https://github.com/nakaixo/nakai",
    "https://github.com/nicklasxyz/gleam_stats", "https://github.com/rawhat/dew",
    "https://github.com/rawhat/glisten", "https://github.com/rawhat/mist",
    "https://github.com/rvcas/ids",
    "https://github.com/schurhammer/gleamy_structures",
    "https://github.com/sporto/bliss", "https://github.com/sporto/gleam_qs",
    "https://github.com/TanklesXL/gladvent",
    "https://github.com/TanklesXL/glint", "https://github.com/tynanbe/argamak",
    "https://github.com/tynanbe/rad", "https://github.com/tynanbe/shellout",
    "https://github.com/vstreame/gleam_cowboy_websockets",
    "https://github.com/Willyboar/colours", "https://github.com/Willyboar/globe",
    "https://github.com/Willyboar/glove",
    "https://github.com/xenomorphtech/pb_lite",
    "https://gitlab.com/Nicd/finch_gleam", "https://gitlab.com/Nicd/glemplate",
    "https://gitlab.com/Nicd/glentities",
  ]

  gleam_repositories
  |> list.each(fn(repo_url) { clone_repository(repo_url, to: "gleam_repos") })

  io.println("Finished cloning repositories.")
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
