import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import shellout
import simplifile

pub fn main() {
  let gleam_repositories = [
    "https://github.com/giacomocavalieri/glam",
    "https://github.com/lustre-labs/lustre",
    "https://github.com/massivefermion/phony", "https://github.com/lpil/sqlight",
    "https://github.com/massivefermion/birl",
    "https://github.com/Crowdhailer/plinth",
    "https://github.com/Willyboar/glove", "https://github.com/lustre-labs/ssg",
    "https://github.com/bcpeinhardt/simplifile",
    "https://github.com/gleam-community/maths",
    "https://github.com/RyanBrewer317/party", "https://github.com/lpil/glance",
    "https://gitlab.com/Nicd/varasto",
    "https://codeberg.org/kero/lustre_animation",
    "https://codeberg.org/kero/lustre_websocket",
    "https://codeberg.org/kero/lustre_http",
    "https://github.com/gleam-wisp/wisp", "https://github.com/tynanbe/argamak",
    "https://github.com/tynanbe/rad", "https://github.com/gleam-lang/javascript",
    "https://github.com/bitbldr/sprocket", "https://github.com/rvcas/ids",
    "https://github.com/bcpeinhardt/testbldr",
    "https://github.com/RyanBrewer317/glimmer", "https://github.com/rawhat/mist",
    "https://github.com/gleam-lang/stdlib", "https://github.com/rawhat/glisten",
    "https://github.com/gleam-lang/otp", "https://github.com/gleam-lang/erlang",
    "https://github.com/tynanbe/shellout", "https://github.com/TanklesXL/glint",
    "https://github.com/gleam-lang/bitwise",
    "https://github.com/thelinuxlich/gluon", "https://github.com/lpil/htmb",
    "https://github.com/endercheif/apollo", "https://github.com/lpil/exception",
    "https://github.com/gleam-experiments/bbmustache",
    "https://github.com/lpil/beecrypt", "https://github.com/gleam-lang/gleeunit",
    "https://github.com/gleam-lang/http",
    "https://github.com/endercheif/wasmify",
    "https://github.com/gleam-lang/crypto", "https://github.com/gleam-lang/elli",
    "https://github.com/gleam-lang/hackney",
    "https://github.com/gleam-lang/httpc", "https://github.com/gleam-lang/json",
    "https://github.com/gleam-experiments/pgo",
    "https://github.com/lpil/htmgrrrl", "https://github.com/gleam-lang/fetch",
    "https://github.com/exercism/gleam-test-runner",
    "https://github.com/giacomocavalieri/edit_distance",
    "https://github.com/giacomocavalieri/prequel",
    "https://github.com/giacomocavalieri/non_empty_list",
    "https://gitlab.com/Nicd/finch_gleam", "https://gitlab.com/Nicd/glemplate",
    "https://gitlab.com/Nicd/glentities",
    "https://github.com/espresso-gleam/espresso_pgo_wrapper",
    "https://github.com/massivefermion/gleam_mongo",
    "https://github.com/massivefermion/gleam_bson",
    "https://github.com/massivefermion/blah",
    "https://github.com/massivefermion/ranger",
    "https://github.com/espresso-gleam/espresso",
    "https://github.com/brettkolodny/gleam-hug",
    "https://github.com/JohnBjrk/glimt", "https://github.com/JohnBjrk/showtime",
    "https://github.com/hayleigh-dot-dev/gleam-lustre",
    "https://github.com/JohnBjrk/gap", "https://github.com/inoas/glychee",
    "https://github.com/inoas/glacier", "https://github.com/inoas/gleeunit",
    "https://github.com/hayleigh-dot-dev/gleam-nibble",
    "https://github.com/DanielleMaywood/glexer",
    "https://github.com/gleam-experiments/snag",
    "https://github.com/PROMETHIA-27/halo",
    "https://github.com/giacomocavalieri/trie_again",
    "https://github.com/PROMETHIA-27/mote", "https://github.com/arnarg/gliew",
    "https://github.com/Endercheif/glare", "https://github.com/rawhat/glerm",
    "https://github.com/megapctr/gleam_cors",
    "https://github.com/Willyboar/globe", "https://github.com/maxdeviant/glenvy",
    "https://github.com/maxdeviant/glx", "https://github.com/altenwald/ream",
    "https://github.com/nakaixo/nakai",
    "https://github.com/schurhammer/gleamy_structures",
    "https://github.com/bcpeinhardt/gsv", "https://github.com/lpil/nerf",
    "https://github.com/brettkolodny/react-gleam",
    "https://github.com/Willyboar/colours", "https://github.com/arnarg/glats",
    "https://github.com/lpil/glue", "https://github.com/sporto/gleam_qs",
    "https://github.com/rawhat/gramps", "https://github.com/gleam-lang/hexpm",
    "https://github.com/lunarmagpie/gts",
    "https://github.com/gilevskaya/gleam_gun",
    "https://github.com/dahlia-lib/dahlia-gleam",
    "https://github.com/enderchief/glucose",
    "https://github.com/lunarmagpie/runetracer",
    "https://github.com/fabjan/outil", "https://github.com/lunarmagpie/gloml",
    "https://github.com/gleam-community/colour",
    "https://github.com/cobbinma/gleamql", "https://github.com/HarryET/gledis",
    "https://github.com/J3RN/form_coder",
    "https://github.com/HarryET/transparent_http",
    "https://github.com/HarryET/shimmer",
    "https://github.com/gleam-community/ansi",
    "https://github.com/gleam-lang/gleam", "https://github.com/gleam-lang/gleam",
    "https://github.com/defgenx/glog", "https://github.com/JohnBjrk/galant",
    "https://github.com/TanklesXL/gladvent",
    "https://github.com/avdgaag/gleam_ag_html",
    "https://github.com/defgenx/gxid", "https://github.com/chouzar/crow",
    "https://github.com/xenomorphtech/pb_lite",
    "https://github.com/lpil/gleam_sendgrid",
    "https://github.com/gleam-lang/cowboy",
    "https://github.com/manveru/gleam_erlexec",
    "https://github.com/manveru/gleam_os_mon", "https://github.com/lpil/sequin",
    "https://github.com/lucasavila00/parser_gleam",
    "https://github.com/lucasavila00/fp_gl",
    "https://github.com/lucasavila00/fp2", "https://github.com/lucasavila00/fp2",
    "https://github.com/mrdimosthenis/emel", "https://github.com/adz/glow_auth",
    "https://github.com/nicklasxyz/gleam_stats",
    "https://github.com/lpil/zeptomail", "https://github.com/mikeyjones/howdy",
    "https://github.com/mikeyjones/project",
    "https://github.com/mikeyjones/howdy_uuid",
    "https://github.com/hayleigh-dot-dev/gleam-eval",
    "https://github.com/mrdimosthenis/gleam_synapses",
    "https://github.com/dennisschroeder/glome",
    "https://github.com/mrdimosthenis/gleam_zlists",
    "https://github.com/mrdimosthenis/minigen",
    "https://github.com/sporto/bliss", "https://github.com/rawhat/dew",
    "https://github.com/vstreame/gleam_cowboy_websockets",
    "https://github.com/gleam-lang/gleam",
    "https://github.com/giacomocavalieri/prng",
    "https://github.com/gloom-lang/gloom",
    "https://github.com/massivefermion/puddle",
    "https://github.com/bcpeinhardt/glance_printer",
    "https://github.com/massivefermion/bison",
    "https://github.com/massivefermion/mungo",
    "https://github.com/finalclass/htmz", "https://github.com/lpil/mug",
    "https://github.com/schurhammer/lustre_virtual_list",
    "https://github.com/aosasona/plunk.gleam",
    "https://github.com/bunopnu/glesha2",
    "https://github.com/pta2002/gleam-filespy",
    "https://github.com/pta2002/gleam-radiate",
    "https://github.com/bunopnu/glesha", "https://github.com/aosasona/migrant",
    "https://github.com/bunopnu/glevatar",
    "https://github.com/lpil/wimp-pushover", "https://github.com/lpil/marceau",
    "https://github.com/giacomocavalieri/tote", "https://github.com/bamii/jbs",
    "https://github.com/Grubba27/gleam_dotenv",
    "https://github.com/Grubba27/dotenv_gleam",
    "https://github.com/username/project", "https://github.com/JohnBjrk/adglent",
    "https://github.com/aosasona/dotenv",
    "https://github.com/jamesbirtles/gleam-amf0",
    "https://github.com/chouzar/chip",
    "https://github.com/schurhammer/gleamy_bench",
    "https://github.com/massivefermion/radish",
    "https://github.com/gleam-community/path", "https://github.com/lpil/glatus",
    "https://github.com/lpil/filepath",
    "https://github.com/lustre-labs/lustre_ui",
    "https://github.com/lpil/aws4_request", "https://github.com/lpil/tom",
    "https://github.com/massivefermion/dove",
    "https://github.com/philipgiuliani/glubs",
    "https://github.com/massivefermion/juno",
    "https://github.com/okkdev/gleam_tailwind",
    "https://github.com/okkdev/glailglind", "https://github.com/lpil/jot",
    "https://github.com/fschwalbe/glearray",
    "https://codeberg.org/sotolf/gleam_punycode/",
    "https://github.com/Enderchief/lotta", "https://github.com/lpil/envoy",
    "https://github.com/lpil/gleescript", "https://github.com/lpil/argv",
    "https://github.com/lpil/cgi", "https://github.com/trulyao/facquest",
    "https://github.com/Enderchief/esgleam", "https://github.com/trulyao/falcon",
    "https://github.com/lpil/glance", "https://github.com/lpil/justin",
    "https://github.com/lpil/process-waiter",
    "https://github.com/lpil/repeatedly", "https://github.com/lpil/spinner",
    "https://codeberg.org/kero/gleam_codegen",
    "https://github.com/aslilac/stego", "https://github.com/MystPi/conversation",
    "https://github.com/cdaringe/fswalk",
    "https://github.com/richard-viney/iso_8859",
    "https://github.com/cdaringe/gserde", "https://github.com/aosasona/crossbar",
    "https://codeberg.org/kero/gen_gleam",
    "https://github.com/wygsh/gleam_mineflayer",
    "https://github.com/giacomocavalieri/birdie",
    "https://github.com/MystPi/glen", "https://gitlab.com/Nicd/bigi",
    "https://github.com/lpil/cymbal", "https://github.com/lpil/youid",
    "https://github.com/lpil/logging", "https://github.com/brettkolodny/gwt",
    "https://gitlab.com/Nicd/ranged_int",
    "https://github.com/richard-viney/file_streams",
    "https://github.com/bwireman/delay", "https://github.com/lpil/formal",
    "https://github.com/lpil/systemd_status",
    "https://github.com/gleam-lang/package-interface-decoder",
    "https://github.com/leobm/phonetic_gleam",
    "https://github.com/larzconwell/flash", "https://github.com/MystPi/pprint",
    "https://github.com/solar05/glisbn", "https://github.com/ehllie/sheen",
    "https://github.com/joshgillies/bungle",
    "https://github.com/dmmulroy/glitch",
    "https://github.com/sporto/gleam-validator",
    "https://github.com/rawhat/stratus",
    "https://github.com/salif/gleam-open-color",
    "https://github.com/chris-windsor/monies",
    "https://github.com/brunoti/kreator",
    "https://github.com/tovedetered/glisdigit",
    "https://github.com/dhruvdabhi101/colored",
    "https://github.com/tovedetered/xmleam", "https://github.com/lpil/ecoji",
    "https://github.com/joshgillies/fetch_event",
    "https://github.com/joshocalico/chromatic",
    "https://github.com/tomaszbawor/sparkle", "https://github.com/lukad/pears",
    "https://github.com/lazorgurl/observatory",
    "https://github.com/joshgillies/nanoworker", "https://base.bingo/code/panel",
    "https://github.com/kathrindc/galaxyscale",
    "https://github.com/chainyo/staff-ai",
    "https://github.com/korbexmachina/gcalc",
    "https://github.com/brunoti/libsql",
    "https://github.com/brittonhayes/defangle",
    "https://github.com/synecdokey/arcana_signals",
    "https://github.com/grottohub/glomp",
    "https://github.com/chrstntdd/immutable_lru",
    "https://github.com/grottohub/glyph", "https://github.com/mJehanno/fibo",
    "https://github.com/salif/morse-code-translator",
    "https://github.com/dropwhile/gbase32_clockwork",
    "https://github.com/bitcrshr/glame",
    "https://gitlab.com/kgroat/lustre_routed",
    "https://github.com/LilyRose2798/sprinkle",
    "https://github.com/hayleigh-dot-dev/modem",
    "https://github.com/titouancreach/gluid",
    "https://github.com/Skenvy/Collatz", "https://github.com/jhillyerd/gemqtt",
    "https://github.com/LilyRose2798/typed_headers",
    "https://github.com/Yasuo-Higano/kirala_l4u",
    "https://github.com/Yasuo-Higano/kirala_bbmarkdown",
    "https://github.com/Yasuo-Higano/kirala_markdown",
    "https://github.com/yukikurage/reactive_signal",
    "https://github.com/Acepie/p5js_gleam",
    "https://github.com/deadshot465/owoify_gleam",
    "https://github.com/LilyRose2798/jasper",
    "https://github.com/antonioxdias/question",
    "https://github.com/teesh3rt/pona", "https://github.com/bondiano/telega",
    "https://github.com/grodaus/postgresql_protocol",
    "https://github.com/salif/gu", "https://github.com/manveru/gleam_erlexec",
    "https://github.com/abradley2/gleam-validate",
    "https://git.bhankas.org//payas/gleambox",
    "https://github.com/calvinmclean/survey",
    "https://github.com/bwireman/gleither", "https://github.com/pendletong/glib",
    "https://github.com/MystPi/act", "https://github.com/lustre-labs/dev-tools",
    "https://github.com/jonathanmfung/bidict",
    "https://github.com/samifouad/gild_frontend",
    "https://github.com/samifouad/gild_frontend",
    "https://github.com/lpil/antigone", "https://github.com/enderchief/webmidi",
    "https://github.com/bondiano/mockth", "https://github.com/grodaus/glcode",
    "https://github.com/myrkvi/glemtext", "https://github.com/Nekika/iox",
    "https://github.com/gastonche/gleam_md", "https://github.com/Sylvance/gloss",
    "https://github.com/onelone852/germinal",
    "https://github.com/1-bit-wonder/sol",
    "https://github.com/grottohub/carpenter",
    "https://github.com/lpil/gliberapay", "https://github.com/lost22git/dig",
    "https://github.com/darky/context-fp-gleam",
    "https://github.com/abradley2/decepticon",
    "https://github.com/abradley2/vindaloo",
    "https://github.com/BrewingWeasel/conllu",
    "https://github.com/grodaus/glzoneinfo",
    "https://github.com/Massolari/remote_data",
    "https://github.com/krystofrezac/trust", "https://github.com/ghivert/sketch",
    "https://github.com/dixtel/glyph_codegen", "https://github.com/xplosunn/ior",
    "https://github.com/darky/cleam", "https://github.com/ckreiling/nessie",
    "https://github.com/lpil/javascript-dom-parser",
    "https://github.com/Qinbeans/html-dsl",
    "https://github.com/jhillyerd/singularity",
    "https://github.com/MAHcodes/wink", "https://github.com/chiefnoah/cbor_gl",
    "https://github.com/SaphiraKai/glormat",
    "https://github.com/maxdeviant/shakespeare",
    "https://github.com/0xca551e/glanoid", "https://github.com/vaphes/glex",
    "https://github.com/MystPi/term_size",
    "https://github.com/maxdeviant/bigben",
    "https://github.com/ckreiling/nessie_cluster",
    "https://codeberg.org/Pi-Cla/gling", "https://github.com/0xca551e/lumi",
    "https://github.com/hunkyjimpjorps/rememo",
    "https://github.com/jonathanmfung/hyphenation",
    "https://github.com/skinkade/glotel",
    "https://github.com/MAHcodes/catppuccin",
    "https://github.com/mooreryan/gleam_fmt",
    "https://github.com/PastMoments/parallel_map",
    "https://github.com/maxdeviant/startest",
    "https://github.com/furrycatherder/gleam-ask",
    "https://github.com/MystPi/dedent", "https://gitlab.com/Nicd/scriptorium",
    "https://github.com/bnprtr/fresnel", "https://github.com/glistix/gleeunit",
    "https://github.com/nicklimmm/priorityq", "https://github.com/bnprtr/comet",
    "https://github.com/vleam/vleam", "https://github.com/glistix/nix",
    "https://github.com/ghivert/cors-builder",
    "https://gitlab.com/stoiridh-project/stoiridh-version",
    "https://github.com/ghivert/tardis", "https://github.com/georgesboris/mumu",
    "https://github.com/rawhat/grammy",
    "https://github.com/hayleigh-dot-dev/decipher",
    "https://github.com/mooreryan/gleam_qcheck",
    "https://github.com/wezm/gleam_bytesize",
    "https://github.com/jackjohn7/peggy",
  ]

  gleam_repositories
  |> list.each(fn(repo_url) {
    let result = clone_repository(repo_url, to: "gleam_repos")
    case result {
      Ok(Cached) -> Nil
      Ok(Cloned) | Ok(Errored) | Error(Nil) -> {
        process.sleep(1000)
      }
    }
  })

  io.println("Finished cloning repositories.")
}

type CloneOutcome {
  Cached
  Cloned
  Errored
}

fn clone_repository(
  url: String,
  to repos_directory: String,
) -> Result(CloneOutcome, Nil) {
  io.print("Cloning " <> url <> "... ")

  let assert Ok(repo_name) =
    url
    |> string.split("/")
    |> list.last()
  let repo_directory = repos_directory <> "/" <> repo_name

  case simplifile.verify_is_directory(repo_directory) {
    Ok(True) -> {
      io.println("already exists")
      Ok(Cached)
    }
    _ -> {
      let result =
        ["clone", url]
        |> shellout.command(run: "git", in: repos_directory, opt: [])

      case result {
        Ok(output) -> {
          io.println(output)
          Ok(Cloned)
        }
        Error(#(code, message)) -> {
          let code =
            code
            |> int.to_string

          io.println("git clone exited with code " <> code <> "\n" <> message)
          Ok(Errored)
        }
      }
    }
  }
}
