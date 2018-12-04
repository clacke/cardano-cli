{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

  crates.aho_corasick."0.6.9" = deps: { features?(features_.aho_corasick."0.6.9" deps {}) }: buildRustCrate {
    crateName = "aho-corasick";
    version = "0.6.9";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1lj20py6bvw3y7m9n2nqh0mkshfl1kjfp72lfika9gpkrp2r204l";
    libName = "aho_corasick";
    crateBin =
      [{  name = "aho-corasick-dot";  path = "src/main.rs"; }];
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."aho_corasick"."0.6.9"."memchr"}" deps)
    ]);
  };
  features_.aho_corasick."0.6.9" = deps: f: updateFeatures f (rec {
    aho_corasick."0.6.9".default = (f.aho_corasick."0.6.9".default or true);
    memchr."${deps.aho_corasick."0.6.9".memchr}".default = true;
  }) [
    (features_.memchr."${deps."aho_corasick"."0.6.9"."memchr"}" deps)
  ];


  crates.ansi_term."0.11.0" = deps: { features?(features_.ansi_term."0.11.0" deps {}) }: buildRustCrate {
    crateName = "ansi_term";
    version = "0.11.0";
    authors = [ "ogham@bsago.me" "Ryan Scheel (Havvy) <ryan.havvy@gmail.com>" "Josh Triplett <josh@joshtriplett.org>" ];
    sha256 = "08fk0p2xvkqpmz3zlrwnf6l8sj2vngw464rvzspzp31sbgxbwm4v";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."ansi_term"."0.11.0"."winapi"}" deps)
    ]) else []);
  };
  features_.ansi_term."0.11.0" = deps: f: updateFeatures f (rec {
    ansi_term."0.11.0".default = (f.ansi_term."0.11.0".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.ansi_term."0.11.0".winapi}"."consoleapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."errhandlingapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."processenv" = true; }
      { "${deps.ansi_term."0.11.0".winapi}".default = true; }
    ];
  }) [
    (features_.winapi."${deps."ansi_term"."0.11.0"."winapi"}" deps)
  ];


  crates.argon2rs."0.2.5" = deps: { features?(features_.argon2rs."0.2.5" deps {}) }: buildRustCrate {
    crateName = "argon2rs";
    version = "0.2.5";
    authors = [ "bryant <bryant@defrag.in>" ];
    sha256 = "1byl9b3wwyrarn8qack21v5fi2qsnn3y5clvikk2apskhmnih1rw";
    dependencies = mapFeatures features ([
      (crates."blake2_rfc"."${deps."argon2rs"."0.2.5"."blake2_rfc"}" deps)
      (crates."scoped_threadpool"."${deps."argon2rs"."0.2.5"."scoped_threadpool"}" deps)
    ]);
    features = mkFeatures (features."argon2rs"."0.2.5" or {});
  };
  features_.argon2rs."0.2.5" = deps: f: updateFeatures f (rec {
    argon2rs."0.2.5".default = (f.argon2rs."0.2.5".default or true);
    blake2_rfc = fold recursiveUpdate {} [
      { "${deps.argon2rs."0.2.5".blake2_rfc}".default = true; }
      { "0.2.18".simd_asm =
        (f.blake2_rfc."0.2.18".simd_asm or false) ||
        (argon2rs."0.2.5"."simd" or false) ||
        (f."argon2rs"."0.2.5"."simd" or false); }
    ];
    scoped_threadpool."${deps.argon2rs."0.2.5".scoped_threadpool}".default = true;
  }) [
    (features_.blake2_rfc."${deps."argon2rs"."0.2.5"."blake2_rfc"}" deps)
    (features_.scoped_threadpool."${deps."argon2rs"."0.2.5"."scoped_threadpool"}" deps)
  ];


  crates.arrayvec."0.4.8" = deps: { features?(features_.arrayvec."0.4.8" deps {}) }: buildRustCrate {
    crateName = "arrayvec";
    version = "0.4.8";
    authors = [ "bluss" ];
    sha256 = "0zwpjdxgr0a11h9x7mkrif4wyx3c81b90paxjf326i86s13kib1g";
    dependencies = mapFeatures features ([
      (crates."nodrop"."${deps."arrayvec"."0.4.8"."nodrop"}" deps)
    ]);
    features = mkFeatures (features."arrayvec"."0.4.8" or {});
  };
  features_.arrayvec."0.4.8" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "0.4.8".default = (f.arrayvec."0.4.8".default or true); }
      { "0.4.8".serde =
        (f.arrayvec."0.4.8".serde or false) ||
        (f.arrayvec."0.4.8".serde-1 or false) ||
        (arrayvec."0.4.8"."serde-1" or false); }
      { "0.4.8".std =
        (f.arrayvec."0.4.8".std or false) ||
        (f.arrayvec."0.4.8".default or false) ||
        (arrayvec."0.4.8"."default" or false); }
    ];
    nodrop."${deps.arrayvec."0.4.8".nodrop}".default = (f.nodrop."${deps.arrayvec."0.4.8".nodrop}".default or false);
  }) [
    (features_.nodrop."${deps."arrayvec"."0.4.8"."nodrop"}" deps)
  ];


  crates.atty."0.2.11" = deps: { features?(features_.atty."0.2.11" deps {}) }: buildRustCrate {
    crateName = "atty";
    version = "0.2.11";
    authors = [ "softprops <d.tangren@gmail.com>" ];
    sha256 = "0by1bj2km9jxi4i4g76zzi76fc2rcm9934jpnyrqd95zw344pb20";
    dependencies = (if kernel == "redox" then mapFeatures features ([
      (crates."termion"."${deps."atty"."0.2.11"."termion"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."atty"."0.2.11"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."atty"."0.2.11"."winapi"}" deps)
    ]) else []);
  };
  features_.atty."0.2.11" = deps: f: updateFeatures f (rec {
    atty."0.2.11".default = (f.atty."0.2.11".default or true);
    libc."${deps.atty."0.2.11".libc}".default = (f.libc."${deps.atty."0.2.11".libc}".default or false);
    termion."${deps.atty."0.2.11".termion}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.atty."0.2.11".winapi}"."consoleapi" = true; }
      { "${deps.atty."0.2.11".winapi}"."minwinbase" = true; }
      { "${deps.atty."0.2.11".winapi}"."minwindef" = true; }
      { "${deps.atty."0.2.11".winapi}"."processenv" = true; }
      { "${deps.atty."0.2.11".winapi}"."winbase" = true; }
      { "${deps.atty."0.2.11".winapi}".default = true; }
    ];
  }) [
    (features_.termion."${deps."atty"."0.2.11"."termion"}" deps)
    (features_.libc."${deps."atty"."0.2.11"."libc"}" deps)
    (features_.winapi."${deps."atty"."0.2.11"."winapi"}" deps)
  ];


  crates.backtrace."0.3.9" = deps: { features?(features_.backtrace."0.3.9" deps {}) }: buildRustCrate {
    crateName = "backtrace";
    version = "0.3.9";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "The Rust Project Developers" ];
    sha256 = "137pjkcn89b7fqk78w65ggj92pynmf1hkr1sjz53aga4b50lkmwm";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."backtrace"."0.3.9"."cfg_if"}" deps)
      (crates."rustc_demangle"."${deps."backtrace"."0.3.9"."rustc_demangle"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") && !(kernel == "fuchsia") && !(kernel == "emscripten") && !(kernel == "darwin") && !(kernel == "ios") then mapFeatures features ([
    ]
      ++ (if features.backtrace."0.3.9".backtrace-sys or false then [ (crates.backtrace_sys."0.1.24" deps) ] else [])) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."backtrace"."0.3.9"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
    ]
      ++ (if features.backtrace."0.3.9".winapi or false then [ (crates.winapi."0.3.6" deps) ] else [])) else []);
    features = mkFeatures (features."backtrace"."0.3.9" or {});
  };
  features_.backtrace."0.3.9" = deps: f: updateFeatures f (rec {
    backtrace = fold recursiveUpdate {} [
      { "0.3.9".addr2line =
        (f.backtrace."0.3.9".addr2line or false) ||
        (f.backtrace."0.3.9".gimli-symbolize or false) ||
        (backtrace."0.3.9"."gimli-symbolize" or false); }
      { "0.3.9".backtrace-sys =
        (f.backtrace."0.3.9".backtrace-sys or false) ||
        (f.backtrace."0.3.9".libbacktrace or false) ||
        (backtrace."0.3.9"."libbacktrace" or false); }
      { "0.3.9".coresymbolication =
        (f.backtrace."0.3.9".coresymbolication or false) ||
        (f.backtrace."0.3.9".default or false) ||
        (backtrace."0.3.9"."default" or false); }
      { "0.3.9".dbghelp =
        (f.backtrace."0.3.9".dbghelp or false) ||
        (f.backtrace."0.3.9".default or false) ||
        (backtrace."0.3.9"."default" or false); }
      { "0.3.9".default = (f.backtrace."0.3.9".default or true); }
      { "0.3.9".dladdr =
        (f.backtrace."0.3.9".dladdr or false) ||
        (f.backtrace."0.3.9".default or false) ||
        (backtrace."0.3.9"."default" or false); }
      { "0.3.9".findshlibs =
        (f.backtrace."0.3.9".findshlibs or false) ||
        (f.backtrace."0.3.9".gimli-symbolize or false) ||
        (backtrace."0.3.9"."gimli-symbolize" or false); }
      { "0.3.9".gimli =
        (f.backtrace."0.3.9".gimli or false) ||
        (f.backtrace."0.3.9".gimli-symbolize or false) ||
        (backtrace."0.3.9"."gimli-symbolize" or false); }
      { "0.3.9".libbacktrace =
        (f.backtrace."0.3.9".libbacktrace or false) ||
        (f.backtrace."0.3.9".default or false) ||
        (backtrace."0.3.9"."default" or false); }
      { "0.3.9".libunwind =
        (f.backtrace."0.3.9".libunwind or false) ||
        (f.backtrace."0.3.9".default or false) ||
        (backtrace."0.3.9"."default" or false); }
      { "0.3.9".memmap =
        (f.backtrace."0.3.9".memmap or false) ||
        (f.backtrace."0.3.9".gimli-symbolize or false) ||
        (backtrace."0.3.9"."gimli-symbolize" or false); }
      { "0.3.9".object =
        (f.backtrace."0.3.9".object or false) ||
        (f.backtrace."0.3.9".gimli-symbolize or false) ||
        (backtrace."0.3.9"."gimli-symbolize" or false); }
      { "0.3.9".rustc-serialize =
        (f.backtrace."0.3.9".rustc-serialize or false) ||
        (f.backtrace."0.3.9".serialize-rustc or false) ||
        (backtrace."0.3.9"."serialize-rustc" or false); }
      { "0.3.9".serde =
        (f.backtrace."0.3.9".serde or false) ||
        (f.backtrace."0.3.9".serialize-serde or false) ||
        (backtrace."0.3.9"."serialize-serde" or false); }
      { "0.3.9".serde_derive =
        (f.backtrace."0.3.9".serde_derive or false) ||
        (f.backtrace."0.3.9".serialize-serde or false) ||
        (backtrace."0.3.9"."serialize-serde" or false); }
      { "0.3.9".winapi =
        (f.backtrace."0.3.9".winapi or false) ||
        (f.backtrace."0.3.9".dbghelp or false) ||
        (backtrace."0.3.9"."dbghelp" or false); }
    ];
    backtrace_sys."${deps.backtrace."0.3.9".backtrace_sys}".default = true;
    cfg_if."${deps.backtrace."0.3.9".cfg_if}".default = true;
    libc."${deps.backtrace."0.3.9".libc}".default = true;
    rustc_demangle."${deps.backtrace."0.3.9".rustc_demangle}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.9".winapi}"."dbghelp" = true; }
      { "${deps.backtrace."0.3.9".winapi}"."minwindef" = true; }
      { "${deps.backtrace."0.3.9".winapi}"."processthreadsapi" = true; }
      { "${deps.backtrace."0.3.9".winapi}"."std" = true; }
      { "${deps.backtrace."0.3.9".winapi}"."winnt" = true; }
      { "${deps.backtrace."0.3.9".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."backtrace"."0.3.9"."cfg_if"}" deps)
    (features_.rustc_demangle."${deps."backtrace"."0.3.9"."rustc_demangle"}" deps)
    (features_.backtrace_sys."${deps."backtrace"."0.3.9"."backtrace_sys"}" deps)
    (features_.libc."${deps."backtrace"."0.3.9"."libc"}" deps)
    (features_.winapi."${deps."backtrace"."0.3.9"."winapi"}" deps)
  ];


  crates.backtrace_sys."0.1.24" = deps: { features?(features_.backtrace_sys."0.1.24" deps {}) }: buildRustCrate {
    crateName = "backtrace-sys";
    version = "0.1.24";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "15d6jlknykiijcin3vqbx33760w24ss5qw3l1xd3hms5k4vc8305";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."backtrace_sys"."0.1.24"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."backtrace_sys"."0.1.24"."cc"}" deps)
    ]);
  };
  features_.backtrace_sys."0.1.24" = deps: f: updateFeatures f (rec {
    backtrace_sys."0.1.24".default = (f.backtrace_sys."0.1.24".default or true);
    cc."${deps.backtrace_sys."0.1.24".cc}".default = true;
    libc."${deps.backtrace_sys."0.1.24".libc}".default = true;
  }) [
    (features_.libc."${deps."backtrace_sys"."0.1.24"."libc"}" deps)
    (features_.cc."${deps."backtrace_sys"."0.1.24"."cc"}" deps)
  ];


  crates.base64."0.9.3" = deps: { features?(features_.base64."0.9.3" deps {}) }: buildRustCrate {
    crateName = "base64";
    version = "0.9.3";
    authors = [ "Alice Maz <alice@alicemaz.com>" "Marshall Pierce <marshall@mpierce.org>" ];
    sha256 = "11hhz8ln4zbpn2h2gm9fbbb9j254wrd4fpmddlyah2rrnqsmmqkd";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."base64"."0.9.3"."byteorder"}" deps)
      (crates."safemem"."${deps."base64"."0.9.3"."safemem"}" deps)
    ]);
  };
  features_.base64."0.9.3" = deps: f: updateFeatures f (rec {
    base64."0.9.3".default = (f.base64."0.9.3".default or true);
    byteorder."${deps.base64."0.9.3".byteorder}".default = true;
    safemem."${deps.base64."0.9.3".safemem}".default = true;
  }) [
    (features_.byteorder."${deps."base64"."0.9.3"."byteorder"}" deps)
    (features_.safemem."${deps."base64"."0.9.3"."safemem"}" deps)
  ];


  crates.bitflags."1.0.4" = deps: { features?(features_.bitflags."1.0.4" deps {}) }: buildRustCrate {
    crateName = "bitflags";
    version = "1.0.4";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1g1wmz2001qmfrd37dnd5qiss5njrw26aywmg6yhkmkbyrhjxb08";
    features = mkFeatures (features."bitflags"."1.0.4" or {});
  };
  features_.bitflags."1.0.4" = deps: f: updateFeatures f (rec {
    bitflags."1.0.4".default = (f.bitflags."1.0.4".default or true);
  }) [];


  crates.blake2_rfc."0.2.18" = deps: { features?(features_.blake2_rfc."0.2.18" deps {}) }: buildRustCrate {
    crateName = "blake2-rfc";
    version = "0.2.18";
    authors = [ "Cesar Eduardo Barros <cesarb@cesarb.eti.br>" ];
    sha256 = "0pyqrik4471ljk16prs0iwb2sam39z0z6axyyjxlqxdmf4wprf0l";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."blake2_rfc"."0.2.18"."arrayvec"}" deps)
      (crates."constant_time_eq"."${deps."blake2_rfc"."0.2.18"."constant_time_eq"}" deps)
    ]);
    features = mkFeatures (features."blake2_rfc"."0.2.18" or {});
  };
  features_.blake2_rfc."0.2.18" = deps: f: updateFeatures f (rec {
    arrayvec."${deps.blake2_rfc."0.2.18".arrayvec}".default = (f.arrayvec."${deps.blake2_rfc."0.2.18".arrayvec}".default or false);
    blake2_rfc = fold recursiveUpdate {} [
      { "0.2.18".default = (f.blake2_rfc."0.2.18".default or true); }
      { "0.2.18".simd =
        (f.blake2_rfc."0.2.18".simd or false) ||
        (f.blake2_rfc."0.2.18".simd_opt or false) ||
        (blake2_rfc."0.2.18"."simd_opt" or false); }
      { "0.2.18".simd_opt =
        (f.blake2_rfc."0.2.18".simd_opt or false) ||
        (f.blake2_rfc."0.2.18".simd_asm or false) ||
        (blake2_rfc."0.2.18"."simd_asm" or false); }
      { "0.2.18".std =
        (f.blake2_rfc."0.2.18".std or false) ||
        (f.blake2_rfc."0.2.18".default or false) ||
        (blake2_rfc."0.2.18"."default" or false); }
    ];
    constant_time_eq."${deps.blake2_rfc."0.2.18".constant_time_eq}".default = true;
  }) [
    (features_.arrayvec."${deps."blake2_rfc"."0.2.18"."arrayvec"}" deps)
    (features_.constant_time_eq."${deps."blake2_rfc"."0.2.18"."constant_time_eq"}" deps)
  ];


  crates.byteorder."1.2.7" = deps: { features?(features_.byteorder."1.2.7" deps {}) }: buildRustCrate {
    crateName = "byteorder";
    version = "1.2.7";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0wsl8in6jk2v1n8s8jz0pjd99mjr2isbf981497pgavwg6i11q5h";
    features = mkFeatures (features."byteorder"."1.2.7" or {});
  };
  features_.byteorder."1.2.7" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "1.2.7".default = (f.byteorder."1.2.7".default or true); }
      { "1.2.7".std =
        (f.byteorder."1.2.7".std or false) ||
        (f.byteorder."1.2.7".default or false) ||
        (byteorder."1.2.7"."default" or false); }
    ];
  }) [];


  crates.bytes."0.4.11" = deps: { features?(features_.bytes."0.4.11" deps {}) }: buildRustCrate {
    crateName = "bytes";
    version = "0.4.11";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1lk8bnxcd8shiizarf0n6ljmj1542n90jw6lz6i270gxl7rzplmh";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."bytes"."0.4.11"."byteorder"}" deps)
      (crates."iovec"."${deps."bytes"."0.4.11"."iovec"}" deps)
    ]);
    features = mkFeatures (features."bytes"."0.4.11" or {});
  };
  features_.bytes."0.4.11" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "${deps.bytes."0.4.11".byteorder}".default = true; }
      { "1.2.7".i128 =
        (f.byteorder."1.2.7".i128 or false) ||
        (bytes."0.4.11"."i128" or false) ||
        (f."bytes"."0.4.11"."i128" or false); }
    ];
    bytes."0.4.11".default = (f.bytes."0.4.11".default or true);
    iovec."${deps.bytes."0.4.11".iovec}".default = true;
  }) [
    (features_.byteorder."${deps."bytes"."0.4.11"."byteorder"}" deps)
    (features_.iovec."${deps."bytes"."0.4.11"."iovec"}" deps)
  ];


  crates.cbor_event."1.0.1" = deps: { features?(features_.cbor_event."1.0.1" deps {}) }: buildRustCrate {
    crateName = "cbor_event";
    version = "1.0.1";
    authors = [ "Nicolas Di Prima <nicolas@primetype.co.uk>" "Vincent Hanquez <vincent@typed.io>" ];
    sha256 = "17x8lxrkry2wgq4966ny9jp7q6dhra80nzq6j287rhrmqcx1dac9";
  };
  features_.cbor_event."1.0.1" = deps: f: updateFeatures f (rec {
    cbor_event."1.0.1".default = (f.cbor_event."1.0.1".default or true);
  }) [];


  crates.cc."1.0.25" = deps: { features?(features_.cc."1.0.25" deps {}) }: buildRustCrate {
    crateName = "cc";
    version = "1.0.25";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0pd8fhjlpr5qan984frkf1c8nxrqp6827wmmfzhm2840229z2hq0";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cc"."1.0.25" or {});
  };
  features_.cc."1.0.25" = deps: f: updateFeatures f (rec {
    cc = fold recursiveUpdate {} [
      { "1.0.25".default = (f.cc."1.0.25".default or true); }
      { "1.0.25".rayon =
        (f.cc."1.0.25".rayon or false) ||
        (f.cc."1.0.25".parallel or false) ||
        (cc."1.0.25"."parallel" or false); }
    ];
  }) [];


  crates.cfg_if."0.1.6" = deps: { features?(features_.cfg_if."0.1.6" deps {}) }: buildRustCrate {
    crateName = "cfg-if";
    version = "0.1.6";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "11qrix06wagkplyk908i3423ps9m9np6c4vbcq81s9fyl244xv3n";
  };
  features_.cfg_if."0.1.6" = deps: f: updateFeatures f (rec {
    cfg_if."0.1.6".default = (f.cfg_if."0.1.6".default or true);
  }) [];


  crates.clap."2.32.0" = deps: { features?(features_.clap."2.32.0" deps {}) }: buildRustCrate {
    crateName = "clap";
    version = "2.32.0";
    authors = [ "Kevin K. <kbknapp@gmail.com>" ];
    sha256 = "1hdjf0janvpjkwrjdjx1mm2aayzr54k72w6mriyr0n5anjkcj1lx";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."clap"."2.32.0"."bitflags"}" deps)
      (crates."textwrap"."${deps."clap"."2.32.0"."textwrap"}" deps)
      (crates."unicode_width"."${deps."clap"."2.32.0"."unicode_width"}" deps)
    ]
      ++ (if features.clap."2.32.0".atty or false then [ (crates.atty."0.2.11" deps) ] else [])
      ++ (if features.clap."2.32.0".strsim or false then [ (crates.strsim."0.7.0" deps) ] else [])
      ++ (if features.clap."2.32.0".term_size or false then [ (crates.term_size."0.3.1" deps) ] else []))
      ++ (if !(kernel == "windows") then mapFeatures features ([
    ]
      ++ (if features.clap."2.32.0".ansi_term or false then [ (crates.ansi_term."0.11.0" deps) ] else [])) else []);
    features = mkFeatures (features."clap"."2.32.0" or {});
  };
  features_.clap."2.32.0" = deps: f: updateFeatures f (rec {
    ansi_term."${deps.clap."2.32.0".ansi_term}".default = true;
    atty."${deps.clap."2.32.0".atty}".default = true;
    bitflags."${deps.clap."2.32.0".bitflags}".default = true;
    clap = fold recursiveUpdate {} [
      { "2.32.0".ansi_term =
        (f.clap."2.32.0".ansi_term or false) ||
        (f.clap."2.32.0".color or false) ||
        (clap."2.32.0"."color" or false); }
      { "2.32.0".atty =
        (f.clap."2.32.0".atty or false) ||
        (f.clap."2.32.0".color or false) ||
        (clap."2.32.0"."color" or false); }
      { "2.32.0".clippy =
        (f.clap."2.32.0".clippy or false) ||
        (f.clap."2.32.0".lints or false) ||
        (clap."2.32.0"."lints" or false); }
      { "2.32.0".color =
        (f.clap."2.32.0".color or false) ||
        (f.clap."2.32.0".default or false) ||
        (clap."2.32.0"."default" or false); }
      { "2.32.0".default = (f.clap."2.32.0".default or true); }
      { "2.32.0".strsim =
        (f.clap."2.32.0".strsim or false) ||
        (f.clap."2.32.0".suggestions or false) ||
        (clap."2.32.0"."suggestions" or false); }
      { "2.32.0".suggestions =
        (f.clap."2.32.0".suggestions or false) ||
        (f.clap."2.32.0".default or false) ||
        (clap."2.32.0"."default" or false); }
      { "2.32.0".term_size =
        (f.clap."2.32.0".term_size or false) ||
        (f.clap."2.32.0".wrap_help or false) ||
        (clap."2.32.0"."wrap_help" or false); }
      { "2.32.0".vec_map =
        (f.clap."2.32.0".vec_map or false) ||
        (f.clap."2.32.0".default or false) ||
        (clap."2.32.0"."default" or false); }
      { "2.32.0".yaml =
        (f.clap."2.32.0".yaml or false) ||
        (f.clap."2.32.0".doc or false) ||
        (clap."2.32.0"."doc" or false); }
      { "2.32.0".yaml-rust =
        (f.clap."2.32.0".yaml-rust or false) ||
        (f.clap."2.32.0".yaml or false) ||
        (clap."2.32.0"."yaml" or false); }
    ];
    strsim."${deps.clap."2.32.0".strsim}".default = true;
    term_size."${deps.clap."2.32.0".term_size}".default = true;
    textwrap = fold recursiveUpdate {} [
      { "${deps.clap."2.32.0".textwrap}".default = true; }
      { "0.10.0".term_size =
        (f.textwrap."0.10.0".term_size or false) ||
        (clap."2.32.0"."wrap_help" or false) ||
        (f."clap"."2.32.0"."wrap_help" or false); }
    ];
    unicode_width."${deps.clap."2.32.0".unicode_width}".default = true;
  }) [
    (features_.atty."${deps."clap"."2.32.0"."atty"}" deps)
    (features_.bitflags."${deps."clap"."2.32.0"."bitflags"}" deps)
    (features_.strsim."${deps."clap"."2.32.0"."strsim"}" deps)
    (features_.term_size."${deps."clap"."2.32.0"."term_size"}" deps)
    (features_.textwrap."${deps."clap"."2.32.0"."textwrap"}" deps)
    (features_.unicode_width."${deps."clap"."2.32.0"."unicode_width"}" deps)
    (features_.ansi_term."${deps."clap"."2.32.0"."ansi_term"}" deps)
  ];


  crates.clicolors_control."0.3.1" = deps: { features?(features_.clicolors_control."0.3.1" deps {}) }: buildRustCrate {
    crateName = "clicolors-control";
    version = "0.3.1";
    authors = [ "Armin Ronacher <armin.ronacher@active-4.com>" ];
    sha256 = "1ncvmsyif4c1y2zdcfjhvvc3pday4czlfvl3k1s11fy7ghc1py2n";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."clicolors_control"."0.3.1"."lazy_static"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."clicolors_control"."0.3.1"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."atty"."${deps."clicolors_control"."0.3.1"."atty"}" deps)
      (crates."winapi"."${deps."clicolors_control"."0.3.1"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."clicolors_control"."0.3.1" or {});
  };
  features_.clicolors_control."0.3.1" = deps: f: updateFeatures f (rec {
    atty."${deps.clicolors_control."0.3.1".atty}".default = true;
    clicolors_control = fold recursiveUpdate {} [
      { "0.3.1".default = (f.clicolors_control."0.3.1".default or true); }
      { "0.3.1".terminal_autoconfig =
        (f.clicolors_control."0.3.1".terminal_autoconfig or false) ||
        (f.clicolors_control."0.3.1".default or false) ||
        (clicolors_control."0.3.1"."default" or false); }
    ];
    lazy_static."${deps.clicolors_control."0.3.1".lazy_static}".default = true;
    libc."${deps.clicolors_control."0.3.1".libc}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.clicolors_control."0.3.1".winapi}"."consoleapi" = true; }
      { "${deps.clicolors_control."0.3.1".winapi}"."handleapi" = true; }
      { "${deps.clicolors_control."0.3.1".winapi}"."processenv" = true; }
      { "${deps.clicolors_control."0.3.1".winapi}"."winbase" = true; }
      { "${deps.clicolors_control."0.3.1".winapi}".default = true; }
    ];
  }) [
    (features_.lazy_static."${deps."clicolors_control"."0.3.1"."lazy_static"}" deps)
    (features_.libc."${deps."clicolors_control"."0.3.1"."libc"}" deps)
    (features_.atty."${deps."clicolors_control"."0.3.1"."atty"}" deps)
    (features_.winapi."${deps."clicolors_control"."0.3.1"."winapi"}" deps)
  ];


  crates.cloudabi."0.0.3" = deps: { features?(features_.cloudabi."0.0.3" deps {}) }: buildRustCrate {
    crateName = "cloudabi";
    version = "0.0.3";
    authors = [ "Nuxi (https://nuxi.nl/) and contributors" ];
    sha256 = "1z9lby5sr6vslfd14d6igk03s7awf91mxpsfmsp3prxbxlk0x7h5";
    libPath = "cloudabi.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.cloudabi."0.0.3".bitflags or false then [ (crates.bitflags."1.0.4" deps) ] else []));
    features = mkFeatures (features."cloudabi"."0.0.3" or {});
  };
  features_.cloudabi."0.0.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.cloudabi."0.0.3".bitflags}".default = true;
    cloudabi = fold recursiveUpdate {} [
      { "0.0.3".bitflags =
        (f.cloudabi."0.0.3".bitflags or false) ||
        (f.cloudabi."0.0.3".default or false) ||
        (cloudabi."0.0.3"."default" or false); }
      { "0.0.3".default = (f.cloudabi."0.0.3".default or true); }
    ];
  }) [
    (features_.bitflags."${deps."cloudabi"."0.0.3"."bitflags"}" deps)
  ];


  crates.console."0.7.1" = deps: { features?(features_.console."0.7.1" deps {}) }: buildRustCrate {
    crateName = "console";
    version = "0.7.1";
    authors = [ "Armin Ronacher <armin.ronacher@active-4.com>" ];
    sha256 = "0fw4sf0vq6n0h5my1dxb5x5qsi53vww8288wlgz97csa5wa0h58z";
    dependencies = mapFeatures features ([
      (crates."atty"."${deps."console"."0.7.1"."atty"}" deps)
      (crates."clicolors_control"."${deps."console"."0.7.1"."clicolors_control"}" deps)
      (crates."lazy_static"."${deps."console"."0.7.1"."lazy_static"}" deps)
      (crates."libc"."${deps."console"."0.7.1"."libc"}" deps)
      (crates."parking_lot"."${deps."console"."0.7.1"."parking_lot"}" deps)
      (crates."regex"."${deps."console"."0.7.1"."regex"}" deps)
      (crates."unicode_width"."${deps."console"."0.7.1"."unicode_width"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."termios"."${deps."console"."0.7.1"."termios"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."console"."0.7.1"."winapi"}" deps)
    ]) else []);
  };
  features_.console."0.7.1" = deps: f: updateFeatures f (rec {
    atty."${deps.console."0.7.1".atty}".default = true;
    clicolors_control."${deps.console."0.7.1".clicolors_control}".default = true;
    console."0.7.1".default = (f.console."0.7.1".default or true);
    lazy_static."${deps.console."0.7.1".lazy_static}".default = true;
    libc."${deps.console."0.7.1".libc}".default = true;
    parking_lot."${deps.console."0.7.1".parking_lot}".default = true;
    regex."${deps.console."0.7.1".regex}".default = true;
    termios."${deps.console."0.7.1".termios}".default = true;
    unicode_width."${deps.console."0.7.1".unicode_width}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.console."0.7.1".winapi}"."consoleapi" = true; }
      { "${deps.console."0.7.1".winapi}"."processenv" = true; }
      { "${deps.console."0.7.1".winapi}"."winbase" = true; }
      { "${deps.console."0.7.1".winapi}"."wincon" = true; }
      { "${deps.console."0.7.1".winapi}"."winuser" = true; }
      { "${deps.console."0.7.1".winapi}".default = true; }
    ];
  }) [
    (features_.atty."${deps."console"."0.7.1"."atty"}" deps)
    (features_.clicolors_control."${deps."console"."0.7.1"."clicolors_control"}" deps)
    (features_.lazy_static."${deps."console"."0.7.1"."lazy_static"}" deps)
    (features_.libc."${deps."console"."0.7.1"."libc"}" deps)
    (features_.parking_lot."${deps."console"."0.7.1"."parking_lot"}" deps)
    (features_.regex."${deps."console"."0.7.1"."regex"}" deps)
    (features_.unicode_width."${deps."console"."0.7.1"."unicode_width"}" deps)
    (features_.termios."${deps."console"."0.7.1"."termios"}" deps)
    (features_.winapi."${deps."console"."0.7.1"."winapi"}" deps)
  ];


  crates.constant_time_eq."0.1.3" = deps: { features?(features_.constant_time_eq."0.1.3" deps {}) }: buildRustCrate {
    crateName = "constant_time_eq";
    version = "0.1.3";
    authors = [ "Cesar Eduardo Barros <cesarb@cesarb.eti.br>" ];
    sha256 = "03qri9hjf049gwqg9q527lybpg918q6y5q4g9a5lma753nff49wd";
  };
  features_.constant_time_eq."0.1.3" = deps: f: updateFeatures f (rec {
    constant_time_eq."0.1.3".default = (f.constant_time_eq."0.1.3".default or true);
  }) [];


  crates.crossbeam_deque."0.6.2" = deps: { features?(features_.crossbeam_deque."0.6.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-deque";
    version = "0.6.2";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "0qjdpq03snj6xp5gydgy1bdd5zzwpdxa57vhky3mf4djxiq81ara";
    dependencies = mapFeatures features ([
      (crates."crossbeam_epoch"."${deps."crossbeam_deque"."0.6.2"."crossbeam_epoch"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_deque"."0.6.2"."crossbeam_utils"}" deps)
    ]);
  };
  features_.crossbeam_deque."0.6.2" = deps: f: updateFeatures f (rec {
    crossbeam_deque."0.6.2".default = (f.crossbeam_deque."0.6.2".default or true);
    crossbeam_epoch."${deps.crossbeam_deque."0.6.2".crossbeam_epoch}".default = true;
    crossbeam_utils."${deps.crossbeam_deque."0.6.2".crossbeam_utils}".default = true;
  }) [
    (features_.crossbeam_epoch."${deps."crossbeam_deque"."0.6.2"."crossbeam_epoch"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_deque"."0.6.2"."crossbeam_utils"}" deps)
  ];


  crates.crossbeam_epoch."0.6.1" = deps: { features?(features_.crossbeam_epoch."0.6.1" deps {}) }: buildRustCrate {
    crateName = "crossbeam-epoch";
    version = "0.6.1";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "0qlwzsf2xmdjbh6pv9bxra2qdq72cmywq4fq1q114zw2s06zr039";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."crossbeam_epoch"."0.6.1"."arrayvec"}" deps)
      (crates."cfg_if"."${deps."crossbeam_epoch"."0.6.1"."cfg_if"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_epoch"."0.6.1"."crossbeam_utils"}" deps)
      (crates."memoffset"."${deps."crossbeam_epoch"."0.6.1"."memoffset"}" deps)
      (crates."scopeguard"."${deps."crossbeam_epoch"."0.6.1"."scopeguard"}" deps)
    ]
      ++ (if features.crossbeam_epoch."0.6.1".lazy_static or false then [ (crates.lazy_static."1.2.0" deps) ] else []));
    features = mkFeatures (features."crossbeam_epoch"."0.6.1" or {});
  };
  features_.crossbeam_epoch."0.6.1" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.6.1".arrayvec}".default = (f.arrayvec."${deps.crossbeam_epoch."0.6.1".arrayvec}".default or false); }
      { "0.4.8".use_union =
        (f.arrayvec."0.4.8".use_union or false) ||
        (crossbeam_epoch."0.6.1"."nightly" or false) ||
        (f."crossbeam_epoch"."0.6.1"."nightly" or false); }
    ];
    cfg_if."${deps.crossbeam_epoch."0.6.1".cfg_if}".default = true;
    crossbeam_epoch = fold recursiveUpdate {} [
      { "0.6.1".default = (f.crossbeam_epoch."0.6.1".default or true); }
      { "0.6.1".lazy_static =
        (f.crossbeam_epoch."0.6.1".lazy_static or false) ||
        (f.crossbeam_epoch."0.6.1".std or false) ||
        (crossbeam_epoch."0.6.1"."std" or false); }
      { "0.6.1".std =
        (f.crossbeam_epoch."0.6.1".std or false) ||
        (f.crossbeam_epoch."0.6.1".default or false) ||
        (crossbeam_epoch."0.6.1"."default" or false); }
    ];
    crossbeam_utils = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.6.1".crossbeam_utils}".default = (f.crossbeam_utils."${deps.crossbeam_epoch."0.6.1".crossbeam_utils}".default or false); }
      { "0.6.1".std =
        (f.crossbeam_utils."0.6.1".std or false) ||
        (crossbeam_epoch."0.6.1"."std" or false) ||
        (f."crossbeam_epoch"."0.6.1"."std" or false); }
    ];
    lazy_static."${deps.crossbeam_epoch."0.6.1".lazy_static}".default = true;
    memoffset."${deps.crossbeam_epoch."0.6.1".memoffset}".default = true;
    scopeguard."${deps.crossbeam_epoch."0.6.1".scopeguard}".default = (f.scopeguard."${deps.crossbeam_epoch."0.6.1".scopeguard}".default or false);
  }) [
    (features_.arrayvec."${deps."crossbeam_epoch"."0.6.1"."arrayvec"}" deps)
    (features_.cfg_if."${deps."crossbeam_epoch"."0.6.1"."cfg_if"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_epoch"."0.6.1"."crossbeam_utils"}" deps)
    (features_.lazy_static."${deps."crossbeam_epoch"."0.6.1"."lazy_static"}" deps)
    (features_.memoffset."${deps."crossbeam_epoch"."0.6.1"."memoffset"}" deps)
    (features_.scopeguard."${deps."crossbeam_epoch"."0.6.1"."scopeguard"}" deps)
  ];


  crates.crossbeam_utils."0.6.1" = deps: { features?(features_.crossbeam_utils."0.6.1" deps {}) }: buildRustCrate {
    crateName = "crossbeam-utils";
    version = "0.6.1";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "031lk6ls49yvwkdxhjm4fvg81iww01h108jq1cnlh88yzbcnwn2c";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crossbeam_utils"."0.6.1"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."crossbeam_utils"."0.6.1" or {});
  };
  features_.crossbeam_utils."0.6.1" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crossbeam_utils."0.6.1".cfg_if}".default = true;
    crossbeam_utils = fold recursiveUpdate {} [
      { "0.6.1".default = (f.crossbeam_utils."0.6.1".default or true); }
      { "0.6.1".std =
        (f.crossbeam_utils."0.6.1".std or false) ||
        (f.crossbeam_utils."0.6.1".default or false) ||
        (crossbeam_utils."0.6.1"."default" or false); }
    ];
  }) [
    (features_.cfg_if."${deps."crossbeam_utils"."0.6.1"."cfg_if"}" deps)
  ];


  crates.cryptoxide."0.1.0" = deps: { features?(features_.cryptoxide."0.1.0" deps {}) }: buildRustCrate {
    crateName = "cryptoxide";
    version = "0.1.0";
    authors = [ "Vincent Hanquez <vincent@typed.io>" "Nicolas Di Prima <nicolas@prime-type.co.uk>" "The Rust-Crypto Project Developers" ];
    sha256 = "05ym36zpcywk9s2vj8az8d1w2x5harradnvrix5hiiav7ky8fq47";
  };
  features_.cryptoxide."0.1.0" = deps: f: updateFeatures f (rec {
    cryptoxide."0.1.0".default = (f.cryptoxide."0.1.0".default or true);
  }) [];


  crates.dialoguer."0.3.0" = deps: { features?(features_.dialoguer."0.3.0" deps {}) }: buildRustCrate {
    crateName = "dialoguer";
    version = "0.3.0";
    authors = [ "Armin Ronacher <armin.ronacher@active-4.com>" ];
    sha256 = "00f9z5b7fdzczgqys51wpqwsv02hm6fb2bnrsl4lmg2yvnp1gnnk";
    dependencies = mapFeatures features ([
      (crates."console"."${deps."dialoguer"."0.3.0"."console"}" deps)
      (crates."lazy_static"."${deps."dialoguer"."0.3.0"."lazy_static"}" deps)
      (crates."tempfile"."${deps."dialoguer"."0.3.0"."tempfile"}" deps)
    ]);
  };
  features_.dialoguer."0.3.0" = deps: f: updateFeatures f (rec {
    console."${deps.dialoguer."0.3.0".console}".default = true;
    dialoguer."0.3.0".default = (f.dialoguer."0.3.0".default or true);
    lazy_static."${deps.dialoguer."0.3.0".lazy_static}".default = true;
    tempfile."${deps.dialoguer."0.3.0".tempfile}".default = true;
  }) [
    (features_.console."${deps."dialoguer"."0.3.0"."console"}" deps)
    (features_.lazy_static."${deps."dialoguer"."0.3.0"."lazy_static"}" deps)
    (features_.tempfile."${deps."dialoguer"."0.3.0"."tempfile"}" deps)
  ];


  crates.dirs."1.0.4" = deps: { features?(features_.dirs."1.0.4" deps {}) }: buildRustCrate {
    crateName = "dirs";
    version = "1.0.4";
    authors = [ "Simon Ochsenreither <simon@ochsenreither.de>" ];
    sha256 = "1hp3nz0350b0gpavb3w5ajqc9l1k59cfrcsr3hcavwlkizdnpv1y";
    dependencies = (if kernel == "redox" then mapFeatures features ([
      (crates."redox_users"."${deps."dirs"."1.0.4"."redox_users"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."dirs"."1.0.4"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."dirs"."1.0.4"."winapi"}" deps)
    ]) else []);
  };
  features_.dirs."1.0.4" = deps: f: updateFeatures f (rec {
    dirs."1.0.4".default = (f.dirs."1.0.4".default or true);
    libc."${deps.dirs."1.0.4".libc}".default = true;
    redox_users."${deps.dirs."1.0.4".redox_users}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.dirs."1.0.4".winapi}"."knownfolders" = true; }
      { "${deps.dirs."1.0.4".winapi}"."objbase" = true; }
      { "${deps.dirs."1.0.4".winapi}"."shlobj" = true; }
      { "${deps.dirs."1.0.4".winapi}"."winbase" = true; }
      { "${deps.dirs."1.0.4".winapi}"."winerror" = true; }
      { "${deps.dirs."1.0.4".winapi}".default = true; }
    ];
  }) [
    (features_.redox_users."${deps."dirs"."1.0.4"."redox_users"}" deps)
    (features_.libc."${deps."dirs"."1.0.4"."libc"}" deps)
    (features_.winapi."${deps."dirs"."1.0.4"."winapi"}" deps)
  ];


  crates.dtoa."0.4.3" = deps: { features?(features_.dtoa."0.4.3" deps {}) }: buildRustCrate {
    crateName = "dtoa";
    version = "0.4.3";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1xysdxdm24sk5ysim7lps4r2qaxfnj0sbakhmps4d42yssx30cw8";
  };
  features_.dtoa."0.4.3" = deps: f: updateFeatures f (rec {
    dtoa."0.4.3".default = (f.dtoa."0.4.3".default or true);
  }) [];


  crates.env_logger."0.5.13" = deps: { features?(features_.env_logger."0.5.13" deps {}) }: buildRustCrate {
    crateName = "env_logger";
    version = "0.5.13";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1q6vylngcz4bn088b4hvsl879l8yz1k2bma75waljb5p4h4kbb72";
    dependencies = mapFeatures features ([
      (crates."atty"."${deps."env_logger"."0.5.13"."atty"}" deps)
      (crates."humantime"."${deps."env_logger"."0.5.13"."humantime"}" deps)
      (crates."log"."${deps."env_logger"."0.5.13"."log"}" deps)
      (crates."termcolor"."${deps."env_logger"."0.5.13"."termcolor"}" deps)
    ]
      ++ (if features.env_logger."0.5.13".regex or false then [ (crates.regex."1.1.0" deps) ] else []));
    features = mkFeatures (features."env_logger"."0.5.13" or {});
  };
  features_.env_logger."0.5.13" = deps: f: updateFeatures f (rec {
    atty."${deps.env_logger."0.5.13".atty}".default = true;
    env_logger = fold recursiveUpdate {} [
      { "0.5.13".default = (f.env_logger."0.5.13".default or true); }
      { "0.5.13".regex =
        (f.env_logger."0.5.13".regex or false) ||
        (f.env_logger."0.5.13".default or false) ||
        (env_logger."0.5.13"."default" or false); }
    ];
    humantime."${deps.env_logger."0.5.13".humantime}".default = true;
    log = fold recursiveUpdate {} [
      { "${deps.env_logger."0.5.13".log}"."std" = true; }
      { "${deps.env_logger."0.5.13".log}".default = true; }
    ];
    regex."${deps.env_logger."0.5.13".regex}".default = true;
    termcolor."${deps.env_logger."0.5.13".termcolor}".default = true;
  }) [
    (features_.atty."${deps."env_logger"."0.5.13"."atty"}" deps)
    (features_.humantime."${deps."env_logger"."0.5.13"."humantime"}" deps)
    (features_.log."${deps."env_logger"."0.5.13"."log"}" deps)
    (features_.regex."${deps."env_logger"."0.5.13"."regex"}" deps)
    (features_.termcolor."${deps."env_logger"."0.5.13"."termcolor"}" deps)
  ];


  crates.failure."0.1.3" = deps: { features?(features_.failure."0.1.3" deps {}) }: buildRustCrate {
    crateName = "failure";
    version = "0.1.3";
    authors = [ "Without Boats <boats@mozilla.com>" ];
    sha256 = "0cibp01z0clyxrvkl7v7kq6jszsgcg9vwv6d9l6d1drk9jqdss4s";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.failure."0.1.3".backtrace or false then [ (crates.backtrace."0.3.9" deps) ] else [])
      ++ (if features.failure."0.1.3".failure_derive or false then [ (crates.failure_derive."0.1.3" deps) ] else []));
    features = mkFeatures (features."failure"."0.1.3" or {});
  };
  features_.failure."0.1.3" = deps: f: updateFeatures f (rec {
    backtrace."${deps.failure."0.1.3".backtrace}".default = true;
    failure = fold recursiveUpdate {} [
      { "0.1.3".backtrace =
        (f.failure."0.1.3".backtrace or false) ||
        (f.failure."0.1.3".std or false) ||
        (failure."0.1.3"."std" or false); }
      { "0.1.3".default = (f.failure."0.1.3".default or true); }
      { "0.1.3".derive =
        (f.failure."0.1.3".derive or false) ||
        (f.failure."0.1.3".default or false) ||
        (failure."0.1.3"."default" or false); }
      { "0.1.3".failure_derive =
        (f.failure."0.1.3".failure_derive or false) ||
        (f.failure."0.1.3".derive or false) ||
        (failure."0.1.3"."derive" or false); }
      { "0.1.3".std =
        (f.failure."0.1.3".std or false) ||
        (f.failure."0.1.3".default or false) ||
        (failure."0.1.3"."default" or false); }
    ];
    failure_derive."${deps.failure."0.1.3".failure_derive}".default = true;
  }) [
    (features_.backtrace."${deps."failure"."0.1.3"."backtrace"}" deps)
    (features_.failure_derive."${deps."failure"."0.1.3"."failure_derive"}" deps)
  ];


  crates.failure_derive."0.1.3" = deps: { features?(features_.failure_derive."0.1.3" deps {}) }: buildRustCrate {
    crateName = "failure_derive";
    version = "0.1.3";
    authors = [ "Without Boats <woboats@gmail.com>" ];
    sha256 = "1mh7ad2d17f13g0k29bskp0f9faws0w1q4a5yfzlzi75bw9kidgm";
    procMacro = true;
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."failure_derive"."0.1.3"."proc_macro2"}" deps)
      (crates."quote"."${deps."failure_derive"."0.1.3"."quote"}" deps)
      (crates."syn"."${deps."failure_derive"."0.1.3"."syn"}" deps)
      (crates."synstructure"."${deps."failure_derive"."0.1.3"."synstructure"}" deps)
    ]);
    features = mkFeatures (features."failure_derive"."0.1.3" or {});
  };
  features_.failure_derive."0.1.3" = deps: f: updateFeatures f (rec {
    failure_derive."0.1.3".default = (f.failure_derive."0.1.3".default or true);
    proc_macro2."${deps.failure_derive."0.1.3".proc_macro2}".default = true;
    quote."${deps.failure_derive."0.1.3".quote}".default = true;
    syn."${deps.failure_derive."0.1.3".syn}".default = true;
    synstructure."${deps.failure_derive."0.1.3".synstructure}".default = true;
  }) [
    (features_.proc_macro2."${deps."failure_derive"."0.1.3"."proc_macro2"}" deps)
    (features_.quote."${deps."failure_derive"."0.1.3"."quote"}" deps)
    (features_.syn."${deps."failure_derive"."0.1.3"."syn"}" deps)
    (features_.synstructure."${deps."failure_derive"."0.1.3"."synstructure"}" deps)
  ];


  crates.fuchsia_zircon."0.3.3" = deps: { features?(features_.fuchsia_zircon."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon";
    version = "0.3.3";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "0jrf4shb1699r4la8z358vri8318w4mdi6qzfqy30p2ymjlca4gk";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
    ]);
  };
  features_.fuchsia_zircon."0.3.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.fuchsia_zircon."0.3.3".bitflags}".default = true;
    fuchsia_zircon."0.3.3".default = (f.fuchsia_zircon."0.3.3".default or true);
    fuchsia_zircon_sys."${deps.fuchsia_zircon."0.3.3".fuchsia_zircon_sys}".default = true;
  }) [
    (features_.bitflags."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
    (features_.fuchsia_zircon_sys."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
  ];


  crates.fuchsia_zircon_sys."0.3.3" = deps: { features?(features_.fuchsia_zircon_sys."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon-sys";
    version = "0.3.3";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "08jp1zxrm9jbrr6l26bjal4dbm8bxfy57ickdgibsqxr1n9j3hf5";
  };
  features_.fuchsia_zircon_sys."0.3.3" = deps: f: updateFeatures f (rec {
    fuchsia_zircon_sys."0.3.3".default = (f.fuchsia_zircon_sys."0.3.3".default or true);
  }) [];


  crates.futures."0.1.25" = deps: { features?(features_.futures."0.1.25" deps {}) }: buildRustCrate {
    crateName = "futures";
    version = "0.1.25";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1gdn9z3mi3jjzbxgvawqh90895130c3ydks55rshja0ncpn985q3";
    features = mkFeatures (features."futures"."0.1.25" or {});
  };
  features_.futures."0.1.25" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "0.1.25".default = (f.futures."0.1.25".default or true); }
      { "0.1.25".use_std =
        (f.futures."0.1.25".use_std or false) ||
        (f.futures."0.1.25".default or false) ||
        (futures."0.1.25"."default" or false); }
      { "0.1.25".with-deprecated =
        (f.futures."0.1.25".with-deprecated or false) ||
        (f.futures."0.1.25".default or false) ||
        (futures."0.1.25"."default" or false); }
    ];
  }) [];


  crates.futures_cpupool."0.1.8" = deps: { features?(features_.futures_cpupool."0.1.8" deps {}) }: buildRustCrate {
    crateName = "futures-cpupool";
    version = "0.1.8";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0ficd31n5ljiixy6x0vjglhq4fp0v1p4qzxm3v6ymsrb3z080l5c";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
      (crates."num_cpus"."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
    ]);
    features = mkFeatures (features."futures_cpupool"."0.1.8" or {});
  };
  features_.futures_cpupool."0.1.8" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "${deps.futures_cpupool."0.1.8".futures}"."use_std" = true; }
      { "${deps.futures_cpupool."0.1.8".futures}".default = (f.futures."${deps.futures_cpupool."0.1.8".futures}".default or false); }
      { "0.1.25".with-deprecated =
        (f.futures."0.1.25".with-deprecated or false) ||
        (futures_cpupool."0.1.8"."with-deprecated" or false) ||
        (f."futures_cpupool"."0.1.8"."with-deprecated" or false); }
    ];
    futures_cpupool = fold recursiveUpdate {} [
      { "0.1.8".default = (f.futures_cpupool."0.1.8".default or true); }
      { "0.1.8".with-deprecated =
        (f.futures_cpupool."0.1.8".with-deprecated or false) ||
        (f.futures_cpupool."0.1.8".default or false) ||
        (futures_cpupool."0.1.8"."default" or false); }
    ];
    num_cpus."${deps.futures_cpupool."0.1.8".num_cpus}".default = true;
  }) [
    (features_.futures."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
    (features_.num_cpus."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
  ];


  crates.httparse."1.3.3" = deps: { features?(features_.httparse."1.3.3" deps {}) }: buildRustCrate {
    crateName = "httparse";
    version = "1.3.3";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1jymxy4bl0mzgp2dx0pzqzbr72sw5jmr5sjqiry4xr88z4z9qlyx";
    build = "build.rs";
    features = mkFeatures (features."httparse"."1.3.3" or {});
  };
  features_.httparse."1.3.3" = deps: f: updateFeatures f (rec {
    httparse = fold recursiveUpdate {} [
      { "1.3.3".default = (f.httparse."1.3.3".default or true); }
      { "1.3.3".std =
        (f.httparse."1.3.3".std or false) ||
        (f.httparse."1.3.3".default or false) ||
        (httparse."1.3.3"."default" or false); }
    ];
  }) [];


  crates.humantime."1.2.0" = deps: { features?(features_.humantime."1.2.0" deps {}) }: buildRustCrate {
    crateName = "humantime";
    version = "1.2.0";
    authors = [ "Paul Colomiets <paul@colomiets.name>" ];
    sha256 = "0wlcxzz2mhq0brkfbjb12hc6jm17bgm8m6pdgblw4qjwmf26aw28";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."quick_error"."${deps."humantime"."1.2.0"."quick_error"}" deps)
    ]);
  };
  features_.humantime."1.2.0" = deps: f: updateFeatures f (rec {
    humantime."1.2.0".default = (f.humantime."1.2.0".default or true);
    quick_error."${deps.humantime."1.2.0".quick_error}".default = true;
  }) [
    (features_.quick_error."${deps."humantime"."1.2.0"."quick_error"}" deps)
  ];


  crates.hyper."0.11.27" = deps: { features?(features_.hyper."0.11.27" deps {}) }: buildRustCrate {
    crateName = "hyper";
    version = "0.11.27";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0q5as4lhvh31bzk4qm7j84snrmxyxyaqk040rfk72b42dn98mryi";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."hyper"."0.11.27"."base64"}" deps)
      (crates."bytes"."${deps."hyper"."0.11.27"."bytes"}" deps)
      (crates."futures"."${deps."hyper"."0.11.27"."futures"}" deps)
      (crates."futures_cpupool"."${deps."hyper"."0.11.27"."futures_cpupool"}" deps)
      (crates."httparse"."${deps."hyper"."0.11.27"."httparse"}" deps)
      (crates."iovec"."${deps."hyper"."0.11.27"."iovec"}" deps)
      (crates."language_tags"."${deps."hyper"."0.11.27"."language_tags"}" deps)
      (crates."log"."${deps."hyper"."0.11.27"."log"}" deps)
      (crates."mime"."${deps."hyper"."0.11.27"."mime"}" deps)
      (crates."net2"."${deps."hyper"."0.11.27"."net2"}" deps)
      (crates."percent_encoding"."${deps."hyper"."0.11.27"."percent_encoding"}" deps)
      (crates."relay"."${deps."hyper"."0.11.27"."relay"}" deps)
      (crates."time"."${deps."hyper"."0.11.27"."time"}" deps)
      (crates."tokio_core"."${deps."hyper"."0.11.27"."tokio_core"}" deps)
      (crates."tokio_io"."${deps."hyper"."0.11.27"."tokio_io"}" deps)
      (crates."tokio_service"."${deps."hyper"."0.11.27"."tokio_service"}" deps)
      (crates."unicase"."${deps."hyper"."0.11.27"."unicase"}" deps)
      (crates."want"."${deps."hyper"."0.11.27"."want"}" deps)
    ]
      ++ (if features.hyper."0.11.27".tokio-proto or false then [ (crates.tokio_proto."0.1.1" deps) ] else []));
    features = mkFeatures (features."hyper"."0.11.27" or {});
  };
  features_.hyper."0.11.27" = deps: f: updateFeatures f (rec {
    base64."${deps.hyper."0.11.27".base64}".default = true;
    bytes."${deps.hyper."0.11.27".bytes}".default = true;
    futures."${deps.hyper."0.11.27".futures}".default = true;
    futures_cpupool."${deps.hyper."0.11.27".futures_cpupool}".default = true;
    httparse."${deps.hyper."0.11.27".httparse}".default = true;
    hyper = fold recursiveUpdate {} [
      { "0.11.27".default = (f.hyper."0.11.27".default or true); }
      { "0.11.27".http =
        (f.hyper."0.11.27".http or false) ||
        (f.hyper."0.11.27".compat or false) ||
        (hyper."0.11.27"."compat" or false); }
      { "0.11.27".server-proto =
        (f.hyper."0.11.27".server-proto or false) ||
        (f.hyper."0.11.27".default or false) ||
        (hyper."0.11.27"."default" or false); }
      { "0.11.27".tokio-proto =
        (f.hyper."0.11.27".tokio-proto or false) ||
        (f.hyper."0.11.27".server-proto or false) ||
        (hyper."0.11.27"."server-proto" or false); }
    ];
    iovec."${deps.hyper."0.11.27".iovec}".default = true;
    language_tags."${deps.hyper."0.11.27".language_tags}".default = true;
    log."${deps.hyper."0.11.27".log}".default = true;
    mime."${deps.hyper."0.11.27".mime}".default = true;
    net2."${deps.hyper."0.11.27".net2}".default = true;
    percent_encoding."${deps.hyper."0.11.27".percent_encoding}".default = true;
    relay."${deps.hyper."0.11.27".relay}".default = true;
    time."${deps.hyper."0.11.27".time}".default = true;
    tokio_core."${deps.hyper."0.11.27".tokio_core}".default = true;
    tokio_io."${deps.hyper."0.11.27".tokio_io}".default = true;
    tokio_proto."${deps.hyper."0.11.27".tokio_proto}".default = true;
    tokio_service."${deps.hyper."0.11.27".tokio_service}".default = true;
    unicase."${deps.hyper."0.11.27".unicase}".default = true;
    want."${deps.hyper."0.11.27".want}".default = true;
  }) [
    (features_.base64."${deps."hyper"."0.11.27"."base64"}" deps)
    (features_.bytes."${deps."hyper"."0.11.27"."bytes"}" deps)
    (features_.futures."${deps."hyper"."0.11.27"."futures"}" deps)
    (features_.futures_cpupool."${deps."hyper"."0.11.27"."futures_cpupool"}" deps)
    (features_.httparse."${deps."hyper"."0.11.27"."httparse"}" deps)
    (features_.iovec."${deps."hyper"."0.11.27"."iovec"}" deps)
    (features_.language_tags."${deps."hyper"."0.11.27"."language_tags"}" deps)
    (features_.log."${deps."hyper"."0.11.27"."log"}" deps)
    (features_.mime."${deps."hyper"."0.11.27"."mime"}" deps)
    (features_.net2."${deps."hyper"."0.11.27"."net2"}" deps)
    (features_.percent_encoding."${deps."hyper"."0.11.27"."percent_encoding"}" deps)
    (features_.relay."${deps."hyper"."0.11.27"."relay"}" deps)
    (features_.time."${deps."hyper"."0.11.27"."time"}" deps)
    (features_.tokio_core."${deps."hyper"."0.11.27"."tokio_core"}" deps)
    (features_.tokio_io."${deps."hyper"."0.11.27"."tokio_io"}" deps)
    (features_.tokio_proto."${deps."hyper"."0.11.27"."tokio_proto"}" deps)
    (features_.tokio_service."${deps."hyper"."0.11.27"."tokio_service"}" deps)
    (features_.unicase."${deps."hyper"."0.11.27"."unicase"}" deps)
    (features_.want."${deps."hyper"."0.11.27"."want"}" deps)
  ];


  crates.indicatif."0.9.0" = deps: { features?(features_.indicatif."0.9.0" deps {}) }: buildRustCrate {
    crateName = "indicatif";
    version = "0.9.0";
    authors = [ "Armin Ronacher <armin.ronacher@active-4.com>" ];
    sha256 = "0ph5zx5mx4a104ydnzd655aa8a9anhpr9wb9bi4qdjfbdcmyzbh5";
    dependencies = mapFeatures features ([
      (crates."console"."${deps."indicatif"."0.9.0"."console"}" deps)
      (crates."lazy_static"."${deps."indicatif"."0.9.0"."lazy_static"}" deps)
      (crates."parking_lot"."${deps."indicatif"."0.9.0"."parking_lot"}" deps)
      (crates."regex"."${deps."indicatif"."0.9.0"."regex"}" deps)
    ]);
  };
  features_.indicatif."0.9.0" = deps: f: updateFeatures f (rec {
    console."${deps.indicatif."0.9.0".console}".default = true;
    indicatif."0.9.0".default = (f.indicatif."0.9.0".default or true);
    lazy_static."${deps.indicatif."0.9.0".lazy_static}".default = true;
    parking_lot."${deps.indicatif."0.9.0".parking_lot}".default = true;
    regex."${deps.indicatif."0.9.0".regex}".default = true;
  }) [
    (features_.console."${deps."indicatif"."0.9.0"."console"}" deps)
    (features_.lazy_static."${deps."indicatif"."0.9.0"."lazy_static"}" deps)
    (features_.parking_lot."${deps."indicatif"."0.9.0"."parking_lot"}" deps)
    (features_.regex."${deps."indicatif"."0.9.0"."regex"}" deps)
  ];


  crates.iovec."0.1.2" = deps: { features?(features_.iovec."0.1.2" deps {}) }: buildRustCrate {
    crateName = "iovec";
    version = "0.1.2";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0vjymmb7wj4v4kza5jjn48fcdb85j3k37y7msjl3ifz0p9yiyp2r";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."iovec"."0.1.2"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."iovec"."0.1.2"."winapi"}" deps)
    ]) else []);
  };
  features_.iovec."0.1.2" = deps: f: updateFeatures f (rec {
    iovec."0.1.2".default = (f.iovec."0.1.2".default or true);
    libc."${deps.iovec."0.1.2".libc}".default = true;
    winapi."${deps.iovec."0.1.2".winapi}".default = true;
  }) [
    (features_.libc."${deps."iovec"."0.1.2"."libc"}" deps)
    (features_.winapi."${deps."iovec"."0.1.2"."winapi"}" deps)
  ];


  crates.itoa."0.4.3" = deps: { features?(features_.itoa."0.4.3" deps {}) }: buildRustCrate {
    crateName = "itoa";
    version = "0.4.3";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0zadimmdgvili3gdwxqg7ljv3r4wcdg1kkdfp9nl15vnm23vrhy1";
    features = mkFeatures (features."itoa"."0.4.3" or {});
  };
  features_.itoa."0.4.3" = deps: f: updateFeatures f (rec {
    itoa = fold recursiveUpdate {} [
      { "0.4.3".default = (f.itoa."0.4.3".default or true); }
      { "0.4.3".std =
        (f.itoa."0.4.3".std or false) ||
        (f.itoa."0.4.3".default or false) ||
        (itoa."0.4.3"."default" or false); }
    ];
  }) [];


  crates.kernel32_sys."0.2.2" = deps: { features?(features_.kernel32_sys."0.2.2" deps {}) }: buildRustCrate {
    crateName = "kernel32-sys";
    version = "0.2.2";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lrw1hbinyvr6cp28g60z97w32w8vsk6pahk64pmrv2fmby8srfj";
    libName = "kernel32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
    ]);
  };
  features_.kernel32_sys."0.2.2" = deps: f: updateFeatures f (rec {
    kernel32_sys."0.2.2".default = (f.kernel32_sys."0.2.2".default or true);
    winapi."${deps.kernel32_sys."0.2.2".winapi}".default = true;
    winapi_build."${deps.kernel32_sys."0.2.2".winapi_build}".default = true;
  }) [
    (features_.winapi."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    (features_.winapi_build."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
  ];


  crates.language_tags."0.2.2" = deps: { features?(features_.language_tags."0.2.2" deps {}) }: buildRustCrate {
    crateName = "language-tags";
    version = "0.2.2";
    authors = [ "Pyfisch <pyfisch@gmail.com>" ];
    sha256 = "1zkrdzsqzzc7509kd7nngdwrp461glm2g09kqpzaqksp82frjdvy";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."language_tags"."0.2.2" or {});
  };
  features_.language_tags."0.2.2" = deps: f: updateFeatures f (rec {
    language_tags = fold recursiveUpdate {} [
      { "0.2.2".default = (f.language_tags."0.2.2".default or true); }
      { "0.2.2".heapsize =
        (f.language_tags."0.2.2".heapsize or false) ||
        (f.language_tags."0.2.2".heap_size or false) ||
        (language_tags."0.2.2"."heap_size" or false); }
      { "0.2.2".heapsize_plugin =
        (f.language_tags."0.2.2".heapsize_plugin or false) ||
        (f.language_tags."0.2.2".heap_size or false) ||
        (language_tags."0.2.2"."heap_size" or false); }
    ];
  }) [];


  crates.lazy_static."0.2.11" = deps: { features?(features_.lazy_static."0.2.11" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "0.2.11";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1x6871cvpy5b96yv4c7jvpq316fp5d4609s9py7qk6cd6x9k34vm";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."0.2.11" or {});
  };
  features_.lazy_static."0.2.11" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "0.2.11".compiletest_rs =
        (f.lazy_static."0.2.11".compiletest_rs or false) ||
        (f.lazy_static."0.2.11".compiletest or false) ||
        (lazy_static."0.2.11"."compiletest" or false); }
      { "0.2.11".default = (f.lazy_static."0.2.11".default or true); }
      { "0.2.11".nightly =
        (f.lazy_static."0.2.11".nightly or false) ||
        (f.lazy_static."0.2.11".spin_no_std or false) ||
        (lazy_static."0.2.11"."spin_no_std" or false); }
      { "0.2.11".spin =
        (f.lazy_static."0.2.11".spin or false) ||
        (f.lazy_static."0.2.11".spin_no_std or false) ||
        (lazy_static."0.2.11"."spin_no_std" or false); }
    ];
  }) [];


  crates.lazy_static."1.2.0" = deps: { features?(features_.lazy_static."1.2.0" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "1.2.0";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "07p3b30k2akyr6xw08ggd5qiz5nw3vd3agggj360fcc1njz7d0ss";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."1.2.0" or {});
  };
  features_.lazy_static."1.2.0" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "1.2.0".default = (f.lazy_static."1.2.0".default or true); }
      { "1.2.0".spin =
        (f.lazy_static."1.2.0".spin or false) ||
        (f.lazy_static."1.2.0".spin_no_std or false) ||
        (lazy_static."1.2.0"."spin_no_std" or false); }
    ];
  }) [];


  crates.lazycell."1.2.1" = deps: { features?(features_.lazycell."1.2.1" deps {}) }: buildRustCrate {
    crateName = "lazycell";
    version = "1.2.1";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Nikita Pekin <contact@nikitapek.in>" ];
    sha256 = "1m4h2q9rgxrgc7xjnws1x81lrb68jll8w3pykx1a9bhr29q2mcwm";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazycell"."1.2.1" or {});
  };
  features_.lazycell."1.2.1" = deps: f: updateFeatures f (rec {
    lazycell = fold recursiveUpdate {} [
      { "1.2.1".clippy =
        (f.lazycell."1.2.1".clippy or false) ||
        (f.lazycell."1.2.1".nightly-testing or false) ||
        (lazycell."1.2.1"."nightly-testing" or false); }
      { "1.2.1".default = (f.lazycell."1.2.1".default or true); }
      { "1.2.1".nightly =
        (f.lazycell."1.2.1".nightly or false) ||
        (f.lazycell."1.2.1".nightly-testing or false) ||
        (lazycell."1.2.1"."nightly-testing" or false); }
    ];
  }) [];


  crates.libc."0.2.44" = deps: { features?(features_.libc."0.2.44" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.44";
    authors = [ "The Rust Project Developers" ];
    sha256 = "17a7p0lcf3qwl1pcxffdflgnx8zr2659mgzzg4zi5fnv1mlj3q6z";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.44" or {});
  };
  features_.libc."0.2.44" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.44".align =
        (f.libc."0.2.44".align or false) ||
        (f.libc."0.2.44".rustc-dep-of-std or false) ||
        (libc."0.2.44"."rustc-dep-of-std" or false); }
      { "0.2.44".default = (f.libc."0.2.44".default or true); }
      { "0.2.44".rustc-std-workspace-core =
        (f.libc."0.2.44".rustc-std-workspace-core or false) ||
        (f.libc."0.2.44".rustc-dep-of-std or false) ||
        (libc."0.2.44"."rustc-dep-of-std" or false); }
      { "0.2.44".use_std =
        (f.libc."0.2.44".use_std or false) ||
        (f.libc."0.2.44".default or false) ||
        (libc."0.2.44"."default" or false); }
    ];
  }) [];


  crates.linked_hash_map."0.5.1" = deps: { features?(features_.linked_hash_map."0.5.1" deps {}) }: buildRustCrate {
    crateName = "linked-hash-map";
    version = "0.5.1";
    authors = [ "Stepan Koltsov <stepan.koltsov@gmail.com>" "Andrew Paseltiner <apaseltiner@gmail.com>" ];
    sha256 = "1f29c7j53z7w5v0g115yii9dmmbsahr93ak375g48vi75v3p4030";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."linked_hash_map"."0.5.1" or {});
  };
  features_.linked_hash_map."0.5.1" = deps: f: updateFeatures f (rec {
    linked_hash_map = fold recursiveUpdate {} [
      { "0.5.1".default = (f.linked_hash_map."0.5.1".default or true); }
      { "0.5.1".heapsize =
        (f.linked_hash_map."0.5.1".heapsize or false) ||
        (f.linked_hash_map."0.5.1".heapsize_impl or false) ||
        (linked_hash_map."0.5.1"."heapsize_impl" or false); }
      { "0.5.1".serde =
        (f.linked_hash_map."0.5.1".serde or false) ||
        (f.linked_hash_map."0.5.1".serde_impl or false) ||
        (linked_hash_map."0.5.1"."serde_impl" or false); }
      { "0.5.1".serde_test =
        (f.linked_hash_map."0.5.1".serde_test or false) ||
        (f.linked_hash_map."0.5.1".serde_impl or false) ||
        (linked_hash_map."0.5.1"."serde_impl" or false); }
    ];
  }) [];


  crates.lock_api."0.1.5" = deps: { features?(features_.lock_api."0.1.5" deps {}) }: buildRustCrate {
    crateName = "lock_api";
    version = "0.1.5";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "132sidr5hvjfkaqm3l95zpcpi8yk5ddd0g79zf1ad4v65sxirqqm";
    dependencies = mapFeatures features ([
      (crates."scopeguard"."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
    ]
      ++ (if features.lock_api."0.1.5".owning_ref or false then [ (crates.owning_ref."0.4.0" deps) ] else []));
    features = mkFeatures (features."lock_api"."0.1.5" or {});
  };
  features_.lock_api."0.1.5" = deps: f: updateFeatures f (rec {
    lock_api."0.1.5".default = (f.lock_api."0.1.5".default or true);
    owning_ref."${deps.lock_api."0.1.5".owning_ref}".default = true;
    scopeguard."${deps.lock_api."0.1.5".scopeguard}".default = (f.scopeguard."${deps.lock_api."0.1.5".scopeguard}".default or false);
  }) [
    (features_.owning_ref."${deps."lock_api"."0.1.5"."owning_ref"}" deps)
    (features_.scopeguard."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
  ];


  crates.log."0.3.9" = deps: { features?(features_.log."0.3.9" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.3.9";
    authors = [ "The Rust Project Developers" ];
    sha256 = "19i9pwp7lhaqgzangcpw00kc3zsgcqcx84crv07xgz3v7d3kvfa2";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."log"."0.3.9"."log"}" deps)
    ]);
    features = mkFeatures (features."log"."0.3.9" or {});
  };
  features_.log."0.3.9" = deps: f: updateFeatures f (rec {
    log = fold recursiveUpdate {} [
      { "${deps.log."0.3.9".log}".default = true; }
      { "0.3.9".default = (f.log."0.3.9".default or true); }
      { "0.3.9".use_std =
        (f.log."0.3.9".use_std or false) ||
        (f.log."0.3.9".default or false) ||
        (log."0.3.9"."default" or false); }
      { "0.4.6".max_level_debug =
        (f.log."0.4.6".max_level_debug or false) ||
        (log."0.3.9"."max_level_debug" or false) ||
        (f."log"."0.3.9"."max_level_debug" or false); }
      { "0.4.6".max_level_error =
        (f.log."0.4.6".max_level_error or false) ||
        (log."0.3.9"."max_level_error" or false) ||
        (f."log"."0.3.9"."max_level_error" or false); }
      { "0.4.6".max_level_info =
        (f.log."0.4.6".max_level_info or false) ||
        (log."0.3.9"."max_level_info" or false) ||
        (f."log"."0.3.9"."max_level_info" or false); }
      { "0.4.6".max_level_off =
        (f.log."0.4.6".max_level_off or false) ||
        (log."0.3.9"."max_level_off" or false) ||
        (f."log"."0.3.9"."max_level_off" or false); }
      { "0.4.6".max_level_trace =
        (f.log."0.4.6".max_level_trace or false) ||
        (log."0.3.9"."max_level_trace" or false) ||
        (f."log"."0.3.9"."max_level_trace" or false); }
      { "0.4.6".max_level_warn =
        (f.log."0.4.6".max_level_warn or false) ||
        (log."0.3.9"."max_level_warn" or false) ||
        (f."log"."0.3.9"."max_level_warn" or false); }
      { "0.4.6".release_max_level_debug =
        (f.log."0.4.6".release_max_level_debug or false) ||
        (log."0.3.9"."release_max_level_debug" or false) ||
        (f."log"."0.3.9"."release_max_level_debug" or false); }
      { "0.4.6".release_max_level_error =
        (f.log."0.4.6".release_max_level_error or false) ||
        (log."0.3.9"."release_max_level_error" or false) ||
        (f."log"."0.3.9"."release_max_level_error" or false); }
      { "0.4.6".release_max_level_info =
        (f.log."0.4.6".release_max_level_info or false) ||
        (log."0.3.9"."release_max_level_info" or false) ||
        (f."log"."0.3.9"."release_max_level_info" or false); }
      { "0.4.6".release_max_level_off =
        (f.log."0.4.6".release_max_level_off or false) ||
        (log."0.3.9"."release_max_level_off" or false) ||
        (f."log"."0.3.9"."release_max_level_off" or false); }
      { "0.4.6".release_max_level_trace =
        (f.log."0.4.6".release_max_level_trace or false) ||
        (log."0.3.9"."release_max_level_trace" or false) ||
        (f."log"."0.3.9"."release_max_level_trace" or false); }
      { "0.4.6".release_max_level_warn =
        (f.log."0.4.6".release_max_level_warn or false) ||
        (log."0.3.9"."release_max_level_warn" or false) ||
        (f."log"."0.3.9"."release_max_level_warn" or false); }
      { "0.4.6".std =
        (f.log."0.4.6".std or false) ||
        (log."0.3.9"."use_std" or false) ||
        (f."log"."0.3.9"."use_std" or false); }
    ];
  }) [
    (features_.log."${deps."log"."0.3.9"."log"}" deps)
  ];


  crates.log."0.4.6" = deps: { features?(features_.log."0.4.6" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.4.6";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1nd8dl9mvc9vd6fks5d4gsxaz990xi6rzlb8ymllshmwi153vngr";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."log"."0.4.6"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."log"."0.4.6" or {});
  };
  features_.log."0.4.6" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.log."0.4.6".cfg_if}".default = true;
    log."0.4.6".default = (f.log."0.4.6".default or true);
  }) [
    (features_.cfg_if."${deps."log"."0.4.6"."cfg_if"}" deps)
  ];


  crates.memchr."2.1.1" = deps: { features?(features_.memchr."2.1.1" deps {}) }: buildRustCrate {
    crateName = "memchr";
    version = "2.1.1";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" "bluss" ];
    sha256 = "1s9ihgdk2bhnqch3y2j6g2z206x3l925bwvhzpvjmdsvycc5jwll";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."memchr"."2.1.1"."cfg_if"}" deps)
    ]
      ++ (if features.memchr."2.1.1".libc or false then [ (crates.libc."0.2.44" deps) ] else []));

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."memchr"."2.1.1"."version_check"}" deps)
    ]);
    features = mkFeatures (features."memchr"."2.1.1" or {});
  };
  features_.memchr."2.1.1" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.memchr."2.1.1".cfg_if}".default = true;
    libc = fold recursiveUpdate {} [
      { "${deps.memchr."2.1.1".libc}".default = (f.libc."${deps.memchr."2.1.1".libc}".default or false); }
      { "0.2.44".use_std =
        (f.libc."0.2.44".use_std or false) ||
        (memchr."2.1.1"."use_std" or false) ||
        (f."memchr"."2.1.1"."use_std" or false); }
    ];
    memchr = fold recursiveUpdate {} [
      { "2.1.1".default = (f.memchr."2.1.1".default or true); }
      { "2.1.1".libc =
        (f.memchr."2.1.1".libc or false) ||
        (f.memchr."2.1.1".default or false) ||
        (memchr."2.1.1"."default" or false) ||
        (f.memchr."2.1.1".use_std or false) ||
        (memchr."2.1.1"."use_std" or false); }
      { "2.1.1".use_std =
        (f.memchr."2.1.1".use_std or false) ||
        (f.memchr."2.1.1".default or false) ||
        (memchr."2.1.1"."default" or false); }
    ];
    version_check."${deps.memchr."2.1.1".version_check}".default = true;
  }) [
    (features_.cfg_if."${deps."memchr"."2.1.1"."cfg_if"}" deps)
    (features_.libc."${deps."memchr"."2.1.1"."libc"}" deps)
    (features_.version_check."${deps."memchr"."2.1.1"."version_check"}" deps)
  ];


  crates.memoffset."0.2.1" = deps: { features?(features_.memoffset."0.2.1" deps {}) }: buildRustCrate {
    crateName = "memoffset";
    version = "0.2.1";
    authors = [ "Gilad Naaman <gilad.naaman@gmail.com>" ];
    sha256 = "00vym01jk9slibq2nsiilgffp7n6k52a4q3n4dqp0xf5kzxvffcf";
  };
  features_.memoffset."0.2.1" = deps: f: updateFeatures f (rec {
    memoffset."0.2.1".default = (f.memoffset."0.2.1".default or true);
  }) [];


  crates.mime."0.3.12" = deps: { features?(features_.mime."0.3.12" deps {}) }: buildRustCrate {
    crateName = "mime";
    version = "0.3.12";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0lmcwkmxwbla9457w9ak13cfgqxfyn5wa1syjy1kll2ras5xifvh";
    dependencies = mapFeatures features ([
      (crates."unicase"."${deps."mime"."0.3.12"."unicase"}" deps)
    ]);
  };
  features_.mime."0.3.12" = deps: f: updateFeatures f (rec {
    mime."0.3.12".default = (f.mime."0.3.12".default or true);
    unicase."${deps.mime."0.3.12".unicase}".default = true;
  }) [
    (features_.unicase."${deps."mime"."0.3.12"."unicase"}" deps)
  ];


  crates.mio."0.6.16" = deps: { features?(features_.mio."0.6.16" deps {}) }: buildRustCrate {
    crateName = "mio";
    version = "0.6.16";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "14vyrlmf0w984pi7ad9qvmlfj6vrb0wn6i8ik9j87w5za2r3rban";
    dependencies = mapFeatures features ([
      (crates."iovec"."${deps."mio"."0.6.16"."iovec"}" deps)
      (crates."lazycell"."${deps."mio"."0.6.16"."lazycell"}" deps)
      (crates."log"."${deps."mio"."0.6.16"."log"}" deps)
      (crates."net2"."${deps."mio"."0.6.16"."net2"}" deps)
      (crates."slab"."${deps."mio"."0.6.16"."slab"}" deps)
    ])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_zircon"."${deps."mio"."0.6.16"."fuchsia_zircon"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."mio"."0.6.16"."fuchsia_zircon_sys"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."mio"."0.6.16"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."mio"."0.6.16"."kernel32_sys"}" deps)
      (crates."miow"."${deps."mio"."0.6.16"."miow"}" deps)
      (crates."winapi"."${deps."mio"."0.6.16"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."mio"."0.6.16" or {});
  };
  features_.mio."0.6.16" = deps: f: updateFeatures f (rec {
    fuchsia_zircon."${deps.mio."0.6.16".fuchsia_zircon}".default = true;
    fuchsia_zircon_sys."${deps.mio."0.6.16".fuchsia_zircon_sys}".default = true;
    iovec."${deps.mio."0.6.16".iovec}".default = true;
    kernel32_sys."${deps.mio."0.6.16".kernel32_sys}".default = true;
    lazycell."${deps.mio."0.6.16".lazycell}".default = true;
    libc."${deps.mio."0.6.16".libc}".default = true;
    log."${deps.mio."0.6.16".log}".default = true;
    mio = fold recursiveUpdate {} [
      { "0.6.16".default = (f.mio."0.6.16".default or true); }
      { "0.6.16".with-deprecated =
        (f.mio."0.6.16".with-deprecated or false) ||
        (f.mio."0.6.16".default or false) ||
        (mio."0.6.16"."default" or false); }
    ];
    miow."${deps.mio."0.6.16".miow}".default = true;
    net2."${deps.mio."0.6.16".net2}".default = true;
    slab."${deps.mio."0.6.16".slab}".default = true;
    winapi."${deps.mio."0.6.16".winapi}".default = true;
  }) [
    (features_.iovec."${deps."mio"."0.6.16"."iovec"}" deps)
    (features_.lazycell."${deps."mio"."0.6.16"."lazycell"}" deps)
    (features_.log."${deps."mio"."0.6.16"."log"}" deps)
    (features_.net2."${deps."mio"."0.6.16"."net2"}" deps)
    (features_.slab."${deps."mio"."0.6.16"."slab"}" deps)
    (features_.fuchsia_zircon."${deps."mio"."0.6.16"."fuchsia_zircon"}" deps)
    (features_.fuchsia_zircon_sys."${deps."mio"."0.6.16"."fuchsia_zircon_sys"}" deps)
    (features_.libc."${deps."mio"."0.6.16"."libc"}" deps)
    (features_.kernel32_sys."${deps."mio"."0.6.16"."kernel32_sys"}" deps)
    (features_.miow."${deps."mio"."0.6.16"."miow"}" deps)
    (features_.winapi."${deps."mio"."0.6.16"."winapi"}" deps)
  ];


  crates.mio_uds."0.6.7" = deps: { features?(features_.mio_uds."0.6.7" deps {}) }: buildRustCrate {
    crateName = "mio-uds";
    version = "0.6.7";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1gff9908pvvysv7zgxvyxy7x34fnhs088cr0j8mgwj8j24mswrhm";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."iovec"."${deps."mio_uds"."0.6.7"."iovec"}" deps)
      (crates."libc"."${deps."mio_uds"."0.6.7"."libc"}" deps)
      (crates."mio"."${deps."mio_uds"."0.6.7"."mio"}" deps)
    ]) else []);
  };
  features_.mio_uds."0.6.7" = deps: f: updateFeatures f (rec {
    iovec."${deps.mio_uds."0.6.7".iovec}".default = true;
    libc."${deps.mio_uds."0.6.7".libc}".default = true;
    mio."${deps.mio_uds."0.6.7".mio}".default = true;
    mio_uds."0.6.7".default = (f.mio_uds."0.6.7".default or true);
  }) [
    (features_.iovec."${deps."mio_uds"."0.6.7"."iovec"}" deps)
    (features_.libc."${deps."mio_uds"."0.6.7"."libc"}" deps)
    (features_.mio."${deps."mio_uds"."0.6.7"."mio"}" deps)
  ];


  crates.miow."0.2.1" = deps: { features?(features_.miow."0.2.1" deps {}) }: buildRustCrate {
    crateName = "miow";
    version = "0.2.1";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "14f8zkc6ix7mkyis1vsqnim8m29b6l55abkba3p2yz7j1ibcvrl0";
    dependencies = mapFeatures features ([
      (crates."kernel32_sys"."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
      (crates."net2"."${deps."miow"."0.2.1"."net2"}" deps)
      (crates."winapi"."${deps."miow"."0.2.1"."winapi"}" deps)
      (crates."ws2_32_sys"."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
    ]);
  };
  features_.miow."0.2.1" = deps: f: updateFeatures f (rec {
    kernel32_sys."${deps.miow."0.2.1".kernel32_sys}".default = true;
    miow."0.2.1".default = (f.miow."0.2.1".default or true);
    net2."${deps.miow."0.2.1".net2}".default = (f.net2."${deps.miow."0.2.1".net2}".default or false);
    winapi."${deps.miow."0.2.1".winapi}".default = true;
    ws2_32_sys."${deps.miow."0.2.1".ws2_32_sys}".default = true;
  }) [
    (features_.kernel32_sys."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
    (features_.net2."${deps."miow"."0.2.1"."net2"}" deps)
    (features_.winapi."${deps."miow"."0.2.1"."winapi"}" deps)
    (features_.ws2_32_sys."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
  ];


  crates.net2."0.2.33" = deps: { features?(features_.net2."0.2.33" deps {}) }: buildRustCrate {
    crateName = "net2";
    version = "0.2.33";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1qnmajafgybj5wyxz9iffa8x5wgbwd2znfklmhqj7vl6lw1m65mq";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."net2"."0.2.33"."cfg_if"}" deps)
    ])
      ++ (if kernel == "redox" || (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."net2"."0.2.33"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."net2"."0.2.33"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."net2"."0.2.33" or {});
  };
  features_.net2."0.2.33" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.net2."0.2.33".cfg_if}".default = true;
    libc."${deps.net2."0.2.33".libc}".default = true;
    net2 = fold recursiveUpdate {} [
      { "0.2.33".default = (f.net2."0.2.33".default or true); }
      { "0.2.33".duration =
        (f.net2."0.2.33".duration or false) ||
        (f.net2."0.2.33".default or false) ||
        (net2."0.2.33"."default" or false); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.net2."0.2.33".winapi}"."handleapi" = true; }
      { "${deps.net2."0.2.33".winapi}"."winsock2" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2def" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2ipdef" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2tcpip" = true; }
      { "${deps.net2."0.2.33".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."net2"."0.2.33"."cfg_if"}" deps)
    (features_.libc."${deps."net2"."0.2.33"."libc"}" deps)
    (features_.winapi."${deps."net2"."0.2.33"."winapi"}" deps)
  ];


  crates.nodrop."0.1.13" = deps: { features?(features_.nodrop."0.1.13" deps {}) }: buildRustCrate {
    crateName = "nodrop";
    version = "0.1.13";
    authors = [ "bluss" ];
    sha256 = "0gkfx6wihr9z0m8nbdhma5pyvbipznjpkzny2d4zkc05b0vnhinb";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."nodrop"."0.1.13" or {});
  };
  features_.nodrop."0.1.13" = deps: f: updateFeatures f (rec {
    nodrop = fold recursiveUpdate {} [
      { "0.1.13".default = (f.nodrop."0.1.13".default or true); }
      { "0.1.13".nodrop-union =
        (f.nodrop."0.1.13".nodrop-union or false) ||
        (f.nodrop."0.1.13".use_union or false) ||
        (nodrop."0.1.13"."use_union" or false); }
      { "0.1.13".std =
        (f.nodrop."0.1.13".std or false) ||
        (f.nodrop."0.1.13".default or false) ||
        (nodrop."0.1.13"."default" or false); }
    ];
  }) [];


  crates.num_cpus."1.8.0" = deps: { features?(features_.num_cpus."1.8.0" deps {}) }: buildRustCrate {
    crateName = "num_cpus";
    version = "1.8.0";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1y6qnd9r8ga6y8mvlabdrr73nc8cshjjlzbvnanzyj9b8zzkfwk2";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."num_cpus"."1.8.0"."libc"}" deps)
    ]);
  };
  features_.num_cpus."1.8.0" = deps: f: updateFeatures f (rec {
    libc."${deps.num_cpus."1.8.0".libc}".default = true;
    num_cpus."1.8.0".default = (f.num_cpus."1.8.0".default or true);
  }) [
    (features_.libc."${deps."num_cpus"."1.8.0"."libc"}" deps)
  ];


  crates.owning_ref."0.4.0" = deps: { features?(features_.owning_ref."0.4.0" deps {}) }: buildRustCrate {
    crateName = "owning_ref";
    version = "0.4.0";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1m95qpc3hamkw9wlbfzqkzk7h6skyj40zr6sa3ps151slcfnnchm";
    dependencies = mapFeatures features ([
      (crates."stable_deref_trait"."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
    ]);
  };
  features_.owning_ref."0.4.0" = deps: f: updateFeatures f (rec {
    owning_ref."0.4.0".default = (f.owning_ref."0.4.0".default or true);
    stable_deref_trait."${deps.owning_ref."0.4.0".stable_deref_trait}".default = true;
  }) [
    (features_.stable_deref_trait."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
  ];


  crates.parking_lot."0.6.4" = deps: { features?(features_.parking_lot."0.6.4" deps {}) }: buildRustCrate {
    crateName = "parking_lot";
    version = "0.6.4";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "0qwfysx8zfkj72sfcrqvd6pp7lgjmklyixsi3y0g6xjspw876rax";
    dependencies = mapFeatures features ([
      (crates."lock_api"."${deps."parking_lot"."0.6.4"."lock_api"}" deps)
      (crates."parking_lot_core"."${deps."parking_lot"."0.6.4"."parking_lot_core"}" deps)
    ]);
    features = mkFeatures (features."parking_lot"."0.6.4" or {});
  };
  features_.parking_lot."0.6.4" = deps: f: updateFeatures f (rec {
    lock_api = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.6.4".lock_api}".default = true; }
      { "0.1.5".nightly =
        (f.lock_api."0.1.5".nightly or false) ||
        (parking_lot."0.6.4"."nightly" or false) ||
        (f."parking_lot"."0.6.4"."nightly" or false); }
      { "0.1.5".owning_ref =
        (f.lock_api."0.1.5".owning_ref or false) ||
        (parking_lot."0.6.4"."owning_ref" or false) ||
        (f."parking_lot"."0.6.4"."owning_ref" or false); }
    ];
    parking_lot = fold recursiveUpdate {} [
      { "0.6.4".default = (f.parking_lot."0.6.4".default or true); }
      { "0.6.4".owning_ref =
        (f.parking_lot."0.6.4".owning_ref or false) ||
        (f.parking_lot."0.6.4".default or false) ||
        (parking_lot."0.6.4"."default" or false); }
    ];
    parking_lot_core = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.6.4".parking_lot_core}".default = true; }
      { "0.3.1".deadlock_detection =
        (f.parking_lot_core."0.3.1".deadlock_detection or false) ||
        (parking_lot."0.6.4"."deadlock_detection" or false) ||
        (f."parking_lot"."0.6.4"."deadlock_detection" or false); }
      { "0.3.1".nightly =
        (f.parking_lot_core."0.3.1".nightly or false) ||
        (parking_lot."0.6.4"."nightly" or false) ||
        (f."parking_lot"."0.6.4"."nightly" or false); }
    ];
  }) [
    (features_.lock_api."${deps."parking_lot"."0.6.4"."lock_api"}" deps)
    (features_.parking_lot_core."${deps."parking_lot"."0.6.4"."parking_lot_core"}" deps)
  ];


  crates.parking_lot."0.7.0" = deps: { features?(features_.parking_lot."0.7.0" deps {}) }: buildRustCrate {
    crateName = "parking_lot";
    version = "0.7.0";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1vpfl9zcsy8ajzm7skxi5r7z0xzn4r8rzqr0mrpmz2r3q5nyxlab";
    dependencies = mapFeatures features ([
      (crates."lock_api"."${deps."parking_lot"."0.7.0"."lock_api"}" deps)
      (crates."parking_lot_core"."${deps."parking_lot"."0.7.0"."parking_lot_core"}" deps)
    ]);
    features = mkFeatures (features."parking_lot"."0.7.0" or {});
  };
  features_.parking_lot."0.7.0" = deps: f: updateFeatures f (rec {
    lock_api = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.0".lock_api}".default = true; }
      { "0.1.5".nightly =
        (f.lock_api."0.1.5".nightly or false) ||
        (parking_lot."0.7.0"."nightly" or false) ||
        (f."parking_lot"."0.7.0"."nightly" or false); }
      { "0.1.5".owning_ref =
        (f.lock_api."0.1.5".owning_ref or false) ||
        (parking_lot."0.7.0"."owning_ref" or false) ||
        (f."parking_lot"."0.7.0"."owning_ref" or false); }
    ];
    parking_lot = fold recursiveUpdate {} [
      { "0.7.0".default = (f.parking_lot."0.7.0".default or true); }
      { "0.7.0".owning_ref =
        (f.parking_lot."0.7.0".owning_ref or false) ||
        (f.parking_lot."0.7.0".default or false) ||
        (parking_lot."0.7.0"."default" or false); }
    ];
    parking_lot_core = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.0".parking_lot_core}".default = true; }
      { "0.4.0".deadlock_detection =
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot."0.7.0"."deadlock_detection" or false) ||
        (f."parking_lot"."0.7.0"."deadlock_detection" or false); }
      { "0.4.0".nightly =
        (f.parking_lot_core."0.4.0".nightly or false) ||
        (parking_lot."0.7.0"."nightly" or false) ||
        (f."parking_lot"."0.7.0"."nightly" or false); }
    ];
  }) [
    (features_.lock_api."${deps."parking_lot"."0.7.0"."lock_api"}" deps)
    (features_.parking_lot_core."${deps."parking_lot"."0.7.0"."parking_lot_core"}" deps)
  ];


  crates.parking_lot_core."0.3.1" = deps: { features?(features_.parking_lot_core."0.3.1" deps {}) }: buildRustCrate {
    crateName = "parking_lot_core";
    version = "0.3.1";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "0h5p7dys8cx9y6ii4i57ampf7qdr8zmkpn543kd3h7nkhml8bw72";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."parking_lot_core"."0.3.1"."rand"}" deps)
      (crates."smallvec"."${deps."parking_lot_core"."0.3.1"."smallvec"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."parking_lot_core"."0.3.1"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."parking_lot_core"."0.3.1"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."parking_lot_core"."0.3.1"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."parking_lot_core"."0.3.1" or {});
  };
  features_.parking_lot_core."0.3.1" = deps: f: updateFeatures f (rec {
    libc."${deps.parking_lot_core."0.3.1".libc}".default = true;
    parking_lot_core = fold recursiveUpdate {} [
      { "0.3.1".backtrace =
        (f.parking_lot_core."0.3.1".backtrace or false) ||
        (f.parking_lot_core."0.3.1".deadlock_detection or false) ||
        (parking_lot_core."0.3.1"."deadlock_detection" or false); }
      { "0.3.1".default = (f.parking_lot_core."0.3.1".default or true); }
      { "0.3.1".petgraph =
        (f.parking_lot_core."0.3.1".petgraph or false) ||
        (f.parking_lot_core."0.3.1".deadlock_detection or false) ||
        (parking_lot_core."0.3.1"."deadlock_detection" or false); }
      { "0.3.1".thread-id =
        (f.parking_lot_core."0.3.1".thread-id or false) ||
        (f.parking_lot_core."0.3.1".deadlock_detection or false) ||
        (parking_lot_core."0.3.1"."deadlock_detection" or false); }
    ];
    rand."${deps.parking_lot_core."0.3.1".rand}".default = true;
    rustc_version."${deps.parking_lot_core."0.3.1".rustc_version}".default = true;
    smallvec."${deps.parking_lot_core."0.3.1".smallvec}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.parking_lot_core."0.3.1".winapi}"."errhandlingapi" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."handleapi" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."minwindef" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."ntstatus" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."winbase" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."winerror" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}"."winnt" = true; }
      { "${deps.parking_lot_core."0.3.1".winapi}".default = true; }
    ];
  }) [
    (features_.rand."${deps."parking_lot_core"."0.3.1"."rand"}" deps)
    (features_.smallvec."${deps."parking_lot_core"."0.3.1"."smallvec"}" deps)
    (features_.rustc_version."${deps."parking_lot_core"."0.3.1"."rustc_version"}" deps)
    (features_.libc."${deps."parking_lot_core"."0.3.1"."libc"}" deps)
    (features_.winapi."${deps."parking_lot_core"."0.3.1"."winapi"}" deps)
  ];


  crates.parking_lot_core."0.4.0" = deps: { features?(features_.parking_lot_core."0.4.0" deps {}) }: buildRustCrate {
    crateName = "parking_lot_core";
    version = "0.4.0";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1mzk5i240ddvhwnz65hhjk4cq61z235g1n8bd7al4mg6vx437c16";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
      (crates."smallvec"."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."parking_lot_core"."0.4.0" or {});
  };
  features_.parking_lot_core."0.4.0" = deps: f: updateFeatures f (rec {
    libc."${deps.parking_lot_core."0.4.0".libc}".default = true;
    parking_lot_core = fold recursiveUpdate {} [
      { "0.4.0".backtrace =
        (f.parking_lot_core."0.4.0".backtrace or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0".default = (f.parking_lot_core."0.4.0".default or true); }
      { "0.4.0".petgraph =
        (f.parking_lot_core."0.4.0".petgraph or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0".thread-id =
        (f.parking_lot_core."0.4.0".thread-id or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
    ];
    rand."${deps.parking_lot_core."0.4.0".rand}".default = true;
    rustc_version."${deps.parking_lot_core."0.4.0".rustc_version}".default = true;
    smallvec."${deps.parking_lot_core."0.4.0".smallvec}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.parking_lot_core."0.4.0".winapi}"."errhandlingapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."handleapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."minwindef" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."ntstatus" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winbase" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winerror" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winnt" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}".default = true; }
    ];
  }) [
    (features_.rand."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
    (features_.smallvec."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    (features_.rustc_version."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    (features_.libc."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    (features_.winapi."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
  ];


  crates.percent_encoding."1.0.1" = deps: { features?(features_.percent_encoding."1.0.1" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "1.0.1";
    authors = [ "The rust-url developers" ];
    sha256 = "04ahrp7aw4ip7fmadb0bknybmkfav0kk0gw4ps3ydq5w6hr0ib5i";
    libPath = "lib.rs";
  };
  features_.percent_encoding."1.0.1" = deps: f: updateFeatures f (rec {
    percent_encoding."1.0.1".default = (f.percent_encoding."1.0.1".default or true);
  }) [];


  crates.proc_macro2."0.4.24" = deps: { features?(features_.proc_macro2."0.4.24" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "0.4.24";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0ra2z9j3h0bbfq40p8mfwf28shnbxqryb45pfzg47xaszf85ylv2";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."0.4.24"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."0.4.24" or {});
  };
  features_.proc_macro2."0.4.24" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "0.4.24".default = (f.proc_macro2."0.4.24".default or true); }
      { "0.4.24".proc-macro =
        (f.proc_macro2."0.4.24".proc-macro or false) ||
        (f.proc_macro2."0.4.24".default or false) ||
        (proc_macro2."0.4.24"."default" or false) ||
        (f.proc_macro2."0.4.24".nightly or false) ||
        (proc_macro2."0.4.24"."nightly" or false); }
    ];
    unicode_xid."${deps.proc_macro2."0.4.24".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."0.4.24"."unicode_xid"}" deps)
  ];


  crates.quick_error."1.2.2" = deps: { features?(features_.quick_error."1.2.2" deps {}) }: buildRustCrate {
    crateName = "quick-error";
    version = "1.2.2";
    authors = [ "Paul Colomiets <paul@colomiets.name>" "Colin Kiegel <kiegel@gmx.de>" ];
    sha256 = "192a3adc5phgpibgqblsdx1b421l5yg9bjbmv552qqq9f37h60k5";
  };
  features_.quick_error."1.2.2" = deps: f: updateFeatures f (rec {
    quick_error."1.2.2".default = (f.quick_error."1.2.2".default or true);
  }) [];


  crates.quote."0.6.10" = deps: { features?(features_.quote."0.6.10" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "0.6.10";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0q5dlhk9hz795872fsf02vlbazx691393j7q426q590vdqcgj0qx";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."0.6.10"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."0.6.10" or {});
  };
  features_.quote."0.6.10" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."0.6.10".proc_macro2}".default = (f.proc_macro2."${deps.quote."0.6.10".proc_macro2}".default or false); }
      { "0.4.24".proc-macro =
        (f.proc_macro2."0.4.24".proc-macro or false) ||
        (quote."0.6.10"."proc-macro" or false) ||
        (f."quote"."0.6.10"."proc-macro" or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "0.6.10".default = (f.quote."0.6.10".default or true); }
      { "0.6.10".proc-macro =
        (f.quote."0.6.10".proc-macro or false) ||
        (f.quote."0.6.10".default or false) ||
        (quote."0.6.10"."default" or false); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."0.6.10"."proc_macro2"}" deps)
  ];


  crates.rand."0.3.22" = deps: { features?(features_.rand."0.3.22" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.3.22";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0wrj12acx7l4hr7ag3nz8b50yhp8ancyq988bzmnnsxln67rsys0";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."rand"."0.3.22"."libc"}" deps)
      (crates."rand"."${deps."rand"."0.3.22"."rand"}" deps)
    ])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_zircon"."${deps."rand"."0.3.22"."fuchsia_zircon"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.3.22" or {});
  };
  features_.rand."0.3.22" = deps: f: updateFeatures f (rec {
    fuchsia_zircon."${deps.rand."0.3.22".fuchsia_zircon}".default = true;
    libc."${deps.rand."0.3.22".libc}".default = true;
    rand = fold recursiveUpdate {} [
      { "${deps.rand."0.3.22".rand}".default = true; }
      { "0.3.22".default = (f.rand."0.3.22".default or true); }
      { "0.3.22".i128_support =
        (f.rand."0.3.22".i128_support or false) ||
        (f.rand."0.3.22".nightly or false) ||
        (rand."0.3.22"."nightly" or false); }
    ];
  }) [
    (features_.libc."${deps."rand"."0.3.22"."libc"}" deps)
    (features_.rand."${deps."rand"."0.3.22"."rand"}" deps)
    (features_.fuchsia_zircon."${deps."rand"."0.3.22"."fuchsia_zircon"}" deps)
  ];


  crates.rand."0.4.3" = deps: { features?(features_.rand."0.4.3" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.4.3";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1644wri45l147822xy7dgdm4k7myxzs66cb795ga0x7dan11ci4f";
    dependencies = (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_zircon"."${deps."rand"."0.4.3"."fuchsia_zircon"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.4.3".libc or false then [ (crates.libc."0.2.44" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.4.3"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.4.3" or {});
  };
  features_.rand."0.4.3" = deps: f: updateFeatures f (rec {
    fuchsia_zircon."${deps.rand."0.4.3".fuchsia_zircon}".default = true;
    libc."${deps.rand."0.4.3".libc}".default = true;
    rand = fold recursiveUpdate {} [
      { "0.4.3".default = (f.rand."0.4.3".default or true); }
      { "0.4.3".i128_support =
        (f.rand."0.4.3".i128_support or false) ||
        (f.rand."0.4.3".nightly or false) ||
        (rand."0.4.3"."nightly" or false); }
      { "0.4.3".libc =
        (f.rand."0.4.3".libc or false) ||
        (f.rand."0.4.3".std or false) ||
        (rand."0.4.3"."std" or false); }
      { "0.4.3".std =
        (f.rand."0.4.3".std or false) ||
        (f.rand."0.4.3".default or false) ||
        (rand."0.4.3"."default" or false); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.4.3".winapi}"."minwindef" = true; }
      { "${deps.rand."0.4.3".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.4.3".winapi}"."profileapi" = true; }
      { "${deps.rand."0.4.3".winapi}"."winnt" = true; }
      { "${deps.rand."0.4.3".winapi}".default = true; }
    ];
  }) [
    (features_.fuchsia_zircon."${deps."rand"."0.4.3"."fuchsia_zircon"}" deps)
    (features_.libc."${deps."rand"."0.4.3"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.4.3"."winapi"}" deps)
  ];


  crates.rand."0.5.5" = deps: { features?(features_.rand."0.5.5" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.5.5";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0d7pnsh57qxhz1ghrzk113ddkn13kf2g758ffnbxq4nhwjfzhlc9";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.5.5"."rand_core"}" deps)
    ])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.5".cloudabi or false then [ (crates.cloudabi."0.0.3" deps) ] else [])) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.5".fuchsia-zircon or false then [ (crates.fuchsia_zircon."0.3.3" deps) ] else [])) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.5".libc or false then [ (crates.libc."0.2.44" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.5".winapi or false then [ (crates.winapi."0.3.6" deps) ] else [])) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."rand"."0.5.5" or {});
  };
  features_.rand."0.5.5" = deps: f: updateFeatures f (rec {
    cloudabi."${deps.rand."0.5.5".cloudabi}".default = true;
    fuchsia_zircon."${deps.rand."0.5.5".fuchsia_zircon}".default = true;
    libc."${deps.rand."0.5.5".libc}".default = true;
    rand = fold recursiveUpdate {} [
      { "0.5.5".alloc =
        (f.rand."0.5.5".alloc or false) ||
        (f.rand."0.5.5".std or false) ||
        (rand."0.5.5"."std" or false); }
      { "0.5.5".cloudabi =
        (f.rand."0.5.5".cloudabi or false) ||
        (f.rand."0.5.5".std or false) ||
        (rand."0.5.5"."std" or false); }
      { "0.5.5".default = (f.rand."0.5.5".default or true); }
      { "0.5.5".fuchsia-zircon =
        (f.rand."0.5.5".fuchsia-zircon or false) ||
        (f.rand."0.5.5".std or false) ||
        (rand."0.5.5"."std" or false); }
      { "0.5.5".i128_support =
        (f.rand."0.5.5".i128_support or false) ||
        (f.rand."0.5.5".nightly or false) ||
        (rand."0.5.5"."nightly" or false); }
      { "0.5.5".libc =
        (f.rand."0.5.5".libc or false) ||
        (f.rand."0.5.5".std or false) ||
        (rand."0.5.5"."std" or false); }
      { "0.5.5".serde =
        (f.rand."0.5.5".serde or false) ||
        (f.rand."0.5.5".serde1 or false) ||
        (rand."0.5.5"."serde1" or false); }
      { "0.5.5".serde_derive =
        (f.rand."0.5.5".serde_derive or false) ||
        (f.rand."0.5.5".serde1 or false) ||
        (rand."0.5.5"."serde1" or false); }
      { "0.5.5".std =
        (f.rand."0.5.5".std or false) ||
        (f.rand."0.5.5".default or false) ||
        (rand."0.5.5"."default" or false); }
      { "0.5.5".winapi =
        (f.rand."0.5.5".winapi or false) ||
        (f.rand."0.5.5".std or false) ||
        (rand."0.5.5"."std" or false); }
    ];
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.5.5".rand_core}".default = (f.rand_core."${deps.rand."0.5.5".rand_core}".default or false); }
      { "0.2.2".alloc =
        (f.rand_core."0.2.2".alloc or false) ||
        (rand."0.5.5"."alloc" or false) ||
        (f."rand"."0.5.5"."alloc" or false); }
      { "0.2.2".serde1 =
        (f.rand_core."0.2.2".serde1 or false) ||
        (rand."0.5.5"."serde1" or false) ||
        (f."rand"."0.5.5"."serde1" or false); }
      { "0.2.2".std =
        (f.rand_core."0.2.2".std or false) ||
        (rand."0.5.5"."std" or false) ||
        (f."rand"."0.5.5"."std" or false); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.5.5".winapi}"."minwindef" = true; }
      { "${deps.rand."0.5.5".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.5.5".winapi}"."profileapi" = true; }
      { "${deps.rand."0.5.5".winapi}"."winnt" = true; }
      { "${deps.rand."0.5.5".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand"."0.5.5"."rand_core"}" deps)
    (features_.cloudabi."${deps."rand"."0.5.5"."cloudabi"}" deps)
    (features_.fuchsia_zircon."${deps."rand"."0.5.5"."fuchsia_zircon"}" deps)
    (features_.libc."${deps."rand"."0.5.5"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.5.5"."winapi"}" deps)
  ];


  crates.rand."0.6.1" = deps: { features?(features_.rand."0.6.1" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.6.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "123s3w165iiifmf475lisqkd0kbr7nwnn3k4b1zg2cwap5v9m9bz";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.6.1"."rand_chacha"}" deps)
      (crates."rand_core"."${deps."rand"."0.6.1"."rand_core"}" deps)
      (crates."rand_hc"."${deps."rand"."0.6.1"."rand_hc"}" deps)
      (crates."rand_isaac"."${deps."rand"."0.6.1"."rand_isaac"}" deps)
      (crates."rand_pcg"."${deps."rand"."0.6.1"."rand_pcg"}" deps)
      (crates."rand_xorshift"."${deps."rand"."0.6.1"."rand_xorshift"}" deps)
    ])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
    ]
      ++ (if features.rand."0.6.1".cloudabi or false then [ (crates.cloudabi."0.0.3" deps) ] else [])) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
    ]
      ++ (if features.rand."0.6.1".fuchsia-zircon or false then [ (crates.fuchsia_zircon."0.3.3" deps) ] else [])) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.6.1".libc or false then [ (crates.libc."0.2.44" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
    ]
      ++ (if features.rand."0.6.1".winapi or false then [ (crates.winapi."0.3.6" deps) ] else [])) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."rand"."0.6.1"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."rand"."0.6.1" or {});
  };
  features_.rand."0.6.1" = deps: f: updateFeatures f (rec {
    cloudabi."${deps.rand."0.6.1".cloudabi}".default = true;
    fuchsia_zircon."${deps.rand."0.6.1".fuchsia_zircon}".default = true;
    libc."${deps.rand."0.6.1".libc}".default = (f.libc."${deps.rand."0.6.1".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.6.1".alloc =
        (f.rand."0.6.1".alloc or false) ||
        (f.rand."0.6.1".std or false) ||
        (rand."0.6.1"."std" or false); }
      { "0.6.1".cloudabi =
        (f.rand."0.6.1".cloudabi or false) ||
        (f.rand."0.6.1".std or false) ||
        (rand."0.6.1"."std" or false); }
      { "0.6.1".default = (f.rand."0.6.1".default or true); }
      { "0.6.1".fuchsia-zircon =
        (f.rand."0.6.1".fuchsia-zircon or false) ||
        (f.rand."0.6.1".std or false) ||
        (rand."0.6.1"."std" or false); }
      { "0.6.1".libc =
        (f.rand."0.6.1".libc or false) ||
        (f.rand."0.6.1".std or false) ||
        (rand."0.6.1"."std" or false); }
      { "0.6.1".packed_simd =
        (f.rand."0.6.1".packed_simd or false) ||
        (f.rand."0.6.1".simd_support or false) ||
        (rand."0.6.1"."simd_support" or false); }
      { "0.6.1".simd_support =
        (f.rand."0.6.1".simd_support or false) ||
        (f.rand."0.6.1".nightly or false) ||
        (rand."0.6.1"."nightly" or false); }
      { "0.6.1".std =
        (f.rand."0.6.1".std or false) ||
        (f.rand."0.6.1".default or false) ||
        (rand."0.6.1"."default" or false); }
      { "0.6.1".winapi =
        (f.rand."0.6.1".winapi or false) ||
        (f.rand."0.6.1".std or false) ||
        (rand."0.6.1"."std" or false); }
    ];
    rand_chacha."${deps.rand."0.6.1".rand_chacha}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.6.1".rand_core}".default = (f.rand_core."${deps.rand."0.6.1".rand_core}".default or false); }
      { "0.3.0".alloc =
        (f.rand_core."0.3.0".alloc or false) ||
        (rand."0.6.1"."alloc" or false) ||
        (f."rand"."0.6.1"."alloc" or false); }
      { "0.3.0".serde1 =
        (f.rand_core."0.3.0".serde1 or false) ||
        (rand."0.6.1"."serde1" or false) ||
        (f."rand"."0.6.1"."serde1" or false); }
      { "0.3.0".std =
        (f.rand_core."0.3.0".std or false) ||
        (rand."0.6.1"."std" or false) ||
        (f."rand"."0.6.1"."std" or false); }
    ];
    rand_hc."${deps.rand."0.6.1".rand_hc}".default = true;
    rand_isaac = fold recursiveUpdate {} [
      { "${deps.rand."0.6.1".rand_isaac}".default = true; }
      { "0.1.1".serde1 =
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand."0.6.1"."serde1" or false) ||
        (f."rand"."0.6.1"."serde1" or false); }
    ];
    rand_pcg."${deps.rand."0.6.1".rand_pcg}".default = true;
    rand_xorshift = fold recursiveUpdate {} [
      { "${deps.rand."0.6.1".rand_xorshift}".default = true; }
      { "0.1.0".serde1 =
        (f.rand_xorshift."0.1.0".serde1 or false) ||
        (rand."0.6.1"."serde1" or false) ||
        (f."rand"."0.6.1"."serde1" or false); }
    ];
    rustc_version."${deps.rand."0.6.1".rustc_version}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.6.1".winapi}"."minwindef" = true; }
      { "${deps.rand."0.6.1".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.6.1".winapi}"."profileapi" = true; }
      { "${deps.rand."0.6.1".winapi}"."winnt" = true; }
      { "${deps.rand."0.6.1".winapi}".default = true; }
    ];
  }) [
    (features_.rand_chacha."${deps."rand"."0.6.1"."rand_chacha"}" deps)
    (features_.rand_core."${deps."rand"."0.6.1"."rand_core"}" deps)
    (features_.rand_hc."${deps."rand"."0.6.1"."rand_hc"}" deps)
    (features_.rand_isaac."${deps."rand"."0.6.1"."rand_isaac"}" deps)
    (features_.rand_pcg."${deps."rand"."0.6.1"."rand_pcg"}" deps)
    (features_.rand_xorshift."${deps."rand"."0.6.1"."rand_xorshift"}" deps)
    (features_.rustc_version."${deps."rand"."0.6.1"."rustc_version"}" deps)
    (features_.cloudabi."${deps."rand"."0.6.1"."cloudabi"}" deps)
    (features_.fuchsia_zircon."${deps."rand"."0.6.1"."fuchsia_zircon"}" deps)
    (features_.libc."${deps."rand"."0.6.1"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.6.1"."winapi"}" deps)
  ];


  crates.rand_chacha."0.1.0" = deps: { features?(features_.rand_chacha."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.1.0";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0q5pq34cqv1mnibgzd1cmx9q49vkr2lvalkkvizmlld217jmlqc6";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_chacha"."0.1.0"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."rand_chacha"."0.1.0"."rustc_version"}" deps)
    ]);
  };
  features_.rand_chacha."0.1.0" = deps: f: updateFeatures f (rec {
    rand_chacha."0.1.0".default = (f.rand_chacha."0.1.0".default or true);
    rand_core."${deps.rand_chacha."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_chacha."0.1.0".rand_core}".default or false);
    rustc_version."${deps.rand_chacha."0.1.0".rustc_version}".default = true;
  }) [
    (features_.rand_core."${deps."rand_chacha"."0.1.0"."rand_core"}" deps)
    (features_.rustc_version."${deps."rand_chacha"."0.1.0"."rustc_version"}" deps)
  ];


  crates.rand_core."0.2.2" = deps: { features?(features_.rand_core."0.2.2" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.2.2";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1cxnaxmsirz2wxsajsjkd1wk6lqfqbcprqkha4bq3didznrl22sc";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_core"."0.2.2"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_core"."0.2.2" or {});
  };
  features_.rand_core."0.2.2" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_core."0.2.2".rand_core}".default = (f.rand_core."${deps.rand_core."0.2.2".rand_core}".default or false); }
      { "0.2.2".default = (f.rand_core."0.2.2".default or true); }
      { "0.3.0".alloc =
        (f.rand_core."0.3.0".alloc or false) ||
        (rand_core."0.2.2"."alloc" or false) ||
        (f."rand_core"."0.2.2"."alloc" or false); }
      { "0.3.0".serde1 =
        (f.rand_core."0.3.0".serde1 or false) ||
        (rand_core."0.2.2"."serde1" or false) ||
        (f."rand_core"."0.2.2"."serde1" or false); }
      { "0.3.0".std =
        (f.rand_core."0.3.0".std or false) ||
        (rand_core."0.2.2"."std" or false) ||
        (f."rand_core"."0.2.2"."std" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_core"."0.2.2"."rand_core"}" deps)
  ];


  crates.rand_core."0.3.0" = deps: { features?(features_.rand_core."0.3.0" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.3.0";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1vafw316apjys9va3j987s02djhqp7y21v671v3ix0p5j9bjq339";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rand_core"."0.3.0" or {});
  };
  features_.rand_core."0.3.0" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "0.3.0".alloc =
        (f.rand_core."0.3.0".alloc or false) ||
        (f.rand_core."0.3.0".std or false) ||
        (rand_core."0.3.0"."std" or false); }
      { "0.3.0".default = (f.rand_core."0.3.0".default or true); }
      { "0.3.0".serde =
        (f.rand_core."0.3.0".serde or false) ||
        (f.rand_core."0.3.0".serde1 or false) ||
        (rand_core."0.3.0"."serde1" or false); }
      { "0.3.0".serde_derive =
        (f.rand_core."0.3.0".serde_derive or false) ||
        (f.rand_core."0.3.0".serde1 or false) ||
        (rand_core."0.3.0"."serde1" or false); }
      { "0.3.0".std =
        (f.rand_core."0.3.0".std or false) ||
        (f.rand_core."0.3.0".default or false) ||
        (rand_core."0.3.0"."default" or false); }
    ];
  }) [];


  crates.rand_hc."0.1.0" = deps: { features?(features_.rand_hc."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.1.0";
    authors = [ "The Rand Project Developers" ];
    sha256 = "05agb75j87yp7y1zk8yf7bpm66hc0673r3dlypn0kazynr6fdgkz";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
    ]);
  };
  features_.rand_hc."0.1.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_hc."0.1.0".rand_core}".default or false);
    rand_hc."0.1.0".default = (f.rand_hc."0.1.0".default or true);
  }) [
    (features_.rand_core."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
  ];


  crates.rand_isaac."0.1.1" = deps: { features?(features_.rand_isaac."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_isaac";
    version = "0.1.1";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "10hhdh5b5sa03s6b63y9bafm956jwilx41s71jbrzl63ccx8lxdq";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_isaac"."0.1.1" or {});
  };
  features_.rand_isaac."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_isaac."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}".default or false); }
      { "0.3.0".serde1 =
        (f.rand_core."0.3.0".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false) ||
        (f."rand_isaac"."0.1.1"."serde1" or false); }
    ];
    rand_isaac = fold recursiveUpdate {} [
      { "0.1.1".default = (f.rand_isaac."0.1.1".default or true); }
      { "0.1.1".serde =
        (f.rand_isaac."0.1.1".serde or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1".serde_derive =
        (f.rand_isaac."0.1.1".serde_derive or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
  ];


  crates.rand_pcg."0.1.1" = deps: { features?(features_.rand_pcg."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_pcg";
    version = "0.1.1";
    authors = [ "The Rand Project Developers" ];
    sha256 = "0x6pzldj0c8c7gmr67ni5i7w2f7n7idvs3ckx0fc3wkhwl7wrbza";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_pcg"."0.1.1"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."rand_pcg"."0.1.1"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."rand_pcg"."0.1.1" or {});
  };
  features_.rand_pcg."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_pcg."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_pcg."0.1.1".rand_core}".default or false);
    rand_pcg = fold recursiveUpdate {} [
      { "0.1.1".default = (f.rand_pcg."0.1.1".default or true); }
      { "0.1.1".serde =
        (f.rand_pcg."0.1.1".serde or false) ||
        (f.rand_pcg."0.1.1".serde1 or false) ||
        (rand_pcg."0.1.1"."serde1" or false); }
      { "0.1.1".serde_derive =
        (f.rand_pcg."0.1.1".serde_derive or false) ||
        (f.rand_pcg."0.1.1".serde1 or false) ||
        (rand_pcg."0.1.1"."serde1" or false); }
    ];
    rustc_version."${deps.rand_pcg."0.1.1".rustc_version}".default = true;
  }) [
    (features_.rand_core."${deps."rand_pcg"."0.1.1"."rand_core"}" deps)
    (features_.rustc_version."${deps."rand_pcg"."0.1.1"."rustc_version"}" deps)
  ];


  crates.rand_xorshift."0.1.0" = deps: { features?(features_.rand_xorshift."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_xorshift";
    version = "0.1.0";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "063vxb678ki8gq4rx9w7yg5f9i29ig1zwykl67mfsxn0kxlkv2ih";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_xorshift"."0.1.0"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_xorshift"."0.1.0" or {});
  };
  features_.rand_xorshift."0.1.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_xorshift."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_xorshift."0.1.0".rand_core}".default or false);
    rand_xorshift = fold recursiveUpdate {} [
      { "0.1.0".default = (f.rand_xorshift."0.1.0".default or true); }
      { "0.1.0".serde =
        (f.rand_xorshift."0.1.0".serde or false) ||
        (f.rand_xorshift."0.1.0".serde1 or false) ||
        (rand_xorshift."0.1.0"."serde1" or false); }
      { "0.1.0".serde_derive =
        (f.rand_xorshift."0.1.0".serde_derive or false) ||
        (f.rand_xorshift."0.1.0".serde1 or false) ||
        (rand_xorshift."0.1.0"."serde1" or false); }
    ];
  }) [
    (features_.rand_core."${deps."rand_xorshift"."0.1.0"."rand_core"}" deps)
  ];


  crates.redox_syscall."0.1.43" = deps: { features?(features_.redox_syscall."0.1.43" deps {}) }: buildRustCrate {
    crateName = "redox_syscall";
    version = "0.1.43";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "1s0xzd4f23mfl1bc52rg7jiggv2mh9hkv3b1glfg8x5n9lbqg6ba";
    libName = "syscall";
  };
  features_.redox_syscall."0.1.43" = deps: f: updateFeatures f (rec {
    redox_syscall."0.1.43".default = (f.redox_syscall."0.1.43".default or true);
  }) [];


  crates.redox_termios."0.1.1" = deps: { features?(features_.redox_termios."0.1.1" deps {}) }: buildRustCrate {
    crateName = "redox_termios";
    version = "0.1.1";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "04s6yyzjca552hdaqlvqhp3vw0zqbc304md5czyd3axh56iry8wh";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."redox_syscall"."${deps."redox_termios"."0.1.1"."redox_syscall"}" deps)
    ]);
  };
  features_.redox_termios."0.1.1" = deps: f: updateFeatures f (rec {
    redox_syscall."${deps.redox_termios."0.1.1".redox_syscall}".default = true;
    redox_termios."0.1.1".default = (f.redox_termios."0.1.1".default or true);
  }) [
    (features_.redox_syscall."${deps."redox_termios"."0.1.1"."redox_syscall"}" deps)
  ];


  crates.redox_users."0.2.0" = deps: { features?(features_.redox_users."0.2.0" deps {}) }: buildRustCrate {
    crateName = "redox_users";
    version = "0.2.0";
    authors = [ "Jose Narvaez <goyox86@gmail.com>" "Wesley Hershberger <mggmugginsmc@gmail.com>" ];
    sha256 = "0s9jrh378jk8rfi1xfwxvh2r1gv6rn3bq6n7sbajkrqqq0xzijvf";
    dependencies = mapFeatures features ([
      (crates."argon2rs"."${deps."redox_users"."0.2.0"."argon2rs"}" deps)
      (crates."failure"."${deps."redox_users"."0.2.0"."failure"}" deps)
      (crates."rand"."${deps."redox_users"."0.2.0"."rand"}" deps)
      (crates."redox_syscall"."${deps."redox_users"."0.2.0"."redox_syscall"}" deps)
    ]);
  };
  features_.redox_users."0.2.0" = deps: f: updateFeatures f (rec {
    argon2rs."${deps.redox_users."0.2.0".argon2rs}".default = (f.argon2rs."${deps.redox_users."0.2.0".argon2rs}".default or false);
    failure."${deps.redox_users."0.2.0".failure}".default = true;
    rand."${deps.redox_users."0.2.0".rand}".default = true;
    redox_syscall."${deps.redox_users."0.2.0".redox_syscall}".default = true;
    redox_users."0.2.0".default = (f.redox_users."0.2.0".default or true);
  }) [
    (features_.argon2rs."${deps."redox_users"."0.2.0"."argon2rs"}" deps)
    (features_.failure."${deps."redox_users"."0.2.0"."failure"}" deps)
    (features_.rand."${deps."redox_users"."0.2.0"."rand"}" deps)
    (features_.redox_syscall."${deps."redox_users"."0.2.0"."redox_syscall"}" deps)
  ];


  crates.regex."0.2.11" = deps: { features?(features_.regex."0.2.11" deps {}) }: buildRustCrate {
    crateName = "regex";
    version = "0.2.11";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0r50cymxdqp0fv1dxd22mjr6y32q450nwacd279p9s7lh0cafijj";
    dependencies = mapFeatures features ([
      (crates."aho_corasick"."${deps."regex"."0.2.11"."aho_corasick"}" deps)
      (crates."memchr"."${deps."regex"."0.2.11"."memchr"}" deps)
      (crates."regex_syntax"."${deps."regex"."0.2.11"."regex_syntax"}" deps)
      (crates."thread_local"."${deps."regex"."0.2.11"."thread_local"}" deps)
      (crates."utf8_ranges"."${deps."regex"."0.2.11"."utf8_ranges"}" deps)
    ]);
    features = mkFeatures (features."regex"."0.2.11" or {});
  };
  features_.regex."0.2.11" = deps: f: updateFeatures f (rec {
    aho_corasick."${deps.regex."0.2.11".aho_corasick}".default = true;
    memchr."${deps.regex."0.2.11".memchr}".default = true;
    regex = fold recursiveUpdate {} [
      { "0.2.11".default = (f.regex."0.2.11".default or true); }
      { "0.2.11".pattern =
        (f.regex."0.2.11".pattern or false) ||
        (f.regex."0.2.11".unstable or false) ||
        (regex."0.2.11"."unstable" or false); }
    ];
    regex_syntax."${deps.regex."0.2.11".regex_syntax}".default = true;
    thread_local."${deps.regex."0.2.11".thread_local}".default = true;
    utf8_ranges."${deps.regex."0.2.11".utf8_ranges}".default = true;
  }) [
    (features_.aho_corasick."${deps."regex"."0.2.11"."aho_corasick"}" deps)
    (features_.memchr."${deps."regex"."0.2.11"."memchr"}" deps)
    (features_.regex_syntax."${deps."regex"."0.2.11"."regex_syntax"}" deps)
    (features_.thread_local."${deps."regex"."0.2.11"."thread_local"}" deps)
    (features_.utf8_ranges."${deps."regex"."0.2.11"."utf8_ranges"}" deps)
  ];


  crates.regex."1.1.0" = deps: { features?(features_.regex."1.1.0" deps {}) }: buildRustCrate {
    crateName = "regex";
    version = "1.1.0";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1myzfgs1yp6vs2rxyg6arn6ab05j6c2m922w3b4iv6zix1rl7z0n";
    dependencies = mapFeatures features ([
      (crates."aho_corasick"."${deps."regex"."1.1.0"."aho_corasick"}" deps)
      (crates."memchr"."${deps."regex"."1.1.0"."memchr"}" deps)
      (crates."regex_syntax"."${deps."regex"."1.1.0"."regex_syntax"}" deps)
      (crates."thread_local"."${deps."regex"."1.1.0"."thread_local"}" deps)
      (crates."utf8_ranges"."${deps."regex"."1.1.0"."utf8_ranges"}" deps)
    ]);
    features = mkFeatures (features."regex"."1.1.0" or {});
  };
  features_.regex."1.1.0" = deps: f: updateFeatures f (rec {
    aho_corasick."${deps.regex."1.1.0".aho_corasick}".default = true;
    memchr."${deps.regex."1.1.0".memchr}".default = true;
    regex = fold recursiveUpdate {} [
      { "1.1.0".default = (f.regex."1.1.0".default or true); }
      { "1.1.0".pattern =
        (f.regex."1.1.0".pattern or false) ||
        (f.regex."1.1.0".unstable or false) ||
        (regex."1.1.0"."unstable" or false); }
      { "1.1.0".use_std =
        (f.regex."1.1.0".use_std or false) ||
        (f.regex."1.1.0".default or false) ||
        (regex."1.1.0"."default" or false); }
    ];
    regex_syntax."${deps.regex."1.1.0".regex_syntax}".default = true;
    thread_local."${deps.regex."1.1.0".thread_local}".default = true;
    utf8_ranges."${deps.regex."1.1.0".utf8_ranges}".default = true;
  }) [
    (features_.aho_corasick."${deps."regex"."1.1.0"."aho_corasick"}" deps)
    (features_.memchr."${deps."regex"."1.1.0"."memchr"}" deps)
    (features_.regex_syntax."${deps."regex"."1.1.0"."regex_syntax"}" deps)
    (features_.thread_local."${deps."regex"."1.1.0"."thread_local"}" deps)
    (features_.utf8_ranges."${deps."regex"."1.1.0"."utf8_ranges"}" deps)
  ];


  crates.regex_syntax."0.5.6" = deps: { features?(features_.regex_syntax."0.5.6" deps {}) }: buildRustCrate {
    crateName = "regex-syntax";
    version = "0.5.6";
    authors = [ "The Rust Project Developers" ];
    sha256 = "10vf3r34bgjnbrnqd5aszn35bjvm8insw498l1vjy8zx5yms3427";
    dependencies = mapFeatures features ([
      (crates."ucd_util"."${deps."regex_syntax"."0.5.6"."ucd_util"}" deps)
    ]);
  };
  features_.regex_syntax."0.5.6" = deps: f: updateFeatures f (rec {
    regex_syntax."0.5.6".default = (f.regex_syntax."0.5.6".default or true);
    ucd_util."${deps.regex_syntax."0.5.6".ucd_util}".default = true;
  }) [
    (features_.ucd_util."${deps."regex_syntax"."0.5.6"."ucd_util"}" deps)
  ];


  crates.regex_syntax."0.6.4" = deps: { features?(features_.regex_syntax."0.6.4" deps {}) }: buildRustCrate {
    crateName = "regex-syntax";
    version = "0.6.4";
    authors = [ "The Rust Project Developers" ];
    sha256 = "073qklf4dfq00jxj919y4abnnh8vwn42x1bms82634sfb9s47pfc";
    dependencies = mapFeatures features ([
      (crates."ucd_util"."${deps."regex_syntax"."0.6.4"."ucd_util"}" deps)
    ]);
  };
  features_.regex_syntax."0.6.4" = deps: f: updateFeatures f (rec {
    regex_syntax."0.6.4".default = (f.regex_syntax."0.6.4".default or true);
    ucd_util."${deps.regex_syntax."0.6.4".ucd_util}".default = true;
  }) [
    (features_.ucd_util."${deps."regex_syntax"."0.6.4"."ucd_util"}" deps)
  ];


  crates.relay."0.1.1" = deps: { features?(features_.relay."0.1.1" deps {}) }: buildRustCrate {
    crateName = "relay";
    version = "0.1.1";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "16csfaslbmj25iaxs88p8wcfh2zfpkh9isg9adid0nxjxvknh07r";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."relay"."0.1.1"."futures"}" deps)
    ]);
  };
  features_.relay."0.1.1" = deps: f: updateFeatures f (rec {
    futures."${deps.relay."0.1.1".futures}".default = true;
    relay."0.1.1".default = (f.relay."0.1.1".default or true);
  }) [
    (features_.futures."${deps."relay"."0.1.1"."futures"}" deps)
  ];


  crates.rustc_demangle."0.1.9" = deps: { features?(features_.rustc_demangle."0.1.9" deps {}) }: buildRustCrate {
    crateName = "rustc-demangle";
    version = "0.1.9";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "00ma4r9haq0zv5krps617mym6y74056pfcivyld0kpci156vfaax";
  };
  features_.rustc_demangle."0.1.9" = deps: f: updateFeatures f (rec {
    rustc_demangle."0.1.9".default = (f.rustc_demangle."0.1.9".default or true);
  }) [];


  crates.rustc_version."0.2.3" = deps: { features?(features_.rustc_version."0.2.3" deps {}) }: buildRustCrate {
    crateName = "rustc_version";
    version = "0.2.3";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "0rgwzbgs3i9fqjm1p4ra3n7frafmpwl29c8lw85kv1rxn7n2zaa7";
    dependencies = mapFeatures features ([
      (crates."semver"."${deps."rustc_version"."0.2.3"."semver"}" deps)
    ]);
  };
  features_.rustc_version."0.2.3" = deps: f: updateFeatures f (rec {
    rustc_version."0.2.3".default = (f.rustc_version."0.2.3".default or true);
    semver."${deps.rustc_version."0.2.3".semver}".default = true;
  }) [
    (features_.semver."${deps."rustc_version"."0.2.3"."semver"}" deps)
  ];


  crates.ryu."0.2.7" = deps: { features?(features_.ryu."0.2.7" deps {}) }: buildRustCrate {
    crateName = "ryu";
    version = "0.2.7";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0m8szf1m87wfqkwh1f9zp9bn2mb0m9nav028xxnd0hlig90b44bd";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."ryu"."0.2.7" or {});
  };
  features_.ryu."0.2.7" = deps: f: updateFeatures f (rec {
    ryu."0.2.7".default = (f.ryu."0.2.7".default or true);
  }) [];


  crates.safemem."0.3.0" = deps: { features?(features_.safemem."0.3.0" deps {}) }: buildRustCrate {
    crateName = "safemem";
    version = "0.3.0";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "0pr39b468d05f6m7m4alsngmj5p7an8df21apsxbi57k0lmwrr18";
    features = mkFeatures (features."safemem"."0.3.0" or {});
  };
  features_.safemem."0.3.0" = deps: f: updateFeatures f (rec {
    safemem = fold recursiveUpdate {} [
      { "0.3.0".default = (f.safemem."0.3.0".default or true); }
      { "0.3.0".std =
        (f.safemem."0.3.0".std or false) ||
        (f.safemem."0.3.0".default or false) ||
        (safemem."0.3.0"."default" or false); }
    ];
  }) [];


  crates.scoped_tls."0.1.2" = deps: { features?(features_.scoped_tls."0.1.2" deps {}) }: buildRustCrate {
    crateName = "scoped-tls";
    version = "0.1.2";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0nblksgki698cqsclsnd6f1pq4yy34350dn2slaah9dlmx9z5xla";
    features = mkFeatures (features."scoped_tls"."0.1.2" or {});
  };
  features_.scoped_tls."0.1.2" = deps: f: updateFeatures f (rec {
    scoped_tls."0.1.2".default = (f.scoped_tls."0.1.2".default or true);
  }) [];


  crates.scoped_threadpool."0.1.9" = deps: { features?(features_.scoped_threadpool."0.1.9" deps {}) }: buildRustCrate {
    crateName = "scoped_threadpool";
    version = "0.1.9";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1arqj2skcfr46s1lcyvnlmfr5456kg5nhn8k90xyfjnxkp5yga2v";
    features = mkFeatures (features."scoped_threadpool"."0.1.9" or {});
  };
  features_.scoped_threadpool."0.1.9" = deps: f: updateFeatures f (rec {
    scoped_threadpool."0.1.9".default = (f.scoped_threadpool."0.1.9".default or true);
  }) [];


  crates.scopeguard."0.3.3" = deps: { features?(features_.scopeguard."0.3.3" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "0.3.3";
    authors = [ "bluss" ];
    sha256 = "0i1l013csrqzfz6c68pr5pi01hg5v5yahq8fsdmaxy6p8ygsjf3r";
    features = mkFeatures (features."scopeguard"."0.3.3" or {});
  };
  features_.scopeguard."0.3.3" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "0.3.3".default = (f.scopeguard."0.3.3".default or true); }
      { "0.3.3".use_std =
        (f.scopeguard."0.3.3".use_std or false) ||
        (f.scopeguard."0.3.3".default or false) ||
        (scopeguard."0.3.3"."default" or false); }
    ];
  }) [];


  crates.semver."0.9.0" = deps: { features?(features_.semver."0.9.0" deps {}) }: buildRustCrate {
    crateName = "semver";
    version = "0.9.0";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" "The Rust Project Developers" ];
    sha256 = "0azak2lb2wc36s3x15az886kck7rpnksrw14lalm157rg9sc9z63";
    dependencies = mapFeatures features ([
      (crates."semver_parser"."${deps."semver"."0.9.0"."semver_parser"}" deps)
    ]);
    features = mkFeatures (features."semver"."0.9.0" or {});
  };
  features_.semver."0.9.0" = deps: f: updateFeatures f (rec {
    semver = fold recursiveUpdate {} [
      { "0.9.0".default = (f.semver."0.9.0".default or true); }
      { "0.9.0".serde =
        (f.semver."0.9.0".serde or false) ||
        (f.semver."0.9.0".ci or false) ||
        (semver."0.9.0"."ci" or false); }
    ];
    semver_parser."${deps.semver."0.9.0".semver_parser}".default = true;
  }) [
    (features_.semver_parser."${deps."semver"."0.9.0"."semver_parser"}" deps)
  ];


  crates.semver_parser."0.7.0" = deps: { features?(features_.semver_parser."0.7.0" deps {}) }: buildRustCrate {
    crateName = "semver-parser";
    version = "0.7.0";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" ];
    sha256 = "1da66c8413yakx0y15k8c055yna5lyb6fr0fw9318kdwkrk5k12h";
  };
  features_.semver_parser."0.7.0" = deps: f: updateFeatures f (rec {
    semver_parser."0.7.0".default = (f.semver_parser."0.7.0".default or true);
  }) [];


  crates.serde."1.0.80" = deps: { features?(features_.serde."1.0.80" deps {}) }: buildRustCrate {
    crateName = "serde";
    version = "1.0.80";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0vyciw2qhrws4hz87pfnsjdfzzdw2sclxqxq394g3a219a2rdcxz";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."serde"."1.0.80" or {});
  };
  features_.serde."1.0.80" = deps: f: updateFeatures f (rec {
    serde = fold recursiveUpdate {} [
      { "1.0.80".default = (f.serde."1.0.80".default or true); }
      { "1.0.80".serde_derive =
        (f.serde."1.0.80".serde_derive or false) ||
        (f.serde."1.0.80".derive or false) ||
        (serde."1.0.80"."derive" or false); }
      { "1.0.80".std =
        (f.serde."1.0.80".std or false) ||
        (f.serde."1.0.80".default or false) ||
        (serde."1.0.80"."default" or false); }
      { "1.0.80".unstable =
        (f.serde."1.0.80".unstable or false) ||
        (f.serde."1.0.80".alloc or false) ||
        (serde."1.0.80"."alloc" or false); }
    ];
  }) [];


  crates.serde_derive."1.0.80" = deps: { features?(features_.serde_derive."1.0.80" deps {}) }: buildRustCrate {
    crateName = "serde_derive";
    version = "1.0.80";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1akvzhbnnqhd92lfj7vp43scs1vdml7x27c82l5yh0kz7xf7jaky";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."serde_derive"."1.0.80"."proc_macro2"}" deps)
      (crates."quote"."${deps."serde_derive"."1.0.80"."quote"}" deps)
      (crates."syn"."${deps."serde_derive"."1.0.80"."syn"}" deps)
    ]);
    features = mkFeatures (features."serde_derive"."1.0.80" or {});
  };
  features_.serde_derive."1.0.80" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.serde_derive."1.0.80".proc_macro2}".default = true;
    quote."${deps.serde_derive."1.0.80".quote}".default = true;
    serde_derive."1.0.80".default = (f.serde_derive."1.0.80".default or true);
    syn = fold recursiveUpdate {} [
      { "${deps.serde_derive."1.0.80".syn}"."visit" = true; }
      { "${deps.serde_derive."1.0.80".syn}".default = true; }
    ];
  }) [
    (features_.proc_macro2."${deps."serde_derive"."1.0.80"."proc_macro2"}" deps)
    (features_.quote."${deps."serde_derive"."1.0.80"."quote"}" deps)
    (features_.syn."${deps."serde_derive"."1.0.80"."syn"}" deps)
  ];


  crates.serde_json."1.0.33" = deps: { features?(features_.serde_json."1.0.33" deps {}) }: buildRustCrate {
    crateName = "serde_json";
    version = "1.0.33";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1cahjwpa723cphwpwk9dzhpx4mvfafvfml428n11cj4q69vjs7y5";
    dependencies = mapFeatures features ([
      (crates."itoa"."${deps."serde_json"."1.0.33"."itoa"}" deps)
      (crates."ryu"."${deps."serde_json"."1.0.33"."ryu"}" deps)
      (crates."serde"."${deps."serde_json"."1.0.33"."serde"}" deps)
    ]);
    features = mkFeatures (features."serde_json"."1.0.33" or {});
  };
  features_.serde_json."1.0.33" = deps: f: updateFeatures f (rec {
    itoa."${deps.serde_json."1.0.33".itoa}".default = true;
    ryu."${deps.serde_json."1.0.33".ryu}".default = true;
    serde."${deps.serde_json."1.0.33".serde}".default = true;
    serde_json = fold recursiveUpdate {} [
      { "1.0.33".default = (f.serde_json."1.0.33".default or true); }
      { "1.0.33".indexmap =
        (f.serde_json."1.0.33".indexmap or false) ||
        (f.serde_json."1.0.33".preserve_order or false) ||
        (serde_json."1.0.33"."preserve_order" or false); }
    ];
  }) [
    (features_.itoa."${deps."serde_json"."1.0.33"."itoa"}" deps)
    (features_.ryu."${deps."serde_json"."1.0.33"."ryu"}" deps)
    (features_.serde."${deps."serde_json"."1.0.33"."serde"}" deps)
  ];


  crates.serde_yaml."0.7.5" = deps: { features?(features_.serde_yaml."0.7.5" deps {}) }: buildRustCrate {
    crateName = "serde_yaml";
    version = "0.7.5";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1ai03b8gii88kziljn4ja3ayd6mc3zy0y8aq2wncxwkh0gd707gd";
    dependencies = mapFeatures features ([
      (crates."dtoa"."${deps."serde_yaml"."0.7.5"."dtoa"}" deps)
      (crates."linked_hash_map"."${deps."serde_yaml"."0.7.5"."linked_hash_map"}" deps)
      (crates."serde"."${deps."serde_yaml"."0.7.5"."serde"}" deps)
      (crates."yaml_rust"."${deps."serde_yaml"."0.7.5"."yaml_rust"}" deps)
    ]);
  };
  features_.serde_yaml."0.7.5" = deps: f: updateFeatures f (rec {
    dtoa."${deps.serde_yaml."0.7.5".dtoa}".default = true;
    linked_hash_map."${deps.serde_yaml."0.7.5".linked_hash_map}".default = true;
    serde."${deps.serde_yaml."0.7.5".serde}".default = true;
    serde_yaml."0.7.5".default = (f.serde_yaml."0.7.5".default or true);
    yaml_rust."${deps.serde_yaml."0.7.5".yaml_rust}".default = true;
  }) [
    (features_.dtoa."${deps."serde_yaml"."0.7.5"."dtoa"}" deps)
    (features_.linked_hash_map."${deps."serde_yaml"."0.7.5"."linked_hash_map"}" deps)
    (features_.serde."${deps."serde_yaml"."0.7.5"."serde"}" deps)
    (features_.yaml_rust."${deps."serde_yaml"."0.7.5"."yaml_rust"}" deps)
  ];


  crates.serde_yaml."0.8.8" = deps: { features?(features_.serde_yaml."0.8.8" deps {}) }: buildRustCrate {
    crateName = "serde_yaml";
    version = "0.8.8";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0gpydv1vvfnnzb842wp881rmzjc4lgz3saxvci8v8kiawnb78394";
    dependencies = mapFeatures features ([
      (crates."dtoa"."${deps."serde_yaml"."0.8.8"."dtoa"}" deps)
      (crates."linked_hash_map"."${deps."serde_yaml"."0.8.8"."linked_hash_map"}" deps)
      (crates."serde"."${deps."serde_yaml"."0.8.8"."serde"}" deps)
      (crates."yaml_rust"."${deps."serde_yaml"."0.8.8"."yaml_rust"}" deps)
    ]);
  };
  features_.serde_yaml."0.8.8" = deps: f: updateFeatures f (rec {
    dtoa."${deps.serde_yaml."0.8.8".dtoa}".default = true;
    linked_hash_map."${deps.serde_yaml."0.8.8".linked_hash_map}".default = true;
    serde."${deps.serde_yaml."0.8.8".serde}".default = true;
    serde_yaml."0.8.8".default = (f.serde_yaml."0.8.8".default or true);
    yaml_rust."${deps.serde_yaml."0.8.8".yaml_rust}".default = true;
  }) [
    (features_.dtoa."${deps."serde_yaml"."0.8.8"."dtoa"}" deps)
    (features_.linked_hash_map."${deps."serde_yaml"."0.8.8"."linked_hash_map"}" deps)
    (features_.serde."${deps."serde_yaml"."0.8.8"."serde"}" deps)
    (features_.yaml_rust."${deps."serde_yaml"."0.8.8"."yaml_rust"}" deps)
  ];


  crates.slab."0.3.0" = deps: { features?(features_.slab."0.3.0" deps {}) }: buildRustCrate {
    crateName = "slab";
    version = "0.3.0";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0y6lhjggksh57hyfd3l6p9wgv5nhvw9c6djrysq7jnalz8fih21k";
  };
  features_.slab."0.3.0" = deps: f: updateFeatures f (rec {
    slab."0.3.0".default = (f.slab."0.3.0".default or true);
  }) [];


  crates.slab."0.4.1" = deps: { features?(features_.slab."0.4.1" deps {}) }: buildRustCrate {
    crateName = "slab";
    version = "0.4.1";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0njmznhcjp4aiznybxm7wacnb4q49ch98wizyf4lpn3rg6sjrak4";
  };
  features_.slab."0.4.1" = deps: f: updateFeatures f (rec {
    slab."0.4.1".default = (f.slab."0.4.1".default or true);
  }) [];


  crates.smallvec."0.2.1" = deps: { features?(features_.smallvec."0.2.1" deps {}) }: buildRustCrate {
    crateName = "smallvec";
    version = "0.2.1";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "0rnsll9af52bpjngz0067dpm1ndqmh76i64a58fc118l4lvnjxw2";
    libPath = "lib.rs";
  };
  features_.smallvec."0.2.1" = deps: f: updateFeatures f (rec {
    smallvec."0.2.1".default = (f.smallvec."0.2.1".default or true);
  }) [];


  crates.smallvec."0.6.7" = deps: { features?(features_.smallvec."0.6.7" deps {}) }: buildRustCrate {
    crateName = "smallvec";
    version = "0.6.7";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "08ql2yi7ry08cqjl9n6vpb6x6zgqzwllzzk9pxj1143xwg503qcx";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
      (crates."unreachable"."${deps."smallvec"."0.6.7"."unreachable"}" deps)
    ]);
    features = mkFeatures (features."smallvec"."0.6.7" or {});
  };
  features_.smallvec."0.6.7" = deps: f: updateFeatures f (rec {
    smallvec = fold recursiveUpdate {} [
      { "0.6.7".default = (f.smallvec."0.6.7".default or true); }
      { "0.6.7".std =
        (f.smallvec."0.6.7".std or false) ||
        (f.smallvec."0.6.7".default or false) ||
        (smallvec."0.6.7"."default" or false); }
    ];
    unreachable."${deps.smallvec."0.6.7".unreachable}".default = true;
  }) [
    (features_.unreachable."${deps."smallvec"."0.6.7"."unreachable"}" deps)
  ];


  crates.stable_deref_trait."1.1.1" = deps: { features?(features_.stable_deref_trait."1.1.1" deps {}) }: buildRustCrate {
    crateName = "stable_deref_trait";
    version = "1.1.1";
    authors = [ "Robert Grosse <n210241048576@gmail.com>" ];
    sha256 = "1xy9slzslrzr31nlnw52sl1d820b09y61b7f13lqgsn8n7y0l4g8";
    features = mkFeatures (features."stable_deref_trait"."1.1.1" or {});
  };
  features_.stable_deref_trait."1.1.1" = deps: f: updateFeatures f (rec {
    stable_deref_trait = fold recursiveUpdate {} [
      { "1.1.1".default = (f.stable_deref_trait."1.1.1".default or true); }
      { "1.1.1".std =
        (f.stable_deref_trait."1.1.1".std or false) ||
        (f.stable_deref_trait."1.1.1".default or false) ||
        (stable_deref_trait."1.1.1"."default" or false); }
    ];
  }) [];


  crates.strsim."0.7.0" = deps: { features?(features_.strsim."0.7.0" deps {}) }: buildRustCrate {
    crateName = "strsim";
    version = "0.7.0";
    authors = [ "Danny Guo <dannyguo91@gmail.com>" ];
    sha256 = "0fy0k5f2705z73mb3x9459bpcvrx4ky8jpr4zikcbiwan4bnm0iv";
  };
  features_.strsim."0.7.0" = deps: f: updateFeatures f (rec {
    strsim."0.7.0".default = (f.strsim."0.7.0".default or true);
  }) [];


  crates.syn."0.15.22" = deps: { features?(features_.syn."0.15.22" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "0.15.22";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0lvcz99hgqxzp4m7slhh0rxy5iawpjz5fqgjk3w2lsvs2pawlh7i";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."0.15.22"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."0.15.22"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."0.15.22".quote or false then [ (crates.quote."0.6.10" deps) ] else []));
    features = mkFeatures (features."syn"."0.15.22" or {});
  };
  features_.syn."0.15.22" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."0.15.22".proc_macro2}".default = (f.proc_macro2."${deps.syn."0.15.22".proc_macro2}".default or false); }
      { "0.4.24".proc-macro =
        (f.proc_macro2."0.4.24".proc-macro or false) ||
        (syn."0.15.22"."proc-macro" or false) ||
        (f."syn"."0.15.22"."proc-macro" or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."0.15.22".quote}".default = (f.quote."${deps.syn."0.15.22".quote}".default or false); }
      { "0.6.10".proc-macro =
        (f.quote."0.6.10".proc-macro or false) ||
        (syn."0.15.22"."proc-macro" or false) ||
        (f."syn"."0.15.22"."proc-macro" or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "0.15.22".clone-impls =
        (f.syn."0.15.22".clone-impls or false) ||
        (f.syn."0.15.22".default or false) ||
        (syn."0.15.22"."default" or false); }
      { "0.15.22".default = (f.syn."0.15.22".default or true); }
      { "0.15.22".derive =
        (f.syn."0.15.22".derive or false) ||
        (f.syn."0.15.22".default or false) ||
        (syn."0.15.22"."default" or false); }
      { "0.15.22".parsing =
        (f.syn."0.15.22".parsing or false) ||
        (f.syn."0.15.22".default or false) ||
        (syn."0.15.22"."default" or false); }
      { "0.15.22".printing =
        (f.syn."0.15.22".printing or false) ||
        (f.syn."0.15.22".default or false) ||
        (syn."0.15.22"."default" or false); }
      { "0.15.22".proc-macro =
        (f.syn."0.15.22".proc-macro or false) ||
        (f.syn."0.15.22".default or false) ||
        (syn."0.15.22"."default" or false); }
      { "0.15.22".quote =
        (f.syn."0.15.22".quote or false) ||
        (f.syn."0.15.22".printing or false) ||
        (syn."0.15.22"."printing" or false); }
    ];
    unicode_xid."${deps.syn."0.15.22".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."0.15.22"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."0.15.22"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."0.15.22"."unicode_xid"}" deps)
  ];


  crates.synstructure."0.10.1" = deps: { features?(features_.synstructure."0.10.1" deps {}) }: buildRustCrate {
    crateName = "synstructure";
    version = "0.10.1";
    authors = [ "Nika Layzell <nika@thelayzells.com>" ];
    sha256 = "0mx2vwd0d0f7hanz15nkp0ikkfjsx9rfkph7pynxyfbj45ank4g3";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."synstructure"."0.10.1"."proc_macro2"}" deps)
      (crates."quote"."${deps."synstructure"."0.10.1"."quote"}" deps)
      (crates."syn"."${deps."synstructure"."0.10.1"."syn"}" deps)
      (crates."unicode_xid"."${deps."synstructure"."0.10.1"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."synstructure"."0.10.1" or {});
  };
  features_.synstructure."0.10.1" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.synstructure."0.10.1".proc_macro2}".default = true;
    quote."${deps.synstructure."0.10.1".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.synstructure."0.10.1".syn}"."extra-traits" = true; }
      { "${deps.synstructure."0.10.1".syn}"."visit" = true; }
      { "${deps.synstructure."0.10.1".syn}".default = true; }
    ];
    synstructure."0.10.1".default = (f.synstructure."0.10.1".default or true);
    unicode_xid."${deps.synstructure."0.10.1".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."synstructure"."0.10.1"."proc_macro2"}" deps)
    (features_.quote."${deps."synstructure"."0.10.1"."quote"}" deps)
    (features_.syn."${deps."synstructure"."0.10.1"."syn"}" deps)
    (features_.unicode_xid."${deps."synstructure"."0.10.1"."unicode_xid"}" deps)
  ];


  crates.take."0.1.0" = deps: { features?(features_.take."0.1.0" deps {}) }: buildRustCrate {
    crateName = "take";
    version = "0.1.0";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "17rfh39di5n8w9aghpic2r94cndi3dr04l60nkjylmxfxr3iwlhd";
  };
  features_.take."0.1.0" = deps: f: updateFeatures f (rec {
    take."0.1.0".default = (f.take."0.1.0".default or true);
  }) [];


  crates.tempfile."2.2.0" = deps: { features?(features_.tempfile."2.2.0" deps {}) }: buildRustCrate {
    crateName = "tempfile";
    version = "2.2.0";
    authors = [ "Steven Allen <steven@stebalien.com>" ];
    sha256 = "1z3l901ipvi0s0mdppw4lwfa77ydb22rfnf6y9sh0pifj7ah5drf";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."tempfile"."2.2.0"."rand"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."tempfile"."2.2.0"."redox_syscall"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."tempfile"."2.2.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."tempfile"."2.2.0"."kernel32_sys"}" deps)
      (crates."winapi"."${deps."tempfile"."2.2.0"."winapi"}" deps)
    ]) else []);
  };
  features_.tempfile."2.2.0" = deps: f: updateFeatures f (rec {
    kernel32_sys."${deps.tempfile."2.2.0".kernel32_sys}".default = true;
    libc."${deps.tempfile."2.2.0".libc}".default = true;
    rand."${deps.tempfile."2.2.0".rand}".default = true;
    redox_syscall."${deps.tempfile."2.2.0".redox_syscall}".default = true;
    tempfile."2.2.0".default = (f.tempfile."2.2.0".default or true);
    winapi."${deps.tempfile."2.2.0".winapi}".default = true;
  }) [
    (features_.rand."${deps."tempfile"."2.2.0"."rand"}" deps)
    (features_.redox_syscall."${deps."tempfile"."2.2.0"."redox_syscall"}" deps)
    (features_.libc."${deps."tempfile"."2.2.0"."libc"}" deps)
    (features_.kernel32_sys."${deps."tempfile"."2.2.0"."kernel32_sys"}" deps)
    (features_.winapi."${deps."tempfile"."2.2.0"."winapi"}" deps)
  ];


  crates.term_size."0.3.1" = deps: { features?(features_.term_size."0.3.1" deps {}) }: buildRustCrate {
    crateName = "term_size";
    version = "0.3.1";
    authors = [ "Kevin K. <kbknapp@gmail.com>" "Benjamin Sago <ogham@bsago.me>" ];
    sha256 = "08gjw2a7igprgw7jjkf8011h320snjqabbn7nhycq924pqyawqw3";
    dependencies = mapFeatures features ([
])
      ++ (if !(kernel == "windows") then mapFeatures features ([
      (crates."libc"."${deps."term_size"."0.3.1"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."term_size"."0.3.1"."kernel32_sys"}" deps)
      (crates."winapi"."${deps."term_size"."0.3.1"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."term_size"."0.3.1" or {});
  };
  features_.term_size."0.3.1" = deps: f: updateFeatures f (rec {
    kernel32_sys."${deps.term_size."0.3.1".kernel32_sys}".default = true;
    libc."${deps.term_size."0.3.1".libc}".default = true;
    term_size = fold recursiveUpdate {} [
      { "0.3.1".clippy =
        (f.term_size."0.3.1".clippy or false) ||
        (f.term_size."0.3.1".lints or false) ||
        (term_size."0.3.1"."lints" or false); }
      { "0.3.1".default = (f.term_size."0.3.1".default or true); }
      { "0.3.1".lints =
        (f.term_size."0.3.1".lints or false) ||
        (f.term_size."0.3.1".travis or false) ||
        (term_size."0.3.1"."travis" or false); }
      { "0.3.1".nightly =
        (f.term_size."0.3.1".nightly or false) ||
        (f.term_size."0.3.1".lints or false) ||
        (term_size."0.3.1"."lints" or false) ||
        (f.term_size."0.3.1".travis or false) ||
        (term_size."0.3.1"."travis" or false); }
    ];
    winapi."${deps.term_size."0.3.1".winapi}".default = true;
  }) [
    (features_.libc."${deps."term_size"."0.3.1"."libc"}" deps)
    (features_.kernel32_sys."${deps."term_size"."0.3.1"."kernel32_sys"}" deps)
    (features_.winapi."${deps."term_size"."0.3.1"."winapi"}" deps)
  ];


  crates.termcolor."1.0.4" = deps: { features?(features_.termcolor."1.0.4" deps {}) }: buildRustCrate {
    crateName = "termcolor";
    version = "1.0.4";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0xydrjc0bxg08llcbcmkka29szdrfklk4vh6l6mdd67ajifqw1mv";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."wincolor"."${deps."termcolor"."1.0.4"."wincolor"}" deps)
    ]) else []);
  };
  features_.termcolor."1.0.4" = deps: f: updateFeatures f (rec {
    termcolor."1.0.4".default = (f.termcolor."1.0.4".default or true);
    wincolor."${deps.termcolor."1.0.4".wincolor}".default = true;
  }) [
    (features_.wincolor."${deps."termcolor"."1.0.4"."wincolor"}" deps)
  ];


  crates.termion."1.5.1" = deps: { features?(features_.termion."1.5.1" deps {}) }: buildRustCrate {
    crateName = "termion";
    version = "1.5.1";
    authors = [ "ticki <Ticki@users.noreply.github.com>" "gycos <alexandre.bury@gmail.com>" "IGI-111 <igi-111@protonmail.com>" ];
    sha256 = "02gq4vd8iws1f3gjrgrgpajsk2bk43nds5acbbb4s8dvrdvr8nf1";
    dependencies = (if !(kernel == "redox") then mapFeatures features ([
      (crates."libc"."${deps."termion"."1.5.1"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."termion"."1.5.1"."redox_syscall"}" deps)
      (crates."redox_termios"."${deps."termion"."1.5.1"."redox_termios"}" deps)
    ]) else []);
  };
  features_.termion."1.5.1" = deps: f: updateFeatures f (rec {
    libc."${deps.termion."1.5.1".libc}".default = true;
    redox_syscall."${deps.termion."1.5.1".redox_syscall}".default = true;
    redox_termios."${deps.termion."1.5.1".redox_termios}".default = true;
    termion."1.5.1".default = (f.termion."1.5.1".default or true);
  }) [
    (features_.libc."${deps."termion"."1.5.1"."libc"}" deps)
    (features_.redox_syscall."${deps."termion"."1.5.1"."redox_syscall"}" deps)
    (features_.redox_termios."${deps."termion"."1.5.1"."redox_termios"}" deps)
  ];


  crates.termios."0.3.1" = deps: { features?(features_.termios."0.3.1" deps {}) }: buildRustCrate {
    crateName = "termios";
    version = "0.3.1";
    authors = [ "David Cuddeback <david.cuddeback@gmail.com>" ];
    sha256 = "1h0fwglrhay85fkbl05ym5gh8hxzl7pyz0a51zfmmngxrf7823c2";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."termios"."0.3.1"."libc"}" deps)
    ]);
  };
  features_.termios."0.3.1" = deps: f: updateFeatures f (rec {
    libc."${deps.termios."0.3.1".libc}".default = true;
    termios."0.3.1".default = (f.termios."0.3.1".default or true);
  }) [
    (features_.libc."${deps."termios"."0.3.1"."libc"}" deps)
  ];


  crates.textwrap."0.10.0" = deps: { features?(features_.textwrap."0.10.0" deps {}) }: buildRustCrate {
    crateName = "textwrap";
    version = "0.10.0";
    authors = [ "Martin Geisler <martin@geisler.net>" ];
    sha256 = "1s8d5cna12smhgj0x2y1xphklyk2an1yzbadnj89p1vy5vnjpsas";
    dependencies = mapFeatures features ([
      (crates."unicode_width"."${deps."textwrap"."0.10.0"."unicode_width"}" deps)
    ]
      ++ (if features.textwrap."0.10.0".term_size or false then [ (crates.term_size."0.3.1" deps) ] else []));
    features = mkFeatures (features."textwrap"."0.10.0" or {});
  };
  features_.textwrap."0.10.0" = deps: f: updateFeatures f (rec {
    term_size."${deps.textwrap."0.10.0".term_size}".default = true;
    textwrap."0.10.0".default = (f.textwrap."0.10.0".default or true);
    unicode_width."${deps.textwrap."0.10.0".unicode_width}".default = true;
  }) [
    (features_.term_size."${deps."textwrap"."0.10.0"."term_size"}" deps)
    (features_.unicode_width."${deps."textwrap"."0.10.0"."unicode_width"}" deps)
  ];


  crates.thread_local."0.3.6" = deps: { features?(features_.thread_local."0.3.6" deps {}) }: buildRustCrate {
    crateName = "thread_local";
    version = "0.3.6";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "02rksdwjmz2pw9bmgbb4c0bgkbq5z6nvg510sq1s6y2j1gam0c7i";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
    ]);
  };
  features_.thread_local."0.3.6" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.thread_local."0.3.6".lazy_static}".default = true;
    thread_local."0.3.6".default = (f.thread_local."0.3.6".default or true);
  }) [
    (features_.lazy_static."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
  ];


  crates.time."0.1.40" = deps: { features?(features_.time."0.1.40" deps {}) }: buildRustCrate {
    crateName = "time";
    version = "0.1.40";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0wgnbjamljz6bqxsd5axc4p2mmhkqfrryj4gf2yswjaxiw5dd01m";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."time"."0.1.40"."libc"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."time"."0.1.40"."redox_syscall"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."time"."0.1.40"."winapi"}" deps)
    ]) else []);
  };
  features_.time."0.1.40" = deps: f: updateFeatures f (rec {
    libc."${deps.time."0.1.40".libc}".default = true;
    redox_syscall."${deps.time."0.1.40".redox_syscall}".default = true;
    time."0.1.40".default = (f.time."0.1.40".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.time."0.1.40".winapi}"."minwinbase" = true; }
      { "${deps.time."0.1.40".winapi}"."minwindef" = true; }
      { "${deps.time."0.1.40".winapi}"."ntdef" = true; }
      { "${deps.time."0.1.40".winapi}"."profileapi" = true; }
      { "${deps.time."0.1.40".winapi}"."std" = true; }
      { "${deps.time."0.1.40".winapi}"."sysinfoapi" = true; }
      { "${deps.time."0.1.40".winapi}"."timezoneapi" = true; }
      { "${deps.time."0.1.40".winapi}".default = true; }
    ];
  }) [
    (features_.libc."${deps."time"."0.1.40"."libc"}" deps)
    (features_.redox_syscall."${deps."time"."0.1.40"."redox_syscall"}" deps)
    (features_.winapi."${deps."time"."0.1.40"."winapi"}" deps)
  ];


  crates.tokio."0.1.13" = deps: { features?(features_.tokio."0.1.13" deps {}) }: buildRustCrate {
    crateName = "tokio";
    version = "0.1.13";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0jm7qky8f39ya6kbdl1m38s5vlih40w41v6bizdrva0n695cmqf2";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio"."0.1.13"."bytes"}" deps)
      (crates."futures"."${deps."tokio"."0.1.13"."futures"}" deps)
      (crates."mio"."${deps."tokio"."0.1.13"."mio"}" deps)
      (crates."num_cpus"."${deps."tokio"."0.1.13"."num_cpus"}" deps)
      (crates."tokio_codec"."${deps."tokio"."0.1.13"."tokio_codec"}" deps)
      (crates."tokio_current_thread"."${deps."tokio"."0.1.13"."tokio_current_thread"}" deps)
      (crates."tokio_executor"."${deps."tokio"."0.1.13"."tokio_executor"}" deps)
      (crates."tokio_fs"."${deps."tokio"."0.1.13"."tokio_fs"}" deps)
      (crates."tokio_io"."${deps."tokio"."0.1.13"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio"."0.1.13"."tokio_reactor"}" deps)
      (crates."tokio_tcp"."${deps."tokio"."0.1.13"."tokio_tcp"}" deps)
      (crates."tokio_threadpool"."${deps."tokio"."0.1.13"."tokio_threadpool"}" deps)
      (crates."tokio_timer"."${deps."tokio"."0.1.13"."tokio_timer"}" deps)
      (crates."tokio_udp"."${deps."tokio"."0.1.13"."tokio_udp"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."tokio_uds"."${deps."tokio"."0.1.13"."tokio_uds"}" deps)
    ]) else []);
    features = mkFeatures (features."tokio"."0.1.13" or {});
  };
  features_.tokio."0.1.13" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio."0.1.13".bytes}".default = true;
    futures."${deps.tokio."0.1.13".futures}".default = true;
    mio."${deps.tokio."0.1.13".mio}".default = true;
    num_cpus."${deps.tokio."0.1.13".num_cpus}".default = true;
    tokio."0.1.13".default = (f.tokio."0.1.13".default or true);
    tokio_codec."${deps.tokio."0.1.13".tokio_codec}".default = true;
    tokio_current_thread."${deps.tokio."0.1.13".tokio_current_thread}".default = true;
    tokio_executor."${deps.tokio."0.1.13".tokio_executor}".default = true;
    tokio_fs."${deps.tokio."0.1.13".tokio_fs}".default = true;
    tokio_io."${deps.tokio."0.1.13".tokio_io}".default = true;
    tokio_reactor."${deps.tokio."0.1.13".tokio_reactor}".default = true;
    tokio_tcp."${deps.tokio."0.1.13".tokio_tcp}".default = true;
    tokio_threadpool."${deps.tokio."0.1.13".tokio_threadpool}".default = true;
    tokio_timer."${deps.tokio."0.1.13".tokio_timer}".default = true;
    tokio_udp."${deps.tokio."0.1.13".tokio_udp}".default = true;
    tokio_uds."${deps.tokio."0.1.13".tokio_uds}".default = true;
  }) [
    (features_.bytes."${deps."tokio"."0.1.13"."bytes"}" deps)
    (features_.futures."${deps."tokio"."0.1.13"."futures"}" deps)
    (features_.mio."${deps."tokio"."0.1.13"."mio"}" deps)
    (features_.num_cpus."${deps."tokio"."0.1.13"."num_cpus"}" deps)
    (features_.tokio_codec."${deps."tokio"."0.1.13"."tokio_codec"}" deps)
    (features_.tokio_current_thread."${deps."tokio"."0.1.13"."tokio_current_thread"}" deps)
    (features_.tokio_executor."${deps."tokio"."0.1.13"."tokio_executor"}" deps)
    (features_.tokio_fs."${deps."tokio"."0.1.13"."tokio_fs"}" deps)
    (features_.tokio_io."${deps."tokio"."0.1.13"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio"."0.1.13"."tokio_reactor"}" deps)
    (features_.tokio_tcp."${deps."tokio"."0.1.13"."tokio_tcp"}" deps)
    (features_.tokio_threadpool."${deps."tokio"."0.1.13"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."tokio"."0.1.13"."tokio_timer"}" deps)
    (features_.tokio_udp."${deps."tokio"."0.1.13"."tokio_udp"}" deps)
    (features_.tokio_uds."${deps."tokio"."0.1.13"."tokio_uds"}" deps)
  ];


  crates.tokio_codec."0.1.1" = deps: { features?(features_.tokio_codec."0.1.1" deps {}) }: buildRustCrate {
    crateName = "tokio-codec";
    version = "0.1.1";
    authors = [ "Carl Lerche <me@carllerche.com>" "Bryan Burgers <bryan@burgers.io>" ];
    sha256 = "0jc9lik540zyj4chbygg1rjh37m3zax8pd4bwcrwjmi1v56qwi4h";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_codec"."0.1.1"."bytes"}" deps)
      (crates."futures"."${deps."tokio_codec"."0.1.1"."futures"}" deps)
      (crates."tokio_io"."${deps."tokio_codec"."0.1.1"."tokio_io"}" deps)
    ]);
  };
  features_.tokio_codec."0.1.1" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_codec."0.1.1".bytes}".default = true;
    futures."${deps.tokio_codec."0.1.1".futures}".default = true;
    tokio_codec."0.1.1".default = (f.tokio_codec."0.1.1".default or true);
    tokio_io."${deps.tokio_codec."0.1.1".tokio_io}".default = true;
  }) [
    (features_.bytes."${deps."tokio_codec"."0.1.1"."bytes"}" deps)
    (features_.futures."${deps."tokio_codec"."0.1.1"."futures"}" deps)
    (features_.tokio_io."${deps."tokio_codec"."0.1.1"."tokio_io"}" deps)
  ];


  crates.tokio_core."0.1.17" = deps: { features?(features_.tokio_core."0.1.17" deps {}) }: buildRustCrate {
    crateName = "tokio-core";
    version = "0.1.17";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1j6c5q3aakvb1hjx4r95xwl5ms8rp19k4qsr6v6ngwbvr6f9z6rs";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_core"."0.1.17"."bytes"}" deps)
      (crates."futures"."${deps."tokio_core"."0.1.17"."futures"}" deps)
      (crates."iovec"."${deps."tokio_core"."0.1.17"."iovec"}" deps)
      (crates."log"."${deps."tokio_core"."0.1.17"."log"}" deps)
      (crates."mio"."${deps."tokio_core"."0.1.17"."mio"}" deps)
      (crates."scoped_tls"."${deps."tokio_core"."0.1.17"."scoped_tls"}" deps)
      (crates."tokio"."${deps."tokio_core"."0.1.17"."tokio"}" deps)
      (crates."tokio_executor"."${deps."tokio_core"."0.1.17"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."tokio_core"."0.1.17"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_core"."0.1.17"."tokio_reactor"}" deps)
      (crates."tokio_timer"."${deps."tokio_core"."0.1.17"."tokio_timer"}" deps)
    ]);
  };
  features_.tokio_core."0.1.17" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_core."0.1.17".bytes}".default = true;
    futures."${deps.tokio_core."0.1.17".futures}".default = true;
    iovec."${deps.tokio_core."0.1.17".iovec}".default = true;
    log."${deps.tokio_core."0.1.17".log}".default = true;
    mio."${deps.tokio_core."0.1.17".mio}".default = true;
    scoped_tls."${deps.tokio_core."0.1.17".scoped_tls}".default = true;
    tokio."${deps.tokio_core."0.1.17".tokio}".default = true;
    tokio_core."0.1.17".default = (f.tokio_core."0.1.17".default or true);
    tokio_executor."${deps.tokio_core."0.1.17".tokio_executor}".default = true;
    tokio_io."${deps.tokio_core."0.1.17".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_core."0.1.17".tokio_reactor}".default = true;
    tokio_timer."${deps.tokio_core."0.1.17".tokio_timer}".default = true;
  }) [
    (features_.bytes."${deps."tokio_core"."0.1.17"."bytes"}" deps)
    (features_.futures."${deps."tokio_core"."0.1.17"."futures"}" deps)
    (features_.iovec."${deps."tokio_core"."0.1.17"."iovec"}" deps)
    (features_.log."${deps."tokio_core"."0.1.17"."log"}" deps)
    (features_.mio."${deps."tokio_core"."0.1.17"."mio"}" deps)
    (features_.scoped_tls."${deps."tokio_core"."0.1.17"."scoped_tls"}" deps)
    (features_.tokio."${deps."tokio_core"."0.1.17"."tokio"}" deps)
    (features_.tokio_executor."${deps."tokio_core"."0.1.17"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio_core"."0.1.17"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_core"."0.1.17"."tokio_reactor"}" deps)
    (features_.tokio_timer."${deps."tokio_core"."0.1.17"."tokio_timer"}" deps)
  ];


  crates.tokio_current_thread."0.1.4" = deps: { features?(features_.tokio_current_thread."0.1.4" deps {}) }: buildRustCrate {
    crateName = "tokio-current-thread";
    version = "0.1.4";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1c92j6pwb7xq4pl9wg2xh4ngms0n59mf575h4x6mlp1jlj3sn2vb";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_current_thread"."0.1.4"."futures"}" deps)
      (crates."tokio_executor"."${deps."tokio_current_thread"."0.1.4"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_current_thread."0.1.4" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_current_thread."0.1.4".futures}".default = true;
    tokio_current_thread."0.1.4".default = (f.tokio_current_thread."0.1.4".default or true);
    tokio_executor."${deps.tokio_current_thread."0.1.4".tokio_executor}".default = true;
  }) [
    (features_.futures."${deps."tokio_current_thread"."0.1.4"."futures"}" deps)
    (features_.tokio_executor."${deps."tokio_current_thread"."0.1.4"."tokio_executor"}" deps)
  ];


  crates.tokio_executor."0.1.5" = deps: { features?(features_.tokio_executor."0.1.5" deps {}) }: buildRustCrate {
    crateName = "tokio-executor";
    version = "0.1.5";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "15j2ybs8w38gncgbxkvp2qsp6wl62ibi3rns0vlwggx7svmx4bf3";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_executor"."0.1.5"."futures"}" deps)
    ]);
  };
  features_.tokio_executor."0.1.5" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_executor."0.1.5".futures}".default = true;
    tokio_executor."0.1.5".default = (f.tokio_executor."0.1.5".default or true);
  }) [
    (features_.futures."${deps."tokio_executor"."0.1.5"."futures"}" deps)
  ];


  crates.tokio_fs."0.1.4" = deps: { features?(features_.tokio_fs."0.1.4" deps {}) }: buildRustCrate {
    crateName = "tokio-fs";
    version = "0.1.4";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "05bpc1p1apb4jfw18i84agwwar57zn07d7smqvslpzagd9b3sd31";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_fs"."0.1.4"."futures"}" deps)
      (crates."tokio_io"."${deps."tokio_fs"."0.1.4"."tokio_io"}" deps)
      (crates."tokio_threadpool"."${deps."tokio_fs"."0.1.4"."tokio_threadpool"}" deps)
    ]);
  };
  features_.tokio_fs."0.1.4" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_fs."0.1.4".futures}".default = true;
    tokio_fs."0.1.4".default = (f.tokio_fs."0.1.4".default or true);
    tokio_io."${deps.tokio_fs."0.1.4".tokio_io}".default = true;
    tokio_threadpool."${deps.tokio_fs."0.1.4".tokio_threadpool}".default = true;
  }) [
    (features_.futures."${deps."tokio_fs"."0.1.4"."futures"}" deps)
    (features_.tokio_io."${deps."tokio_fs"."0.1.4"."tokio_io"}" deps)
    (features_.tokio_threadpool."${deps."tokio_fs"."0.1.4"."tokio_threadpool"}" deps)
  ];


  crates.tokio_io."0.1.10" = deps: { features?(features_.tokio_io."0.1.10" deps {}) }: buildRustCrate {
    crateName = "tokio-io";
    version = "0.1.10";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "14d65rqa5rb2msgkz2xn40cavs4m7f4qyi7vnfv98v7f10l9wlay";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_io"."0.1.10"."bytes"}" deps)
      (crates."futures"."${deps."tokio_io"."0.1.10"."futures"}" deps)
      (crates."log"."${deps."tokio_io"."0.1.10"."log"}" deps)
    ]);
  };
  features_.tokio_io."0.1.10" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_io."0.1.10".bytes}".default = true;
    futures."${deps.tokio_io."0.1.10".futures}".default = true;
    log."${deps.tokio_io."0.1.10".log}".default = true;
    tokio_io."0.1.10".default = (f.tokio_io."0.1.10".default or true);
  }) [
    (features_.bytes."${deps."tokio_io"."0.1.10"."bytes"}" deps)
    (features_.futures."${deps."tokio_io"."0.1.10"."futures"}" deps)
    (features_.log."${deps."tokio_io"."0.1.10"."log"}" deps)
  ];


  crates.tokio_proto."0.1.1" = deps: { features?(features_.tokio_proto."0.1.1" deps {}) }: buildRustCrate {
    crateName = "tokio-proto";
    version = "0.1.1";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "030q9h8pn1ngm80klff5irglxxki60hf5maw0mppmmr46k773z66";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_proto"."0.1.1"."futures"}" deps)
      (crates."log"."${deps."tokio_proto"."0.1.1"."log"}" deps)
      (crates."net2"."${deps."tokio_proto"."0.1.1"."net2"}" deps)
      (crates."rand"."${deps."tokio_proto"."0.1.1"."rand"}" deps)
      (crates."slab"."${deps."tokio_proto"."0.1.1"."slab"}" deps)
      (crates."smallvec"."${deps."tokio_proto"."0.1.1"."smallvec"}" deps)
      (crates."take"."${deps."tokio_proto"."0.1.1"."take"}" deps)
      (crates."tokio_core"."${deps."tokio_proto"."0.1.1"."tokio_core"}" deps)
      (crates."tokio_io"."${deps."tokio_proto"."0.1.1"."tokio_io"}" deps)
      (crates."tokio_service"."${deps."tokio_proto"."0.1.1"."tokio_service"}" deps)
    ]);
  };
  features_.tokio_proto."0.1.1" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_proto."0.1.1".futures}".default = true;
    log."${deps.tokio_proto."0.1.1".log}".default = true;
    net2."${deps.tokio_proto."0.1.1".net2}".default = true;
    rand."${deps.tokio_proto."0.1.1".rand}".default = true;
    slab."${deps.tokio_proto."0.1.1".slab}".default = true;
    smallvec."${deps.tokio_proto."0.1.1".smallvec}".default = true;
    take."${deps.tokio_proto."0.1.1".take}".default = true;
    tokio_core."${deps.tokio_proto."0.1.1".tokio_core}".default = true;
    tokio_io."${deps.tokio_proto."0.1.1".tokio_io}".default = true;
    tokio_proto."0.1.1".default = (f.tokio_proto."0.1.1".default or true);
    tokio_service."${deps.tokio_proto."0.1.1".tokio_service}".default = true;
  }) [
    (features_.futures."${deps."tokio_proto"."0.1.1"."futures"}" deps)
    (features_.log."${deps."tokio_proto"."0.1.1"."log"}" deps)
    (features_.net2."${deps."tokio_proto"."0.1.1"."net2"}" deps)
    (features_.rand."${deps."tokio_proto"."0.1.1"."rand"}" deps)
    (features_.slab."${deps."tokio_proto"."0.1.1"."slab"}" deps)
    (features_.smallvec."${deps."tokio_proto"."0.1.1"."smallvec"}" deps)
    (features_.take."${deps."tokio_proto"."0.1.1"."take"}" deps)
    (features_.tokio_core."${deps."tokio_proto"."0.1.1"."tokio_core"}" deps)
    (features_.tokio_io."${deps."tokio_proto"."0.1.1"."tokio_io"}" deps)
    (features_.tokio_service."${deps."tokio_proto"."0.1.1"."tokio_service"}" deps)
  ];


  crates.tokio_reactor."0.1.7" = deps: { features?(features_.tokio_reactor."0.1.7" deps {}) }: buildRustCrate {
    crateName = "tokio-reactor";
    version = "0.1.7";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1ssrc6gic43lachv7jk97jxzw609sgcsrkwi7chf96sn7nqrhj0z";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_reactor"."0.1.7"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_reactor"."0.1.7"."futures"}" deps)
      (crates."lazy_static"."${deps."tokio_reactor"."0.1.7"."lazy_static"}" deps)
      (crates."log"."${deps."tokio_reactor"."0.1.7"."log"}" deps)
      (crates."mio"."${deps."tokio_reactor"."0.1.7"."mio"}" deps)
      (crates."num_cpus"."${deps."tokio_reactor"."0.1.7"."num_cpus"}" deps)
      (crates."parking_lot"."${deps."tokio_reactor"."0.1.7"."parking_lot"}" deps)
      (crates."slab"."${deps."tokio_reactor"."0.1.7"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_reactor"."0.1.7"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."tokio_reactor"."0.1.7"."tokio_io"}" deps)
    ]);
  };
  features_.tokio_reactor."0.1.7" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_reactor."0.1.7".crossbeam_utils}".default = true;
    futures."${deps.tokio_reactor."0.1.7".futures}".default = true;
    lazy_static."${deps.tokio_reactor."0.1.7".lazy_static}".default = true;
    log."${deps.tokio_reactor."0.1.7".log}".default = true;
    mio."${deps.tokio_reactor."0.1.7".mio}".default = true;
    num_cpus."${deps.tokio_reactor."0.1.7".num_cpus}".default = true;
    parking_lot."${deps.tokio_reactor."0.1.7".parking_lot}".default = true;
    slab."${deps.tokio_reactor."0.1.7".slab}".default = true;
    tokio_executor."${deps.tokio_reactor."0.1.7".tokio_executor}".default = true;
    tokio_io."${deps.tokio_reactor."0.1.7".tokio_io}".default = true;
    tokio_reactor."0.1.7".default = (f.tokio_reactor."0.1.7".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_reactor"."0.1.7"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_reactor"."0.1.7"."futures"}" deps)
    (features_.lazy_static."${deps."tokio_reactor"."0.1.7"."lazy_static"}" deps)
    (features_.log."${deps."tokio_reactor"."0.1.7"."log"}" deps)
    (features_.mio."${deps."tokio_reactor"."0.1.7"."mio"}" deps)
    (features_.num_cpus."${deps."tokio_reactor"."0.1.7"."num_cpus"}" deps)
    (features_.parking_lot."${deps."tokio_reactor"."0.1.7"."parking_lot"}" deps)
    (features_.slab."${deps."tokio_reactor"."0.1.7"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_reactor"."0.1.7"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio_reactor"."0.1.7"."tokio_io"}" deps)
  ];


  crates.tokio_service."0.1.0" = deps: { features?(features_.tokio_service."0.1.0" deps {}) }: buildRustCrate {
    crateName = "tokio-service";
    version = "0.1.0";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0c85wm5qz9fabg0k6k763j89m43n6max72d3a8sxcs940id6qmih";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_service"."0.1.0"."futures"}" deps)
    ]);
  };
  features_.tokio_service."0.1.0" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_service."0.1.0".futures}".default = true;
    tokio_service."0.1.0".default = (f.tokio_service."0.1.0".default or true);
  }) [
    (features_.futures."${deps."tokio_service"."0.1.0"."futures"}" deps)
  ];


  crates.tokio_tcp."0.1.2" = deps: { features?(features_.tokio_tcp."0.1.2" deps {}) }: buildRustCrate {
    crateName = "tokio-tcp";
    version = "0.1.2";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0yvfwybqnyca24aj9as8rgydamjq0wrd9xbxxkjcasvsdmsv6z1d";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_tcp"."0.1.2"."bytes"}" deps)
      (crates."futures"."${deps."tokio_tcp"."0.1.2"."futures"}" deps)
      (crates."iovec"."${deps."tokio_tcp"."0.1.2"."iovec"}" deps)
      (crates."mio"."${deps."tokio_tcp"."0.1.2"."mio"}" deps)
      (crates."tokio_io"."${deps."tokio_tcp"."0.1.2"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_tcp"."0.1.2"."tokio_reactor"}" deps)
    ]);
  };
  features_.tokio_tcp."0.1.2" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_tcp."0.1.2".bytes}".default = true;
    futures."${deps.tokio_tcp."0.1.2".futures}".default = true;
    iovec."${deps.tokio_tcp."0.1.2".iovec}".default = true;
    mio."${deps.tokio_tcp."0.1.2".mio}".default = true;
    tokio_io."${deps.tokio_tcp."0.1.2".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_tcp."0.1.2".tokio_reactor}".default = true;
    tokio_tcp."0.1.2".default = (f.tokio_tcp."0.1.2".default or true);
  }) [
    (features_.bytes."${deps."tokio_tcp"."0.1.2"."bytes"}" deps)
    (features_.futures."${deps."tokio_tcp"."0.1.2"."futures"}" deps)
    (features_.iovec."${deps."tokio_tcp"."0.1.2"."iovec"}" deps)
    (features_.mio."${deps."tokio_tcp"."0.1.2"."mio"}" deps)
    (features_.tokio_io."${deps."tokio_tcp"."0.1.2"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_tcp"."0.1.2"."tokio_reactor"}" deps)
  ];


  crates.tokio_threadpool."0.1.9" = deps: { features?(features_.tokio_threadpool."0.1.9" deps {}) }: buildRustCrate {
    crateName = "tokio-threadpool";
    version = "0.1.9";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0ipr0j79mhjjsvc0ma95sj07m0aiyq6rkwgvlalqwhinivl5d39g";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."tokio_threadpool"."0.1.9"."crossbeam_deque"}" deps)
      (crates."crossbeam_utils"."${deps."tokio_threadpool"."0.1.9"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_threadpool"."0.1.9"."futures"}" deps)
      (crates."log"."${deps."tokio_threadpool"."0.1.9"."log"}" deps)
      (crates."num_cpus"."${deps."tokio_threadpool"."0.1.9"."num_cpus"}" deps)
      (crates."rand"."${deps."tokio_threadpool"."0.1.9"."rand"}" deps)
      (crates."tokio_executor"."${deps."tokio_threadpool"."0.1.9"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_threadpool."0.1.9" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.tokio_threadpool."0.1.9".crossbeam_deque}".default = true;
    crossbeam_utils."${deps.tokio_threadpool."0.1.9".crossbeam_utils}".default = true;
    futures."${deps.tokio_threadpool."0.1.9".futures}".default = true;
    log."${deps.tokio_threadpool."0.1.9".log}".default = true;
    num_cpus."${deps.tokio_threadpool."0.1.9".num_cpus}".default = true;
    rand."${deps.tokio_threadpool."0.1.9".rand}".default = true;
    tokio_executor."${deps.tokio_threadpool."0.1.9".tokio_executor}".default = true;
    tokio_threadpool."0.1.9".default = (f.tokio_threadpool."0.1.9".default or true);
  }) [
    (features_.crossbeam_deque."${deps."tokio_threadpool"."0.1.9"."crossbeam_deque"}" deps)
    (features_.crossbeam_utils."${deps."tokio_threadpool"."0.1.9"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_threadpool"."0.1.9"."futures"}" deps)
    (features_.log."${deps."tokio_threadpool"."0.1.9"."log"}" deps)
    (features_.num_cpus."${deps."tokio_threadpool"."0.1.9"."num_cpus"}" deps)
    (features_.rand."${deps."tokio_threadpool"."0.1.9"."rand"}" deps)
    (features_.tokio_executor."${deps."tokio_threadpool"."0.1.9"."tokio_executor"}" deps)
  ];


  crates.tokio_timer."0.2.8" = deps: { features?(features_.tokio_timer."0.2.8" deps {}) }: buildRustCrate {
    crateName = "tokio-timer";
    version = "0.2.8";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1iqdg6d9780r12n99a8f9q8yrj1sp0l82ly2iza9hx4vxx2dipxv";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_timer"."0.2.8"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_timer"."0.2.8"."futures"}" deps)
      (crates."slab"."${deps."tokio_timer"."0.2.8"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_timer"."0.2.8"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_timer."0.2.8" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_timer."0.2.8".crossbeam_utils}".default = true;
    futures."${deps.tokio_timer."0.2.8".futures}".default = true;
    slab."${deps.tokio_timer."0.2.8".slab}".default = true;
    tokio_executor."${deps.tokio_timer."0.2.8".tokio_executor}".default = true;
    tokio_timer."0.2.8".default = (f.tokio_timer."0.2.8".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_timer"."0.2.8"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_timer"."0.2.8"."futures"}" deps)
    (features_.slab."${deps."tokio_timer"."0.2.8"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_timer"."0.2.8"."tokio_executor"}" deps)
  ];


  crates.tokio_udp."0.1.3" = deps: { features?(features_.tokio_udp."0.1.3" deps {}) }: buildRustCrate {
    crateName = "tokio-udp";
    version = "0.1.3";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1g1x499vqvzwy7xfccr32vwymlx25zpmkx8ppqgifzqwrjnncajf";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_udp"."0.1.3"."bytes"}" deps)
      (crates."futures"."${deps."tokio_udp"."0.1.3"."futures"}" deps)
      (crates."log"."${deps."tokio_udp"."0.1.3"."log"}" deps)
      (crates."mio"."${deps."tokio_udp"."0.1.3"."mio"}" deps)
      (crates."tokio_codec"."${deps."tokio_udp"."0.1.3"."tokio_codec"}" deps)
      (crates."tokio_io"."${deps."tokio_udp"."0.1.3"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_udp"."0.1.3"."tokio_reactor"}" deps)
    ]);
  };
  features_.tokio_udp."0.1.3" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_udp."0.1.3".bytes}".default = true;
    futures."${deps.tokio_udp."0.1.3".futures}".default = true;
    log."${deps.tokio_udp."0.1.3".log}".default = true;
    mio."${deps.tokio_udp."0.1.3".mio}".default = true;
    tokio_codec."${deps.tokio_udp."0.1.3".tokio_codec}".default = true;
    tokio_io."${deps.tokio_udp."0.1.3".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_udp."0.1.3".tokio_reactor}".default = true;
    tokio_udp."0.1.3".default = (f.tokio_udp."0.1.3".default or true);
  }) [
    (features_.bytes."${deps."tokio_udp"."0.1.3"."bytes"}" deps)
    (features_.futures."${deps."tokio_udp"."0.1.3"."futures"}" deps)
    (features_.log."${deps."tokio_udp"."0.1.3"."log"}" deps)
    (features_.mio."${deps."tokio_udp"."0.1.3"."mio"}" deps)
    (features_.tokio_codec."${deps."tokio_udp"."0.1.3"."tokio_codec"}" deps)
    (features_.tokio_io."${deps."tokio_udp"."0.1.3"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_udp"."0.1.3"."tokio_reactor"}" deps)
  ];


  crates.tokio_uds."0.2.4" = deps: { features?(features_.tokio_uds."0.2.4" deps {}) }: buildRustCrate {
    crateName = "tokio-uds";
    version = "0.2.4";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "16cs6wnkm14wzsbn2s5y2skiavw7drjyga5h34w4ffb3ih230vp3";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_uds"."0.2.4"."bytes"}" deps)
      (crates."futures"."${deps."tokio_uds"."0.2.4"."futures"}" deps)
      (crates."iovec"."${deps."tokio_uds"."0.2.4"."iovec"}" deps)
      (crates."libc"."${deps."tokio_uds"."0.2.4"."libc"}" deps)
      (crates."log"."${deps."tokio_uds"."0.2.4"."log"}" deps)
      (crates."mio"."${deps."tokio_uds"."0.2.4"."mio"}" deps)
      (crates."mio_uds"."${deps."tokio_uds"."0.2.4"."mio_uds"}" deps)
      (crates."tokio_codec"."${deps."tokio_uds"."0.2.4"."tokio_codec"}" deps)
      (crates."tokio_io"."${deps."tokio_uds"."0.2.4"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_uds"."0.2.4"."tokio_reactor"}" deps)
    ]);
  };
  features_.tokio_uds."0.2.4" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_uds."0.2.4".bytes}".default = true;
    futures."${deps.tokio_uds."0.2.4".futures}".default = true;
    iovec."${deps.tokio_uds."0.2.4".iovec}".default = true;
    libc."${deps.tokio_uds."0.2.4".libc}".default = true;
    log."${deps.tokio_uds."0.2.4".log}".default = true;
    mio."${deps.tokio_uds."0.2.4".mio}".default = true;
    mio_uds."${deps.tokio_uds."0.2.4".mio_uds}".default = true;
    tokio_codec."${deps.tokio_uds."0.2.4".tokio_codec}".default = true;
    tokio_io."${deps.tokio_uds."0.2.4".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_uds."0.2.4".tokio_reactor}".default = true;
    tokio_uds."0.2.4".default = (f.tokio_uds."0.2.4".default or true);
  }) [
    (features_.bytes."${deps."tokio_uds"."0.2.4"."bytes"}" deps)
    (features_.futures."${deps."tokio_uds"."0.2.4"."futures"}" deps)
    (features_.iovec."${deps."tokio_uds"."0.2.4"."iovec"}" deps)
    (features_.libc."${deps."tokio_uds"."0.2.4"."libc"}" deps)
    (features_.log."${deps."tokio_uds"."0.2.4"."log"}" deps)
    (features_.mio."${deps."tokio_uds"."0.2.4"."mio"}" deps)
    (features_.mio_uds."${deps."tokio_uds"."0.2.4"."mio_uds"}" deps)
    (features_.tokio_codec."${deps."tokio_uds"."0.2.4"."tokio_codec"}" deps)
    (features_.tokio_io."${deps."tokio_uds"."0.2.4"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_uds"."0.2.4"."tokio_reactor"}" deps)
  ];


  crates.try_lock."0.1.0" = deps: { features?(features_.try_lock."0.1.0" deps {}) }: buildRustCrate {
    crateName = "try-lock";
    version = "0.1.0";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0kfrqrb2xkjig54s3qfy80dpldknr19p3rmp0n82yk5929j879k3";
  };
  features_.try_lock."0.1.0" = deps: f: updateFeatures f (rec {
    try_lock."0.1.0".default = (f.try_lock."0.1.0".default or true);
  }) [];


  crates.ucd_util."0.1.3" = deps: { features?(features_.ucd_util."0.1.3" deps {}) }: buildRustCrate {
    crateName = "ucd-util";
    version = "0.1.3";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1n1qi3jywq5syq90z9qd8qzbn58pcjgv1sx4sdmipm4jf9zanz15";
  };
  features_.ucd_util."0.1.3" = deps: f: updateFeatures f (rec {
    ucd_util."0.1.3".default = (f.ucd_util."0.1.3".default or true);
  }) [];


  crates.unicase."2.2.0" = deps: { features?(features_.unicase."2.2.0" deps {}) }: buildRustCrate {
    crateName = "unicase";
    version = "2.2.0";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0p8fj4rdjk9k15s552bl6vpidjcf4jzddzkz6vgagb2i84xlvfxc";
    build = "build.rs";

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."unicase"."2.2.0"."version_check"}" deps)
    ]);
    features = mkFeatures (features."unicase"."2.2.0" or {});
  };
  features_.unicase."2.2.0" = deps: f: updateFeatures f (rec {
    unicase."2.2.0".default = (f.unicase."2.2.0".default or true);
    version_check."${deps.unicase."2.2.0".version_check}".default = true;
  }) [
    (features_.version_check."${deps."unicase"."2.2.0"."version_check"}" deps)
  ];


  crates.unicode_width."0.1.5" = deps: { features?(features_.unicode_width."0.1.5" deps {}) }: buildRustCrate {
    crateName = "unicode-width";
    version = "0.1.5";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "0886lc2aymwgy0lhavwn6s48ik3c61ykzzd3za6prgnw51j7bi4w";
    features = mkFeatures (features."unicode_width"."0.1.5" or {});
  };
  features_.unicode_width."0.1.5" = deps: f: updateFeatures f (rec {
    unicode_width."0.1.5".default = (f.unicode_width."0.1.5".default or true);
  }) [];


  crates.unicode_xid."0.1.0" = deps: { features?(features_.unicode_xid."0.1.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.1.0";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "05wdmwlfzxhq3nhsxn6wx4q8dhxzzfb9szsz6wiw092m1rjj01zj";
    features = mkFeatures (features."unicode_xid"."0.1.0" or {});
  };
  features_.unicode_xid."0.1.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.1.0".default = (f.unicode_xid."0.1.0".default or true);
  }) [];


  crates.unreachable."1.0.0" = deps: { features?(features_.unreachable."1.0.0" deps {}) }: buildRustCrate {
    crateName = "unreachable";
    version = "1.0.0";
    authors = [ "Jonathan Reem <jonathan.reem@gmail.com>" ];
    sha256 = "1am8czbk5wwr25gbp2zr007744fxjshhdqjz9liz7wl4pnv3whcf";
    dependencies = mapFeatures features ([
      (crates."void"."${deps."unreachable"."1.0.0"."void"}" deps)
    ]);
  };
  features_.unreachable."1.0.0" = deps: f: updateFeatures f (rec {
    unreachable."1.0.0".default = (f.unreachable."1.0.0".default or true);
    void."${deps.unreachable."1.0.0".void}".default = (f.void."${deps.unreachable."1.0.0".void}".default or false);
  }) [
    (features_.void."${deps."unreachable"."1.0.0"."void"}" deps)
  ];


  crates.utf8_ranges."1.0.2" = deps: { features?(features_.utf8_ranges."1.0.2" deps {}) }: buildRustCrate {
    crateName = "utf8-ranges";
    version = "1.0.2";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1my02laqsgnd8ib4dvjgd4rilprqjad6pb9jj9vi67csi5qs2281";
  };
  features_.utf8_ranges."1.0.2" = deps: f: updateFeatures f (rec {
    utf8_ranges."1.0.2".default = (f.utf8_ranges."1.0.2".default or true);
  }) [];


  crates.version_check."0.1.5" = deps: { features?(features_.version_check."0.1.5" deps {}) }: buildRustCrate {
    crateName = "version_check";
    version = "0.1.5";
    authors = [ "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "1yrx9xblmwbafw2firxyqbj8f771kkzfd24n3q7xgwiqyhi0y8qd";
  };
  features_.version_check."0.1.5" = deps: f: updateFeatures f (rec {
    version_check."0.1.5".default = (f.version_check."0.1.5".default or true);
  }) [];


  crates.void."1.0.2" = deps: { features?(features_.void."1.0.2" deps {}) }: buildRustCrate {
    crateName = "void";
    version = "1.0.2";
    authors = [ "Jonathan Reem <jonathan.reem@gmail.com>" ];
    sha256 = "0h1dm0dx8dhf56a83k68mijyxigqhizpskwxfdrs1drwv2cdclv3";
    features = mkFeatures (features."void"."1.0.2" or {});
  };
  features_.void."1.0.2" = deps: f: updateFeatures f (rec {
    void = fold recursiveUpdate {} [
      { "1.0.2".default = (f.void."1.0.2".default or true); }
      { "1.0.2".std =
        (f.void."1.0.2".std or false) ||
        (f.void."1.0.2".default or false) ||
        (void."1.0.2"."default" or false); }
    ];
  }) [];


  crates.want."0.0.4" = deps: { features?(features_.want."0.0.4" deps {}) }: buildRustCrate {
    crateName = "want";
    version = "0.0.4";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1l1qy4pvg5q71nrzfjldw9xzqhhgicj4slly1bal89hr2aaibpy0";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."want"."0.0.4"."futures"}" deps)
      (crates."log"."${deps."want"."0.0.4"."log"}" deps)
      (crates."try_lock"."${deps."want"."0.0.4"."try_lock"}" deps)
    ]);
  };
  features_.want."0.0.4" = deps: f: updateFeatures f (rec {
    futures."${deps.want."0.0.4".futures}".default = true;
    log."${deps.want."0.0.4".log}".default = true;
    try_lock."${deps.want."0.0.4".try_lock}".default = true;
    want."0.0.4".default = (f.want."0.0.4".default or true);
  }) [
    (features_.futures."${deps."want"."0.0.4"."futures"}" deps)
    (features_.log."${deps."want"."0.0.4"."log"}" deps)
    (features_.try_lock."${deps."want"."0.0.4"."try_lock"}" deps)
  ];


  crates.winapi."0.2.8" = deps: { features?(features_.winapi."0.2.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.2.8";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0a45b58ywf12vb7gvj6h3j264nydynmzyqz8d8rqxsj6icqv82as";
  };
  features_.winapi."0.2.8" = deps: f: updateFeatures f (rec {
    winapi."0.2.8".default = (f.winapi."0.2.8".default or true);
  }) [];


  crates.winapi."0.3.6" = deps: { features?(features_.winapi."0.3.6" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.3.6";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1d9jfp4cjd82sr1q4dgdlrkvm33zhhav9d7ihr0nivqbncr059m4";
    build = "build.rs";
    dependencies = (if kernel == "i686-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_i686_pc_windows_gnu"."${deps."winapi"."0.3.6"."winapi_i686_pc_windows_gnu"}" deps)
    ]) else [])
      ++ (if kernel == "x86_64-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_x86_64_pc_windows_gnu"."${deps."winapi"."0.3.6"."winapi_x86_64_pc_windows_gnu"}" deps)
    ]) else []);
    features = mkFeatures (features."winapi"."0.3.6" or {});
  };
  features_.winapi."0.3.6" = deps: f: updateFeatures f (rec {
    winapi."0.3.6".default = (f.winapi."0.3.6".default or true);
    winapi_i686_pc_windows_gnu."${deps.winapi."0.3.6".winapi_i686_pc_windows_gnu}".default = true;
    winapi_x86_64_pc_windows_gnu."${deps.winapi."0.3.6".winapi_x86_64_pc_windows_gnu}".default = true;
  }) [
    (features_.winapi_i686_pc_windows_gnu."${deps."winapi"."0.3.6"."winapi_i686_pc_windows_gnu"}" deps)
    (features_.winapi_x86_64_pc_windows_gnu."${deps."winapi"."0.3.6"."winapi_x86_64_pc_windows_gnu"}" deps)
  ];


  crates.winapi_build."0.1.1" = deps: { features?(features_.winapi_build."0.1.1" deps {}) }: buildRustCrate {
    crateName = "winapi-build";
    version = "0.1.1";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lxlpi87rkhxcwp2ykf1ldw3p108hwm24nywf3jfrvmff4rjhqga";
    libName = "build";
  };
  features_.winapi_build."0.1.1" = deps: f: updateFeatures f (rec {
    winapi_build."0.1.1".default = (f.winapi_build."0.1.1".default or true);
  }) [];


  crates.winapi_i686_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_i686_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "05ihkij18r4gamjpxj4gra24514can762imjzlmak5wlzidplzrp";
    build = "build.rs";
  };
  features_.winapi_i686_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_i686_pc_windows_gnu."0.4.0".default = (f.winapi_i686_pc_windows_gnu."0.4.0".default or true);
  }) [];


  crates.winapi_util."0.1.1" = deps: { features?(features_.winapi_util."0.1.1" deps {}) }: buildRustCrate {
    crateName = "winapi-util";
    version = "0.1.1";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "10madanla73aagbklx6y73r2g2vwq9w8a0qcghbbbpn9vfr6a95f";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."winapi_util"."0.1.1"."winapi"}" deps)
    ]) else []);
  };
  features_.winapi_util."0.1.1" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.winapi_util."0.1.1".winapi}"."consoleapi" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."errhandlingapi" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."fileapi" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."minwindef" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."processenv" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."std" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."winbase" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."wincon" = true; }
      { "${deps.winapi_util."0.1.1".winapi}"."winerror" = true; }
      { "${deps.winapi_util."0.1.1".winapi}".default = true; }
    ];
    winapi_util."0.1.1".default = (f.winapi_util."0.1.1".default or true);
  }) [
    (features_.winapi."${deps."winapi_util"."0.1.1"."winapi"}" deps)
  ];


  crates.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_x86_64_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0n1ylmlsb8yg1v583i4xy0qmqg42275flvbc51hdqjjfjcl9vlbj";
    build = "build.rs";
  };
  features_.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_x86_64_pc_windows_gnu."0.4.0".default = (f.winapi_x86_64_pc_windows_gnu."0.4.0".default or true);
  }) [];


  crates.wincolor."1.0.1" = deps: { features?(features_.wincolor."1.0.1" deps {}) }: buildRustCrate {
    crateName = "wincolor";
    version = "1.0.1";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0gr7v4krmjba7yq16071rfacz42qbapas7mxk5nphjwb042a8gvz";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."wincolor"."1.0.1"."winapi"}" deps)
      (crates."winapi_util"."${deps."wincolor"."1.0.1"."winapi_util"}" deps)
    ]);
  };
  features_.wincolor."1.0.1" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.wincolor."1.0.1".winapi}"."minwindef" = true; }
      { "${deps.wincolor."1.0.1".winapi}"."wincon" = true; }
      { "${deps.wincolor."1.0.1".winapi}".default = true; }
    ];
    winapi_util."${deps.wincolor."1.0.1".winapi_util}".default = true;
    wincolor."1.0.1".default = (f.wincolor."1.0.1".default or true);
  }) [
    (features_.winapi."${deps."wincolor"."1.0.1"."winapi"}" deps)
    (features_.winapi_util."${deps."wincolor"."1.0.1"."winapi_util"}" deps)
  ];


  crates.ws2_32_sys."0.2.1" = deps: { features?(features_.ws2_32_sys."0.2.1" deps {}) }: buildRustCrate {
    crateName = "ws2_32-sys";
    version = "0.2.1";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1zpy9d9wk11sj17fczfngcj28w4xxjs3b4n036yzpy38dxp4f7kc";
    libName = "ws2_32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
    ]);
  };
  features_.ws2_32_sys."0.2.1" = deps: f: updateFeatures f (rec {
    winapi."${deps.ws2_32_sys."0.2.1".winapi}".default = true;
    winapi_build."${deps.ws2_32_sys."0.2.1".winapi_build}".default = true;
    ws2_32_sys."0.2.1".default = (f.ws2_32_sys."0.2.1".default or true);
  }) [
    (features_.winapi."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    (features_.winapi_build."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
  ];


  crates.yaml_rust."0.4.2" = deps: { features?(features_.yaml_rust."0.4.2" deps {}) }: buildRustCrate {
    crateName = "yaml-rust";
    version = "0.4.2";
    authors = [ "Yuheng Chen <yuhengchen@sensetime.com>" ];
    sha256 = "1bxc5hhky8rk5r8hrv4ynppsfkivq07jbj458i3h8zkhc1ca33lk";
    dependencies = mapFeatures features ([
      (crates."linked_hash_map"."${deps."yaml_rust"."0.4.2"."linked_hash_map"}" deps)
    ]);
  };
  features_.yaml_rust."0.4.2" = deps: f: updateFeatures f (rec {
    linked_hash_map."${deps.yaml_rust."0.4.2".linked_hash_map}".default = true;
    yaml_rust."0.4.2".default = (f.yaml_rust."0.4.2".default or true);
  }) [
    (features_.linked_hash_map."${deps."yaml_rust"."0.4.2"."linked_hash_map"}" deps)
  ];


}
